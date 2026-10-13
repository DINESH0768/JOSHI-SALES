import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/services/audio_feedback_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/db/app_database.dart';
import 'jama_rasid_pdf_generator.dart';

class JamaRasidScreen extends StatefulWidget {
  final String paymentId;
  final AppDatabase db;

  const JamaRasidScreen({super.key, required this.paymentId, required this.db});

  @override
  State<JamaRasidScreen> createState() => _JamaRasidScreenState();
}

class _JamaRasidScreenState extends State<JamaRasidScreen> {
  PaymentsTableData? _payment;
  UdharCustomersTableData? _customer;
  List<SlipsTableData> _clearedSlips = [];
  int _remainingBalance = 0;
  bool _isLoading = true;
  bool _hasTriggeredAudio = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final pay = await (widget.db.select(widget.db.paymentsTable)
          ..where((t) => t.id.equals(widget.paymentId)))
        .getSingleOrNull();

    if (pay != null && pay.udharCustomerId != null) {
      final cust = await (widget.db.select(widget.db.udharCustomersTable)
            ..where((t) => t.id.equals(pay.udharCustomerId!)))
          .getSingleOrNull();

      final allocs = await (widget.db.select(widget.db.udharAllocationsTable)
            ..where((t) => t.paymentId.equals(pay.id)))
          .get();

      final clearedIds = allocs.map((a) => a.slipId).toList();
      final slips = await (widget.db.select(widget.db.slipsTable)
            ..where((t) => t.id.isIn(clearedIds)))
          .get();

      final remainingSlips = await (widget.db.select(widget.db.slipsTable)
            ..where((t) => t.udharCustomerId.equals(pay.udharCustomerId!))
            ..where((t) => t.status.equals('udhar')))
          .get();

      final remainingBaki = remainingSlips.fold(0, (sum, s) => sum + s.charge);

      if (mounted) {
        setState(() {
          _payment = pay;
          _customer = cust;
          _clearedSlips = slips;
          _remainingBalance = remainingBaki;
          _isLoading = false;
        });

        if (!_hasTriggeredAudio) {
          _hasTriggeredAudio = true;
          AudioFeedbackService.instance.playPaymentSuccess(amount: pay.amount, mode: 'udhar_jama');
        }
      }
    }
  }

  Future<void> _onSharePdf() async {
    if (_payment == null || _customer == null) return;

    final dateStr = DateFormat('dd MMM yyyy').format(_payment!.receivedAt);
    final clearedText = _clearedSlips.map((s) => 'Slip #${s.receiptNo} (₹${s.charge})').toList();
    final prevBal = _remainingBalance + _payment!.amount;

    final pdfBytes = await JamaRasidPdfGenerator.generatePdf(
      receiptNo: _payment!.receiptNo ?? 'J-0001',
      dateStr: dateStr,
      customerName: _customer!.name,
      amountPaid: _payment!.amount,
      previousBalance: prevBal,
      remainingBalance: _remainingBalance,
      clearedSlipsText: clearedText,
      shopName: 'जोशी कम्प्यूटराइज धर्मकांटा',
      shopAddress: 'जयपुर रोड, नई मण्डी के पास, रावतसर (राज.)',
    );

    await JamaRasidPdfGenerator.sharePdf(pdfBytes, 'Jama_Rasid_${_payment!.receiptNo}.pdf');
  }

  Widget _buildPaperCard() {
    if (_payment == null || _customer == null) return const SizedBox.shrink();

    final dateStr = DateFormat('dd MMM yyyy').format(_payment!.receivedAt);
    final prevBal = _remainingBalance + _payment!.amount;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Lime Banner
          Container(
            color: AppColors.lime,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: AppColors.bg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset('assets/branding/app_icon_lime.png'),
                    ),
                    const SizedBox(width: 9),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('जोशी कम्प्यूटराइज धर्मकांटा', style: TextStyle(color: AppColors.onLime, fontSize: 14, fontWeight: FontWeight.bold)),
                          Text('जयपुर रोड, रावतसर (राज.)', style: TextStyle(color: AppColors.onLime, fontSize: 10)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Info Grid
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('रसीद नं.', style: TextStyle(color: Color(0xFF8A8A86), fontSize: 9.5)),
                    Text(_payment!.receiptNo ?? 'J-0001', style: const TextStyle(color: AppColors.lightText, fontSize: 13, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    const Text('नाम श्री', style: TextStyle(color: Color(0xFF8A8A86), fontSize: 9.5)),
                    Text(_customer!.name, style: const TextStyle(color: AppColors.lightText, fontSize: 13, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('दिनांक', style: TextStyle(color: Color(0xFF8A8A86), fontSize: 9.5)),
                    Text(dateStr, style: const TextStyle(color: AppColors.lightText, fontSize: 13, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),

          // Amounts Box
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAF7),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFECECE8), width: 1.0),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('प्राप्त राशि (आज जमा)', style: TextStyle(color: Color(0xFF6B6B6B), fontSize: 11)),
                    Text('₹${_payment!.amount}', style: const TextStyle(color: Color(0xFF1E7A3A), fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('पिछला बाकी', style: TextStyle(color: Color(0xFF6B6B6B), fontSize: 11)),
                    Text('₹$prevBal', style: const TextStyle(color: Color(0xFF444444), fontSize: 12)),
                  ],
                ),
                const Divider(height: 12, thickness: 0.5, color: Color(0xFFD4D4D0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('अब बाकी', style: TextStyle(color: AppColors.lightText, fontSize: 12, fontWeight: FontWeight.bold)),
                    Text(
                      _remainingBalance == 0 ? '₹0 (Hisaab poora)' : '₹$_remainingBalance',
                      style: TextStyle(color: _remainingBalance == 0 ? const Color(0xFF1E7A3A) : AppColors.lightText, fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Cleared Slips
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('कौन सी slips clear हुई:', style: TextStyle(color: AppColors.lightText, fontSize: 11, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: _clearedSlips.map((s) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF7D0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('Slip #${s.receiptNo} (₹${s.charge})', style: const TextStyle(color: Color(0xFF2F5D0A), fontSize: 10)),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Signature Asset
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 14, bottom: 12, top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 100,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Container(height: 1, color: const Color(0xFFCFCFCA)),
                      const SizedBox(height: 3),
                      const Text('जमा करनेवाला', style: TextStyle(color: Color(0xFF6B6B6B), fontSize: 10)),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 34,
                        child: Image.asset('assets/signature.png', fit: BoxFit.contain),
                      ),
                      Container(height: 1, color: const Color(0xFFCFCFCA)),
                      const SizedBox(height: 3),
                      const Text('कांटा इंचार्ज', style: TextStyle(color: Color(0xFF6B6B6B), fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
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
                  Text('Jama rasid ${_payment?.receiptNo ?? ""}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.limeTintBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('Jama', style: TextStyle(color: AppColors.lime, fontSize: 11, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _buildPaperCard(),

              const SizedBox(height: 14),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _onSharePdf,
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
                            Icon(Icons.share_rounded, color: AppColors.onLime, size: 16),
                            SizedBox(width: 6),
                            Text('Share PDF', style: TextStyle(color: AppColors.onLime, fontSize: 13, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (Navigator.canPop(context)) Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.surface3,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        child: const Text('Done', style: TextStyle(color: AppColors.text, fontSize: 13)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
