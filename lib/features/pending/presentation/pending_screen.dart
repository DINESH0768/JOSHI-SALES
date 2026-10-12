import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' show OrderingTerm;
import '../../../core/theme/app_colors.dart';
import '../../../data/db/app_database.dart';
import '../../payments/domain/services/payment_service.dart';

class PendingScreen extends StatefulWidget {
  final AppDatabase db;

  const PendingScreen({super.key, required this.db});

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  late PaymentService _paymentService;
  List<SlipsTableData> _pendingSlips = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _paymentService = PaymentService(widget.db);
    _loadPendingSlips();
  }

  Future<void> _loadPendingSlips() async {
    final list = await (widget.db.select(widget.db.slipsTable)
          ..where((t) => t.status.equals('pending'))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();

    if (mounted) {
      setState(() {
        _pendingSlips = list;
        _isLoading = false;
      });
    }
  }

  int _calculateTotalPending() {
    return _pendingSlips.fold(0, (sum, s) => sum + s.charge);
  }

  Map<String, List<SlipsTableData>> _groupByParty() {
    final map = <String, List<SlipsTableData>>{};
    for (var slip in _pendingSlips) {
      final key = slip.customerName?.trim().isNotEmpty == true
          ? slip.customerName!.trim()
          : (slip.vehicleNo ?? 'Unassigned');
      map.putIfAbsent(key, () => []).add(slip);
    }
    return map;
  }

  Future<void> _onMarkReceived(SlipsTableData slip) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Slip #${slip.receiptNo} - ₹${slip.charge} mila?',
                style: const TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        await _paymentService.recordCashPayment(slipId: slip.id, amount: slip.charge.toDouble());
                        _loadPendingSlips();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.limeTintBg,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.limeTintBorder, width: 1),
                        ),
                        alignment: Alignment.center,
                        child: const Text('Cash', style: TextStyle(color: AppColors.lime, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        await _paymentService.recordUpiPayment(slipId: slip.id, amount: slip.charge.toDouble());
                        _loadPendingSlips();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: AppColors.upiBg,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.upiBorder, width: 1),
                        ),
                        alignment: Alignment.center,
                        child: const Text('UPI', style: TextStyle(color: AppColors.upiBlue, fontWeight: FontWeight.bold)),
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

  Future<void> _onMoveToUdhar(SlipsTableData slip) async {
    final partyName = slip.customerName ?? 'Customer';
    await _paymentService.allocateToUdhar(slipId: slip.id, customerName: partyName);
    _loadPendingSlips();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.bg,
        body: Center(child: CircularProgressIndicator(color: AppColors.lime)),
      );
    }

    final totalAmount = _calculateTotalPending();
    final grouped = _groupByParty();

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header (.hd)
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text('Pending', style: TextStyle(color: AppColors.text, fontSize: 18, fontWeight: FontWeight.bold)),
              ),

              // Summary Dark Orange Card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A1D0A),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFF5A3D12), width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Kul pending', style: TextStyle(color: Color(0xFFF2B24A), fontSize: 11)),
                    const SizedBox(height: 2),
                    Text('₹$totalAmount', style: const TextStyle(color: AppColors.text, fontSize: 30, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 2),
                    Text('${_pendingSlips.length} slips · ${grouped.length} party', style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Grouped Parties List
              if (_pendingSlips.isEmpty)
                Container(
                  padding: const EdgeInsets.all(30),
                  alignment: Alignment.center,
                  child: const Column(
                    children: [
                      Icon(Icons.check_circle_outline_rounded, size: 40, color: AppColors.lime),
                      SizedBox(height: 8),
                      Text('Koi pending slip nahi hai!', style: TextStyle(color: AppColors.muted, fontSize: 13)),
                    ],
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surface2,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: grouped.entries.map((entry) {
                      final party = entry.key;
                      final slips = entry.value;
                      final partyTotal = slips.fold(0, (sum, s) => sum + s.charge);
                      final vehicles = slips.map((s) => s.vehicleNo).where((v) => v != null).toSet().join(', ');

                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF2A2112),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Icon(Icons.person_outline_rounded, color: Color(0xFFF2B24A), size: 16),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(party, style: const TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.w500)),
                                      Text('${slips.length} slip · ${vehicles.isEmpty ? "No vehicle" : vehicles}', style: const TextStyle(color: AppColors.muted, fontSize: 11)),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('₹$partyTotal', style: const TextStyle(color: Color(0xFFF2B24A), fontSize: 13, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Action buttons per party/slip
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => _onMarkReceived(slips.first),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 6),
                                      decoration: BoxDecoration(
                                        color: AppColors.lime,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text('Mark received', style: TextStyle(color: AppColors.onLime, fontSize: 11, fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => context.push('/payments/upi/${slips.first.id}'),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 6),
                                      decoration: BoxDecoration(
                                        color: AppColors.surface3,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text('Show QR', style: TextStyle(color: AppColors.text, fontSize: 11)),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => _onMoveToUdhar(slips.first),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: AppColors.border, width: 0.5),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text('Move Udhar', style: TextStyle(color: AppColors.text, fontSize: 11)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
