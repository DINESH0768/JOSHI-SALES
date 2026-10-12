import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' show OrderingTerm;
import '../../../core/theme/app_colors.dart';
import '../../../data/db/app_database.dart';
import '../domain/services/udhar_service.dart';

class CustomerDetailScreen extends StatefulWidget {
  final String customerId;
  final AppDatabase db;

  const CustomerDetailScreen({super.key, required this.customerId, required this.db});

  @override
  State<CustomerDetailScreen> createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  late UdharService _udharService;
  UdharCustomersTableData? _customer;
  List<SlipsTableData> _unpaidSlips = [];
  List<PaymentsTableData> _paymentsHistory = [];
  int _totalBaki = 0;
  bool _isLoading = true;

  final _jamaAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _udharService = UdharService(widget.db);
    _loadData();
  }

  Future<void> _loadData() async {
    final cust = await (widget.db.select(widget.db.udharCustomersTable)
          ..where((t) => t.id.equals(widget.customerId)))
        .getSingleOrNull();

    final slips = await (widget.db.select(widget.db.slipsTable)
          ..where((t) => t.udharCustomerId.equals(widget.customerId))
          ..where((t) => t.status.equals('udhar'))
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .get();

    final payments = await (widget.db.select(widget.db.paymentsTable)
          ..where((t) => t.udharCustomerId.equals(widget.customerId))
          ..orderBy([(t) => OrderingTerm.desc(t.receivedAt)]))
        .get();

    final baki = slips.fold(0, (sum, s) => sum + s.charge);

    if (mounted) {
      setState(() {
        _customer = cust;
        _unpaidSlips = slips;
        _paymentsHistory = payments;
        _totalBaki = baki;
        _isLoading = false;
        _jamaAmountController.text = baki > 0 ? '500' : '0';
      });
    }
  }

  Future<void> _onJamaKaro(String mode) async {
    final amt = int.tryParse(_jamaAmountController.text) ?? 0;
    if (amt <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Jama amount likho')));
      return;
    }

    final paymentId = await _udharService.recordJamaPayment(
      customerId: widget.customerId,
      amount: amt,
      mode: mode,
    );

    if (mounted) {
      context.push('/udhar/rasid/$paymentId');
    }
  }

  Future<void> _onPooraHisaab(String mode) async {
    final paymentId = await _udharService.pooraHisaabSettle(
      customerId: widget.customerId,
      mode: mode,
    );

    if (mounted) {
      context.push('/udhar/rasid/$paymentId');
    }
  }

  void _showJamaModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('${_customer?.name ?? ""} - Jama karo', style: const TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: TextField(
                  controller: _jamaAmountController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: AppColors.text, fontSize: 18, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    prefixText: '₹ ',
                    prefixStyle: TextStyle(color: AppColors.lime, fontSize: 18, fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _onJamaKaro('cash');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.lime,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        child: const Text('Cash mein jama', style: TextStyle(color: AppColors.onLime, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _onJamaKaro('upi');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.surface3,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        child: const Text('UPI se jama', style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
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
                  Text(_customer?.name ?? 'Customer', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.udharBlueBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('Udhar', style: TextStyle(color: AppColors.udharBlueFg, fontSize: 11, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Summary Card (.card udhar)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF12183A),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFF2A3570), width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Abhi baki', style: TextStyle(color: AppColors.upiBlue, fontSize: 11)),
                    const SizedBox(height: 2),
                    Text('₹$_totalBaki', style: const TextStyle(color: AppColors.text, fontSize: 30, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text('${_unpaidSlips.length} slips · ₹50 per slip', style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Action buttons row
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _showJamaModal,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.lime,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        child: const Text('Jama karo', style: TextStyle(color: AppColors.onLime, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _onPooraHisaab('cash'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.surface3,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        alignment: Alignment.center,
                        child: const Text('Poora hisaab', style: TextStyle(color: AppColors.text, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Unpaid Slips List
              const Text('Unpaid slips (purani pehle)', style: TextStyle(color: AppColors.muted, fontSize: 12, fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: _unpaidSlips.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text('Koi udhar slip baki nahi hai', textAlign: TextAlign.center, style: TextStyle(color: AppColors.muted)),
                      )
                    : Column(
                        children: _unpaidSlips.map((s) {
                          final dateStr = DateFormat('dd MMM yyyy').format(s.date);
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
                            ),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Slip #${s.receiptNo} · ${s.vehicleNo ?? "No gaadi"}', style: const TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.w500)),
                                    Text(dateStr, style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                                  ],
                                ),
                                const Spacer(),
                                Text('₹${s.charge}', style: const TextStyle(color: AppColors.upiBlue, fontSize: 13, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
              ),

              const SizedBox(height: 14),

              // Payment History
              if (_paymentsHistory.isNotEmpty) ...[
                const Text('Jama history', style: TextStyle(color: AppColors.muted, fontSize: 12, fontWeight: FontWeight.w500)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.surface2,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: _paymentsHistory.map((p) {
                      final dateStr = DateFormat('dd MMM yyyy, hh:mm a').format(p.receivedAt);
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${p.receiptNo ?? "Jama"} · ${p.mode.toUpperCase()}', style: const TextStyle(color: AppColors.lime, fontSize: 13, fontWeight: FontWeight.w500)),
                                Text(dateStr, style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                              ],
                            ),
                            const Spacer(),
                            Text('+₹${p.amount}', style: const TextStyle(color: AppColors.lime, fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
