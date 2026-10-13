import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_scale_button.dart';
import '../../../core/widgets/count_up_text.dart';
import '../../../core/widgets/staggered_list_row.dart';
import '../../../data/db/app_database.dart';
import '../../payments/domain/services/payment_service.dart';

class HomeScreen extends StatefulWidget {
  final AppDatabase db;

  const HomeScreen({super.key, required this.db});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PaymentService _paymentService;
  PaymentsTableData? _latestPayment;
  List<PaymentsTableData> _todayPayments = [];

  @override
  void initState() {
    super.initState();
    _paymentService = PaymentService(widget.db);
    _loadData();
  }

  Future<void> _loadData() async {
    final summary = await _paymentService.getIncomeSummaryForDate(DateTime.now());
    final payments = summary['payments'] as List<PaymentsTableData>? ?? [];

    if (mounted) {
      setState(() {
        _todayPayments = payments;
        if (payments.isNotEmpty) {
          _latestPayment = payments.first;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header lime area (.lhd)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 34,
                left: 14,
                right: 14,
                bottom: 56,
              ),
              decoration: const BoxDecoration(
                color: AppColors.lime,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              child: SafeArea(
                bottom: false,
                child: Row(
                  children: [
                    // Logo Square 34x34
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: AppColors.bg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        'assets/branding/app_icon_lime.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Kanta Slip',
                      style: TextStyle(
                        color: AppColors.onLime,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.bg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'v1.0.0+1',
                        style: TextStyle(color: AppColors.lime, fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Spacer(),
                    // Plus Action Button (34x34 circle)
                    GestureDetector(
                      onTap: () => context.push('/slips/new'),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: const BoxDecoration(
                          color: AppColors.bg,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add_rounded,
                          color: AppColors.lime,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Overlapping Card (.ovl) - Latest Income
            Transform.translate(
              offset: const Offset(0, -32),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Latest income', style: TextStyle(color: AppColors.muted, fontSize: 11)),
                        Text(
                          _latestPayment != null ? DateFormat('aaj, dd MMM').format(_latestPayment!.receivedAt) : 'Aaj',
                          style: const TextStyle(color: AppColors.muted, fontSize: 11),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => context.push('/income/today'),
                      child: Row(
                        children: [
                          CountUpText(
                            value: _latestPayment != null ? _latestPayment!.amount : 0,
                            style: const TextStyle(color: AppColors.text, fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          if (_latestPayment != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: _latestPayment!.mode == 'cash' ? AppColors.limeTintBg : AppColors.upiBg,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _latestPayment!.mode == 'cash' ? 'Cash' : 'UPI',
                                style: TextStyle(
                                  color: _latestPayment!.mode == 'cash' ? AppColors.lime : AppColors.upiBlue,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          const Spacer(),
                          const Icon(Icons.chevron_right_rounded, color: AppColors.muted, size: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: AppScaleButton(
                            onTap: () => context.push('/slips/new'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.lime,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: const Text('New slip', style: TextStyle(color: AppColors.onLime, fontSize: 13, fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: AppScaleButton(
                            onTap: () => context.push('/slips/scan'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.surface3,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.camera_alt_outlined, color: AppColors.text, size: 16),
                                  SizedBox(width: 6),
                                  Text('Scan slip', style: TextStyle(color: AppColors.text, fontSize: 13, fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Light Rounded Sheet (.sheet) - Income List
            Container(
              margin: const EdgeInsets.only(left: 14, right: 14, bottom: 20),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.lightSheet,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Latest income list', style: TextStyle(color: AppColors.lightText, fontSize: 13, fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: () => context.push('/income/history'),
                        child: const Text('See all', style: TextStyle(color: AppColors.lightText, fontSize: 11, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (_todayPayments.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text('Aaj abhi koi income nahi hui hai', style: TextStyle(color: Color(0xFF6B6B6B), fontSize: 12)),
                    )
                  else
                    Column(
                      children: _todayPayments.asMap().entries.map((entry) {
                        final i = entry.key;
                        final p = entry.value;
                        return StaggeredListRow(
                          index: i,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 6),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.lightSurface,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: p.mode == 'cash' ? const Color(0xFFEAF7D0) : const Color(0xFFE3E9FF),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    p.mode == 'cash' ? Icons.payments_rounded : Icons.qr_code_2_rounded,
                                    color: p.mode == 'cash' ? const Color(0xFF1E7A3A) : const Color(0xFF2A3570),
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Payment (${p.mode.toUpperCase()})', style: const TextStyle(color: AppColors.lightText, fontSize: 13, fontWeight: FontWeight.w500)),
                                      Text(DateFormat('hh:mm a').format(p.receivedAt), style: const TextStyle(color: Color(0xFF6B6B6B), fontSize: 11)),
                                    ],
                                  ),
                                ),
                                Text(
                                  '+₹${p.amount}',
                                  style: const TextStyle(color: Color(0xFF1E7A3A), fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
