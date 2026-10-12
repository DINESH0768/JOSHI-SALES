import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' show OrderingTerm;
import '../../../core/theme/app_colors.dart';
import '../../../data/db/app_database.dart';

class UdharListScreen extends StatefulWidget {
  final AppDatabase db;

  const UdharListScreen({super.key, required this.db});

  @override
  State<UdharListScreen> createState() => _UdharListScreenState();
}

class _UdharListScreenState extends State<UdharListScreen> {
  final _searchController = TextEditingController();
  List<UdharCustomersTableData> _customers = [];
  Map<String, Map<String, int>> _customerStats = {}; // custId -> {'slips': count, 'baki': total}
  int _totalUdharBaki = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
    _searchController.addListener(_filterData);
  }

  Future<void> _loadData() async {
    final custs = await (widget.db.select(widget.db.udharCustomersTable)
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();

    final allUdharSlips = await (widget.db.select(widget.db.slipsTable)
          ..where((t) => t.status.equals('udhar'))
          ..where((t) => t.deletedAt.isNull()))
        .get();

    final stats = <String, Map<String, int>>{};
    int grandTotal = 0;

    for (var s in allUdharSlips) {
      if (s.udharCustomerId != null) {
        final cid = s.udharCustomerId!;
        final curr = stats.putIfAbsent(cid, () => {'slips': 0, 'baki': 0});
        curr['slips'] = curr['slips']! + 1;
        curr['baki'] = curr['baki']! + s.charge;
        grandTotal += s.charge;
      }
    }

    if (mounted) {
      setState(() {
        _customers = custs;
        _customerStats = stats;
        _totalUdharBaki = grandTotal;
        _isLoading = false;
      });
    }
  }

  void _filterData() {
    setState(() {});
  }

  List<UdharCustomersTableData> _getFilteredCustomers() {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return _customers;
    return _customers.where((c) => c.name.toLowerCase().contains(query)).toList();
  }

  Future<void> _addCustomerDialog() async {
    final textCtrl = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: const Text('Naya customer', style: TextStyle(color: AppColors.text, fontSize: 16)),
          content: TextField(
            controller: textCtrl,
            style: const TextStyle(color: AppColors.text),
            decoration: const InputDecoration(
              hintText: 'Customer ka naam',
              hintStyle: TextStyle(color: AppColors.muted),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: AppColors.muted)),
            ),
            TextButton(
              onPressed: () async {
                final name = textCtrl.text.trim();
                if (name.isNotEmpty) {
                  final cid = 'udhar_${DateTime.now().millisecondsSinceEpoch}';
                  await widget.db.into(widget.db.udharCustomersTable).insert(
                        UdharCustomersTableCompanion.insert(
                          id: cid,
                          name: name,
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        ),
                      );
                  if (context.mounted) Navigator.pop(context);
                  _loadData();
                }
              },
              child: const Text('Jodo', style: TextStyle(color: AppColors.lime, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.bg,
        body: Center(child: CircularProgressIndicator(color: AppColors.lime)),
      );
    }

    final filtered = _getFilteredCustomers();

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // Header (.hd)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                children: [
                  const Text('Udhar khata', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  GestureDetector(
                    onTap: _addCustomerDialog,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.lime,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.add_rounded, color: AppColors.onLime, size: 16),
                          SizedBox(width: 4),
                          Text('Naya customer', style: TextStyle(color: AppColors.onLime, fontSize: 12, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Total Udhar Card (.card udhar blue)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF12183A),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFF2A3570), width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Kul udhar baki', style: TextStyle(color: AppColors.upiBlue, fontSize: 11)),
                    const SizedBox(height: 2),
                    Text('₹$_totalUdharBaki', style: const TextStyle(color: AppColors.text, fontSize: 30, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text('${_customers.length} customer', style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search_rounded, color: AppColors.muted, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(color: AppColors.text, fontSize: 13),
                        decoration: const InputDecoration(
                          hintText: 'Customer ka naam dhoondho',
                          hintStyle: TextStyle(color: AppColors.muted, fontSize: 12),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Customer List
            Expanded(
              child: filtered.isEmpty
                  ? const Center(child: Text('Koi udhar customer nahi hai', style: TextStyle(color: AppColors.muted)))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final cust = filtered[index];
                        final stat = _customerStats[cust.id] ?? {'slips': 0, 'baki': 0};
                        final slipsCount = stat['slips']!;
                        final bakiAmount = stat['baki']!;

                        return GestureDetector(
                          onTap: () => context.push('/udhar/customer/${cust.id}'),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.border, width: 0.5),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF12183A),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.person_outline_rounded, color: AppColors.upiBlue, size: 18),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(cust.name, style: const TextStyle(color: AppColors.text, fontSize: 14, fontWeight: FontWeight.w600)),
                                      Text('$slipsCount slips · ₹50 per slip approx', style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('₹$bakiAmount', style: const TextStyle(color: AppColors.upiBlue, fontSize: 14, fontWeight: FontWeight.bold)),
                                    const Text('baki', style: TextStyle(color: AppColors.muted, fontSize: 10)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
