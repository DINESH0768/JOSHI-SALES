import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/db/app_database.dart';
import '../domain/services/supplier_service.dart';

class SupplierListScreen extends StatefulWidget {
  final AppDatabase db;

  const SupplierListScreen({super.key, required this.db});

  @override
  State<SupplierListScreen> createState() => _SupplierListScreenState();
}

class _SupplierListScreenState extends State<SupplierListScreen> {
  late SupplierService _supplierService;
  List<SuppliersTableData> _suppliers = [];
  Map<String, int> _balances = {};
  int _totalDenaBaki = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _supplierService = SupplierService(widget.db);
    _loadSuppliers();
  }

  Future<void> _loadSuppliers() async {
    final list = await _supplierService.getAllSuppliers();
    final Map<String, int> map = {};
    int total = 0;

    for (final s in list) {
      final bal = await _supplierService.getSupplierBalance(s.id);
      map[s.id] = bal;
      if (bal > 0) total += bal;
    }

    if (mounted) {
      setState(() {
        _suppliers = list;
        _balances = map;
        _totalDenaBaki = total;
        _isLoading = false;
      });
    }
  }

  void _showAddSupplierModal() {
    final nameController = TextEditingController();
    final catController = TextEditingController(text: 'Chai wale');
    final rateController = TextEditingController(text: '10');
    final unitController = TextEditingController(text: 'chai');

    String? nameError;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Naya supplier jodein', style: TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, color: AppColors.muted),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Name
                    const Text('Supplier Name *', style: TextStyle(color: AppColors.muted, fontSize: 11)),
                    const SizedBox(height: 4),
                    TextField(
                      controller: nameController,
                      style: const TextStyle(color: AppColors.text, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'e.g. Bhanwar Lal ji',
                        hintStyle: const TextStyle(color: AppColors.muted),
                        filled: true,
                        fillColor: AppColors.surface,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: const BorderSide(color: AppColors.lime, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: const BorderSide(color: AppColors.lime, width: 2),
                        ),
                        errorText: nameError,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Category
                    const Text('Category', style: TextStyle(color: AppColors.muted, fontSize: 11)),
                    const SizedBox(height: 4),
                    TextField(
                      controller: catController,
                      style: const TextStyle(color: AppColors.text, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'e.g. Chai wale, Bijli wale',
                        hintStyle: const TextStyle(color: AppColors.muted),
                        filled: true,
                        fillColor: AppColors.surface,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: const BorderSide(color: AppColors.border, width: 0.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Rate & Unit
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Rate (₹)', style: TextStyle(color: AppColors.muted, fontSize: 11)),
                              const SizedBox(height: 4),
                              TextField(
                                controller: rateController,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(color: AppColors.text, fontSize: 14),
                                decoration: InputDecoration(
                                  hintText: '10',
                                  filled: true,
                                  fillColor: AppColors.surface,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: const BorderSide(color: AppColors.border, width: 0.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Unit Name', style: TextStyle(color: AppColors.muted, fontSize: 11)),
                              const SizedBox(height: 4),
                              TextField(
                                controller: unitController,
                                style: const TextStyle(color: AppColors.text, fontSize: 14),
                                decoration: InputDecoration(
                                  hintText: 'chai',
                                  filled: true,
                                  fillColor: AppColors.surface,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13),
                                    borderSide: const BorderSide(color: AppColors.border, width: 0.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lime,
                        foregroundColor: AppColors.onLime,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: () async {
                        final name = nameController.text.trim();
                        if (name.isEmpty) {
                          setModalState(() => nameError = 'Naam likho');
                          return;
                        }

                        final nav = Navigator.of(ctx);
                        final rate = int.tryParse(rateController.text.trim());

                        await _supplierService.createSupplier(
                          name: name,
                          category: catController.text.trim().isEmpty ? null : catController.text.trim(),
                          ratePerUnit: rate,
                          unitName: unitController.text.trim().isEmpty ? null : unitController.text.trim(),
                        );

                        nav.pop();
                        if (mounted) _loadSuppliers();
                      },
                      child: const Text('Supplier jodein', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header (.hd)
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (Navigator.canPop(context)) Navigator.pop(context);
                    },
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(color: AppColors.border, width: 0.5),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.chevron_left_rounded, color: AppColors.text, size: 20),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text('Supplier khata', style: TextStyle(color: AppColors.text, fontSize: 15, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.expenseBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('Humein dena hai', style: TextStyle(color: AppColors.expense, fontSize: 11, fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Total Dena Baki Card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total dena baki', style: TextStyle(color: AppColors.muted, fontSize: 11)),
                    const SizedBox(height: 2),
                    Text('₹$_totalDenaBaki', style: const TextStyle(color: AppColors.expense, fontSize: 30, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // "+ Naya supplier" Button
              GestureDetector(
                onTap: _showAddSupplierModal,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.lime,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_rounded, color: AppColors.onLime, size: 18),
                      SizedBox(width: 6),
                      Text('Naya supplier', style: TextStyle(color: AppColors.onLime, fontSize: 13, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Supplier List (.s2)
              if (_isLoading)
                const Center(child: CircularProgressIndicator(color: AppColors.lime))
              else if (_suppliers.isEmpty)
                Container(
                  padding: const EdgeInsets.all(24),
                  alignment: Alignment.center,
                  child: const Text('Koi supplier nahi hai', style: TextStyle(color: AppColors.muted, fontSize: 12)),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.surface2,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: _suppliers.map((s) {
                      final bal = _balances[s.id] ?? 0;
                      final subText = '${s.category ?? 'Supplier'}${s.ratePerUnit != null ? ' · ₹${s.ratePerUnit} / ${s.unitName ?? 'unit'}' : ''}';

                      return GestureDetector(
                        onTap: () => context.push('/kharcha/suppliers/${s.id}'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF2B24A),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: const Icon(Icons.local_cafe_rounded, color: Color(0xFF3A2600), size: 20),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(s.name, style: const TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.bold)),
                                    Text(subText, style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '₹$bal',
                                    style: const TextStyle(color: AppColors.expense, fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  const Text('dena baki', style: TextStyle(color: AppColors.muted, fontSize: 10)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
