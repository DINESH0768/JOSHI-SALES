import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/services/audio_feedback_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/db/app_database.dart';
import '../../../data/db/slip_repository.dart';
import '../domain/services/payment_service.dart';

class PaymentPostSaveScreen extends StatefulWidget {
  final String slipId;
  final AppDatabase db;

  const PaymentPostSaveScreen({super.key, required this.slipId, required this.db});

  @override
  State<PaymentPostSaveScreen> createState() => _PaymentPostSaveScreenState();
}

enum PaymentStep { question, modeSelect, udharSelect, success }

class _PaymentPostSaveScreenState extends State<PaymentPostSaveScreen> {
  late SlipRepository _slipRepo;
  late PaymentService _paymentService;

  SlipsTableData? _slip;
  List<SlipRoundsTableData> _rounds = [];
  bool _isLoading = true;

  PaymentStep _currentStep = PaymentStep.question;
  String _successMsg = '';

  final _udharNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _slipRepo = SlipRepository(widget.db);
    _paymentService = PaymentService(widget.db);
    _loadData();
  }

  Future<void> _loadData() async {
    final slipData = await _slipRepo.getSlipById(widget.slipId);
    final roundsData = await _slipRepo.getRoundsForSlip(widget.slipId);

    if (mounted) {
      setState(() {
        _slip = slipData;
        _rounds = roundsData;
        _isLoading = false;
        if (slipData?.customerName != null) {
          _udharNameController.text = slipData!.customerName!;
        }
      });
    }
  }

  Future<void> _onCashPayment() async {
    if (_slip == null) return;
    await _paymentService.recordCashPayment(slipId: _slip!.id, amount: _slip!.charge.toDouble());
    AudioFeedbackService.instance.playPaymentSuccess(amount: _slip!.charge, mode: 'cash');
    if (mounted) {
      setState(() {
        _successMsg = '₹${_slip!.charge} Cash mein mile';
        _currentStep = PaymentStep.success;
      });
    }
  }

  Future<void> _onUpiPayment() async {
    if (_slip == null) return;
    await _paymentService.recordUpiPayment(slipId: _slip!.id, amount: _slip!.charge.toDouble());
    AudioFeedbackService.instance.playPaymentSuccess(amount: _slip!.charge, mode: 'upi');
    if (mounted) {
      setState(() {
        _successMsg = 'Payment mil gaya (UPI)';
        _currentStep = PaymentStep.success;
      });
    }
  }

  Future<void> _onPending() async {
    if (_slip == null) return;
    await _paymentService.markSlipPending(_slip!.id);
    if (mounted) {
      context.go('/slips/card/${_slip!.id}');
    }
  }

  Future<void> _onSaveUdhar() async {
    if (_slip == null) return;
    final name = _udharNameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Customer ka naam likho')),
      );
      return;
    }
    await _paymentService.allocateToUdhar(slipId: _slip!.id, customerName: name);
    if (mounted) {
      setState(() {
        _successMsg = '$name ke Udhar khate mein jod diya';
        _currentStep = PaymentStep.success;
      });
    }
  }

  Widget _buildSummaryCard() {
    if (_slip == null) return const SizedBox.shrink();

    final dateStr = DateFormat('dd MMM').format(_slip!.date);
    final totalNet = _rounds.fold(0, (sum, r) => sum + r.netKg);
    final partyName = _slip!.customerName ?? 'Party';

    return Container(
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
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.limeTintBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('Slip saved', style: TextStyle(color: AppColors.lime, fontSize: 11, fontWeight: FontWeight.w600)),
              ),
              const Spacer(),
              Text(
                '${_slip!.vehicleNo ?? ""} · Slip ${_slip!.receiptNo}',
                style: const TextStyle(color: AppColors.text, fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$dateStr · $partyName', style: const TextStyle(color: AppColors.muted, fontSize: 12)),
                  const SizedBox(height: 2),
                  Text('${NumberFormat('#,##0').format(totalNet)} kg', style: const TextStyle(color: AppColors.text, fontSize: 15, fontWeight: FontWeight.w600)),
                ],
              ),
              Text(
                '₹${_slip!.charge}',
                style: const TextStyle(color: AppColors.lime, fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_currentStep != PaymentStep.question) {
                        setState(() => _currentStep = PaymentStep.question);
                      } else if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
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
                  const Text('Payment status', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 14),

              _buildSummaryCard(),

              const SizedBox(height: 18),

              if (_currentStep == PaymentStep.question) ...[
                const Text(
                  'Payment aaya hai?',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.text, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),

                // 1. Haan, aaya (Lime)
                GestureDetector(
                  onTap: () => setState(() => _currentStep = PaymentStep.modeSelect),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.lime,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Haan, aaya', style: TextStyle(color: AppColors.onLime, fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 10),

                // 2. Nahi, baad mein dega (Dark)
                GestureDetector(
                  onTap: _onPending,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.surface3,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Nahi, baad mein dega', style: TextStyle(color: AppColors.text, fontSize: 14)),
                  ),
                ),
                const SizedBox(height: 10),

                // 3. Udhar khate mein (Outlined)
                GestureDetector(
                  onTap: () => setState(() => _currentStep = PaymentStep.udharSelect),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColors.border, width: 1.0),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Udhar khate mein', style: TextStyle(color: AppColors.text, fontSize: 14)),
                  ),
                ),
              ],

              if (_currentStep == PaymentStep.modeSelect) ...[
                const Text(
                  'Kaise mila?',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.text, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),

                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _onCashPayment,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: AppColors.limeTintBg,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: AppColors.limeTintBorder, width: 1.0),
                          ),
                          alignment: Alignment.center,
                          child: const Column(
                            children: [
                              Icon(Icons.payments_rounded, color: AppColors.lime, size: 28),
                              SizedBox(height: 6),
                              Text('Cash', style: TextStyle(color: AppColors.lime, fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: _onUpiPayment,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: AppColors.upiBg,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: AppColors.upiBorder, width: 1.0),
                          ),
                          alignment: Alignment.center,
                          child: const Column(
                            children: [
                              Icon(Icons.qr_code_2_rounded, color: AppColors.upiBlue, size: 28),
                              SizedBox(height: 6),
                              Text('UPI', style: TextStyle(color: AppColors.upiBlue, fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              if (_currentStep == PaymentStep.udharSelect) ...[
                const Text(
                  'Kiske udhar khate mein?',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.text, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(color: AppColors.border, width: 0.5),
                  ),
                  child: TextField(
                    controller: _udharNameController,
                    style: const TextStyle(color: AppColors.text, fontSize: 14),
                    decoration: const InputDecoration(
                      hintText: 'Customer ka naam',
                      hintStyle: TextStyle(color: AppColors.muted),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                GestureDetector(
                  onTap: _onSaveUdhar,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.lime,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Udhar mein jodo', style: TextStyle(color: AppColors.onLime, fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],

              if (_currentStep == PaymentStep.success) ...[
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.limeTintBg,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.limeTintBorder, width: 1.0),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const Icon(Icons.check_circle_rounded, color: AppColors.lime, size: 48),
                      const SizedBox(height: 10),
                      Text(
                        _successMsg,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.lime, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => context.go('/slips/card/${_slip!.id}'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.lime,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.center,
                          child: const Text('Done', style: TextStyle(color: AppColors.onLime, fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => context.go('/slips/card/${_slip!.id}'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.surface3,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.center,
                          child: const Text('Slip share karo', style: TextStyle(color: AppColors.text, fontSize: 14)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
