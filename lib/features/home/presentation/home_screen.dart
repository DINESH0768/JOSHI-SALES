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
  List<PaymentsTableData> _todayPayments = [];
  int _todayTotal = 0;
  int _cashTotal = 0;
  int _upiTotal = 0;

  @override
  void initState() {
    super.initState();
    _paymentService = PaymentService(widget.db);
    _loadData();
  }

  Future<void> _loadData() async {
    final summary = await _paymentService.getIncomeSummaryForDate(DateTime.now());
    final payments = summary['payments'] as List<PaymentsTableData>? ?? [];
    final cash = summary['cashTotal'] as int? ?? 0;
    final upi = summary['upiTotal'] as int? ?? 0;
    final total = summary['total'] as int? ?? 0;

    if (mounted) {
      setState(() {
        _todayPayments = payments;
        _cashTotal = cash;
        _upiTotal = upi;
        _todayTotal = total;
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
                      'Slips',
                      style: TextStyle(
                        color: AppColors.onLime,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
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

            // Overlapping Card (.ovl) - Aaj ki income
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
                        const Text('Aaj ki income', style: TextStyle(color: AppColors.muted, fontSize: 12, fontWeight: FontWeight.w500)),
                        Text(
                          DateFormat('aaj, dd MMM').format(DateTime.now()),
                          style: const TextStyle(color: AppColors.muted, fontSize: 11),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    GestureDetector(
                      onTap: () => context.push('/income/today'),
                      child: Row(
                        children: [
                          CountUpText(
                            value: _todayTotal,
                            style: const TextStyle(color: AppColors.text, fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.limeTintBg,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Cash: ₹$_cashTotal · UPI: ₹$_upiTotal',
                              style: const TextStyle(
                                color: AppColors.lime,
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
                    const SizedBox(height: 14),
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

            // Light Rounded Sheet (.sheet) - Aaj ki payments
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
                      const Text('Aaj ki payments', style: TextStyle(color: AppColors.lightText, fontSize: 13, fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: () => context.push('/income/history'),
                        child: const Text('Sabhi dekhein', style: TextStyle(color: AppColors.lightText, fontSize: 11, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (_todayPayments.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text('Aaj abhi koi payment praapt nahi hui hai', style: TextStyle(color: Color(0xFF6B6B6B), fontSize: 12)),
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
