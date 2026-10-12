import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/db/app_database.dart';
import '../../../data/db/slip_repository.dart';
import 'slip_pdf_generator.dart';

class SlipCardScreen extends StatefulWidget {
  final String slipId;
  final AppDatabase db;

  const SlipCardScreen({super.key, required this.slipId, required this.db});

  @override
  State<SlipCardScreen> createState() => _SlipCardScreenState();
}

class _SlipCardScreenState extends State<SlipCardScreen> {
  late SlipRepository _repository;
  SlipsTableData? _slip;
  List<SlipRoundsTableData> _rounds = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _repository = SlipRepository(widget.db);
    _loadData();
  }

  Future<void> _loadData() async {
    final slipData = await _repository.getSlipById(widget.slipId);
    final roundsData = await _repository.getRoundsForSlip(widget.slipId);

    if (mounted) {
      setState(() {
        _slip = slipData;
        _rounds = roundsData;
        _isLoading = false;
      });
    }
  }

  Future<void> _onSharePdf() async {
    if (_slip == null) return;

    final dateStr = DateFormat('dd MMM yyyy').format(_slip!.date);

    final pdfBytes = await SlipPdfGenerator.generatePdf(
      receiptNo: _slip!.receiptNo,
      dateStr: dateStr,
      customerName: _slip!.customerName,
      vehicleNo: _slip!.vehicleNo,
      totalNetWeight: _rounds.fold(0.0, (sum, r) => sum + (r.netKg.toDouble())),
      charge: _slip!.charge.toDouble(),
      rounds: _rounds.map((r) => {
        'roundNo': r.roundNo,
        'material': r.material ?? '',
        'gross': r.grossKg.toDouble(),
        'tare': (r.emptyTulaneKg ?? 0).toDouble(),
        'bagExtra': r.extra,
      }).toList(),
      shopName: 'जोशी कम्प्यूटराइज धर्मकांटा',
      shopAddress: 'जयपुर रोड, नई मण्डी के पास, रावतसर (राज.)',
      capacityText: 'क्षमता 60 टन',
    );

    await SlipPdfGenerator.sharePdf(pdfBytes, 'Slip_${_slip!.receiptNo}.pdf');
  }

  Future<void> _onPrintPdf() async {
    if (_slip == null) return;

    final dateStr = DateFormat('dd MMM yyyy').format(_slip!.date);

    final pdfBytes = await SlipPdfGenerator.generatePdf(
      receiptNo: _slip!.receiptNo,
      dateStr: dateStr,
      customerName: _slip!.customerName,
      vehicleNo: _slip!.vehicleNo,
      totalNetWeight: _rounds.fold(0.0, (sum, r) => sum + (r.netKg.toDouble())),
      charge: _slip!.charge.toDouble(),
      rounds: _rounds.map((r) => {
        'roundNo': r.roundNo,
        'material': r.material ?? '',
        'gross': r.grossKg.toDouble(),
        'tare': (r.emptyTulaneKg ?? 0).toDouble(),
        'bagExtra': r.extra,
      }).toList(),
      shopName: 'जोशी कम्प्यूटराइज धर्मकांटा',
      shopAddress: 'जयपुर रोड, नई मण्डी के पास, रावतसर (राज.)',
      capacityText: 'क्षमता 60 टन',
    );

    await SlipPdfGenerator.printPdf(pdfBytes);
  }

  Widget _buildPaperCard() {
    if (_slip == null) return const SizedBox.shrink();

    final dateStr = DateFormat('dd MMM yyyy').format(_slip!.date);
    final totalNet = _rounds.fold(0, (sum, r) => sum + r.netKg);

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
                          Text(
                            'जोशी कम्प्यूटराइज धर्मकांटा',
                            style: TextStyle(
                              color: AppColors.onLime,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'जयपुर रोड, नई मण्डी के पास, रावतसर (राज.)',
                            style: TextStyle(
                              color: AppColors.onLime,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.bg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'क्षमता 60 टन',
                        style: TextStyle(color: AppColors.lime, fontSize: 9),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0x1F0B0B0C),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'सरकार से मान्यता प्राप्त',
                        style: TextStyle(color: AppColors.onLime, fontSize: 9),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Info Grid (.ig)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFD4D4D0), width: 1.0, style: BorderStyle.none)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('रसीद नं.', style: TextStyle(color: Color(0xFF8A8A86), fontSize: 9.5)),
                      Text('${_slip!.receiptNo}', style: const TextStyle(color: AppColors.lightText, fontSize: 13, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      const Text('नाम श्री', style: TextStyle(color: Color(0xFF8A8A86), fontSize: 9.5)),
                      Text(_slip!.customerName ?? '-', style: const TextStyle(color: AppColors.lightText, fontSize: 13, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('दिनांक', style: TextStyle(color: Color(0xFF8A8A86), fontSize: 9.5)),
                      Text(dateStr, style: const TextStyle(color: AppColors.lightText, fontSize: 13, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      const Text('वाहन नं.', style: TextStyle(color: Color(0xFF8A8A86), fontSize: 9.5)),
                      Text(_slip!.vehicleNo ?? '-', style: const TextStyle(color: AppColors.lightText, fontSize: 13, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Round Cards List (.rd2)
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: _rounds.map((r) {
                final gross = r.grossKg;
                final tare = r.emptyTulaneKg ?? 0;
                final net = r.netKg;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAF7),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFECECE8), width: 1.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.lightText,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'राउंड ${r.roundNo}',
                              style: const TextStyle(color: AppColors.lime, fontSize: 9),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            r.material ?? '',
                            style: const TextStyle(color: AppColors.lightText, fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          if (r.extra != null && r.extra!.isNotEmpty) ...[
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEAF7D0),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                r.extra!,
                                style: const TextStyle(color: Color(0xFF2F5D0A), fontSize: 10),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('वाहन सहित माल', style: TextStyle(color: Color(0xFF444444), fontSize: 11)),
                          Text('${NumberFormat('#,##0').format(gross)} kg', style: const TextStyle(color: Color(0xFF444444), fontSize: 11)),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('खाली (तुलाने पर)', style: TextStyle(color: Color(0xFF444444), fontSize: 11)),
                          Text('${NumberFormat('#,##0').format(tare)} kg', style: const TextStyle(color: Color(0xFF444444), fontSize: 11)),
                        ],
                      ),
                      const Divider(height: 10, thickness: 0.5, color: Color(0xFFD4D4D0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('असल माल का वजन', style: TextStyle(color: AppColors.lightText, fontSize: 11, fontWeight: FontWeight.w500)),
                          Text(
                            '${NumberFormat('#,##0').format(net)} kg',
                            style: const TextStyle(color: AppColors.lightText, fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          // Summary Box
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.bg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'कुल असल माल (राउंड ${_rounds.length == 1 ? "1" : "1+2"})',
                      style: const TextStyle(color: Color(0xFFA8A8AE), fontSize: 10),
                    ),
                    Text(
                      '${NumberFormat('#,##0').format(totalNet)} kg',
                      style: const TextStyle(color: AppColors.lime, fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.only(top: 6),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: AppColors.border, width: 1.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('भाड़ा / चार्ज', style: TextStyle(color: Color(0xFFA8A8AE), fontSize: 10)),
                      Text(
                        '₹${NumberFormat('#,##0').format(_slip!.charge)}',
                        style: const TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Terms & Signature
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Text(
              'नियम व शर्तें: 1. तोल पशु सहित/रहित हुआ है। 2. वजन के जोड़ बाकी की जांच कर लेवें। 3. कांटे से उतरने के बाद जुम्मेवारी नहीं। 4. दोबारा वजन पर चार्ज। 5. रिकॉर्ड एक माह तक। 6. न्याय क्षेत्र रावतसर।',
              style: TextStyle(color: Color(0xFF8A8A86), fontSize: 9, height: 1.5),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 14, right: 14, bottom: 12, top: 4),
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
                      const Text('तुलवानेवाला', style: TextStyle(color: Color(0xFF6B6B6B), fontSize: 10)),
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

    final statusDisplay = _slip?.status == 'pending' ? 'Pending' : (_slip?.status ?? 'Pending');

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
                  Text('Slip ${_slip?.receiptNo ?? ""}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.pendingBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      statusDisplay,
                      style: const TextStyle(color: AppColors.pendingFg, fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _buildPaperCard(),

              const SizedBox(height: 10),

              // Action Buttons Row 1: Share PDF & Print
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
                            Text('Share PDF', style: TextStyle(color: AppColors.onLime, fontSize: 13, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: _onPrintPdf,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.surface3,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.print_rounded, color: AppColors.text, size: 16),
                            SizedBox(width: 6),
                            Text('Print', style: TextStyle(color: AppColors.text, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Action Buttons Row 2: Mark received & Show QR
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.surface3,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        child: const Text('Mark received', style: TextStyle(color: AppColors.text, fontSize: 13)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.surface3,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.qr_code_2_rounded, color: AppColors.text, size: 16),
                            SizedBox(width: 6),
                            Text('Show QR', style: TextStyle(color: AppColors.text, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
