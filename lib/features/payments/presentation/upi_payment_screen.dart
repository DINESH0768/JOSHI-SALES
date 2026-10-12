import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screen_brightness/screen_brightness.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/db/app_database.dart';
import '../../../data/db/slip_repository.dart';
import '../domain/services/payment_service.dart';
import '../domain/services/upi_service.dart';

class UpiPaymentScreen extends StatefulWidget {
  final String slipId;
  final AppDatabase db;

  const UpiPaymentScreen({super.key, required this.slipId, required this.db});

  @override
  State<UpiPaymentScreen> createState() => _UpiPaymentScreenState();
}

class _UpiPaymentScreenState extends State<UpiPaymentScreen> with SingleTickerProviderStateMixin {
  late SlipRepository _slipRepo;
  late PaymentService _paymentService;

  SlipsTableData? _slip;
  List<SlipRoundsTableData> _rounds = [];
  bool _isLoading = true;

  String? _upiId;
  String? _qrImagePath;
  double? _previousBrightness;

  late AnimationController _scanController;

  @override
  void initState() {
    super.initState();
    _slipRepo = SlipRepository(widget.db);
    _paymentService = PaymentService(widget.db);

    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _initScreen();
  }

  Future<void> _initScreen() async {
    // 1. Save and maximize screen brightness
    try {
      _previousBrightness = await ScreenBrightness().current;
      await ScreenBrightness().setScreenBrightness(1.0);
    } catch (_) {}

    // 2. Load slip and UPI config
    final slip = await _slipRepo.getSlipById(widget.slipId);
    final rounds = await _slipRepo.getRoundsForSlip(widget.slipId);
    final upiId = await UpiService.getUpiId();
    final qrPath = await UpiService.getQrImagePath();

    if (mounted) {
      setState(() {
        _slip = slip;
        _rounds = rounds;
        _upiId = upiId;
        _qrImagePath = qrPath;
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // Restore previous screen brightness
    if (_previousBrightness != null) {
      try {
        ScreenBrightness().setScreenBrightness(_previousBrightness!);
      } catch (_) {}
    }
    _scanController.dispose();
    super.dispose();
  }

  Future<void> _onPaymentReceived() async {
    if (_slip == null) return;
    await _paymentService.recordUpiPayment(slipId: _slip!.id, amount: _slip!.charge.toDouble());
    if (mounted) {
      context.go('/slips/card/${_slip!.id}');
    }
  }

  void _copyUpiId() {
    if (_upiId != null && _upiId!.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: _upiId!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('UPI ID copy ho gayi!')),
      );
    }
  }

  Widget _buildQrWidget(double amount) {
    if (_upiId != null && _upiId!.isNotEmpty) {
      final upiUri = UpiService.buildUpiUri(
        upiId: _upiId!,
        payeeName: 'जोशी कम्प्यूटराइज धर्मकांटा',
        amount: amount,
        note: 'Slip ${_slip?.receiptNo ?? ""}',
      );

      return QrImageView(
        data: upiUri,
        version: QrVersions.auto,
        size: 180,
      );
    } else if (_qrImagePath != null && File(_qrImagePath!).existsSync()) {
      return Image.file(
        File(_qrImagePath!),
        width: 180,
        height: 180,
        fit: BoxFit.contain,
      );
    } else {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          'UPI ID / QR Image set nahi hai.\nSettings mein set karein.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.muted, fontSize: 12),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.bg,
        body: Center(child: CircularProgressIndicator(color: AppColors.lime)),
      );
    }

    final amount = _slip?.charge.toDouble() ?? 0.0;
    final party = _slip?.customerName ?? 'Party';
    final material = _rounds.isNotEmpty ? _rounds.first.material ?? '' : '';

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
                  const Text('UPI payment', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.upiBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('Slip ${_slip?.receiptNo}', style: const TextStyle(color: AppColors.upiBlue, fontSize: 11, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Segmented Bar (Cash / UPI / Udhar)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surface2,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        alignment: Alignment.center,
                        child: const Text('Cash', style: TextStyle(color: AppColors.muted, fontSize: 12)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.lime,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: const Text('UPI', style: TextStyle(color: AppColors.onLime, fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        alignment: Alignment.center,
                        child: const Text('Udhar', style: TextStyle(color: AppColors.muted, fontSize: 12)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Customer info & Large Amount
              Text('$party · $material', textAlign: TextAlign.center, style: const TextStyle(color: AppColors.muted, fontSize: 13)),
              const SizedBox(height: 2),
              Text('₹${_slip?.charge}', textAlign: TextAlign.center, style: const TextStyle(color: AppColors.text, fontSize: 36, fontWeight: FontWeight.bold)),

              const SizedBox(height: 16),

              // White Rounded QR Card with lime corner brackets & scan animation
              Center(
                child: Container(
                  width: 240,
                  height: 240,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _buildQrWidget(amount),
                      // Animated scanning line
                      AnimatedBuilder(
                        animation: _scanController,
                        builder: (context, child) {
                          return Positioned(
                            top: _scanController.value * 180,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 2,
                              color: AppColors.lime.withValues(alpha: 0.8),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Pulsing lime dot indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.lime,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text('Payment ka intezaar', style: TextStyle(color: AppColors.lime, fontSize: 12)),
                ],
              ),

              const SizedBox(height: 12),

              // Quick action chips
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _copyUpiId,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.surface3,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('UPI ID copy', style: TextStyle(color: AppColors.text, fontSize: 11)),
                    ),
                  ),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.surface3,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text('Amount badlo', style: TextStyle(color: AppColors.text, fontSize: 11)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Large Lime "Payment mil gaya" button
              GestureDetector(
                onTap: _onPaymentReceived,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.lime,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Payment mil gaya', style: TextStyle(color: AppColors.onLime, fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ),

              const SizedBox(height: 10),

              // Ghost Pending button
              GestureDetector(
                onTap: () => context.go('/slips/card/${_slip?.id}'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  alignment: Alignment.center,
                  child: const Text('Baad mein dega (Pending)', style: TextStyle(color: AppColors.muted, fontSize: 13)),
                ),
              ),

              const SizedBox(height: 8),

              // Notice
              const Text(
                'Phone par paise aane ka message dekh ke hi confirm karo',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.muted, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
