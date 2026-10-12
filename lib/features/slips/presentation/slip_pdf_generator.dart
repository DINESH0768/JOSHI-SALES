import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

class SlipPdfGenerator {
  static Future<Uint8List> generatePdf({
    required int receiptNo,
    required String dateStr,
    String? customerName,
    String? vehicleNo,
    required double totalNetWeight,
    required double charge,
    required List<Map<String, dynamic>> rounds,
    required String shopName,
    required String shopAddress,
    required String capacityText,
  }) async {
    final pdf = pw.Document();

    final theme = pw.ThemeData.withFont(
      base: await PdfGoogleFonts.notoSansDevanagariRegular(),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5,
        margin: const pw.EdgeInsets.all(12),
        theme: theme,
        build: (pw.Context context) {
          return pw.Container(
            decoration: pw.BoxDecoration(
              color: PdfColors.white,
              borderRadius: pw.BorderRadius.circular(18),
              border: pw.Border.all(color: PdfColors.grey300, width: 0.5),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                // Header Lime
                pw.Container(
                  color: PdfColor.fromHex('#C6F432'),
                  padding: const pw.EdgeInsets.all(12),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            shopName,
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColor.fromHex('#1A2200'),
                            ),
                          ),
                          pw.Text(
                            shopAddress,
                            style: pw.TextStyle(
                              fontSize: 9,
                              color: PdfColor.fromHex('#1A2200'),
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 6),
                      pw.Row(
                        children: [
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: pw.BoxDecoration(
                              color: PdfColor.fromHex('#0B0B0C'),
                              borderRadius: pw.BorderRadius.circular(10),
                            ),
                            child: pw.Text(
                              capacityText,
                              style: pw.TextStyle(
                                color: PdfColor.fromHex('#C6F432'),
                                fontSize: 8,
                              ),
                            ),
                          ),
                          pw.SizedBox(width: 4),
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: pw.BoxDecoration(
                              color: PdfColor.fromHex('#EAF7D0'),
                              borderRadius: pw.BorderRadius.circular(10),
                            ),
                            child: pw.Text(
                              'सरकार से मान्यता प्राप्त',
                              style: pw.TextStyle(
                                color: PdfColor.fromHex('#1A2200'),
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Info Grid
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('रसीद नं.', style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
                          pw.Text('$receiptNo', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(height: 4),
                          pw.Text('नाम श्री', style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
                          pw.Text(customerName ?? '-', style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('दिनांक', style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
                          pw.Text(dateStr, style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(height: 4),
                          pw.Text('वाहन नं.', style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
                          pw.Text(vehicleNo ?? '-', style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),

                // Rounds List
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 8),
                  child: pw.Column(
                    children: rounds.map((r) {
                      final roundNo = r['roundNo'] ?? 1;
                      final mat = r['material'] ?? '';
                      final gross = (r['gross'] as num).toDouble();
                      final tare = (r['tare'] as num).toDouble();
                      final net = gross - tare;
                      final bagExtra = r['bagExtra'] as String?;

                      return pw.Container(
                        margin: const pw.EdgeInsets.only(bottom: 6),
                        padding: const pw.EdgeInsets.all(8),
                        decoration: pw.BoxDecoration(
                          color: PdfColor.fromHex('#FAFAF7'),
                          borderRadius: pw.BorderRadius.circular(10),
                          border: pw.Border.all(color: PdfColor.fromHex('#ECECE8'), width: 0.5),
                        ),
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(
                              children: [
                                pw.Container(
                                  padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: pw.BoxDecoration(
                                    color: PdfColor.fromHex('#141414'),
                                    borderRadius: pw.BorderRadius.circular(8),
                                  ),
                                  child: pw.Text(
                                    'राउंड $roundNo',
                                    style: pw.TextStyle(color: PdfColor.fromHex('#C6F432'), fontSize: 8),
                                  ),
                                ),
                                pw.SizedBox(width: 6),
                                pw.Text(mat, style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                                if (bagExtra != null && bagExtra.isNotEmpty) ...[
                                  pw.Spacer(),
                                  pw.Container(
                                    padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: pw.BoxDecoration(
                                      color: PdfColor.fromHex('#EAF7D0'),
                                      borderRadius: pw.BorderRadius.circular(8),
                                    ),
                                    child: pw.Text(
                                      bagExtra,
                                      style: pw.TextStyle(color: PdfColor.fromHex('#2F5D0A'), fontSize: 8),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            pw.SizedBox(height: 4),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text('वाहन सहित माल', style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700)),
                                pw.Text('${NumberFormat('#,##0').format(gross)} kg', style: const pw.TextStyle(fontSize: 9)),
                              ],
                            ),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text('खाली (तुलाने पर)', style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700)),
                                pw.Text('${NumberFormat('#,##0').format(tare)} kg', style: const pw.TextStyle(fontSize: 9)),
                              ],
                            ),
                            pw.Divider(thickness: 0.5, color: PdfColors.grey300),
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text('असल माल का वजन', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                                pw.Text('${NumberFormat('#,##0').format(net)} kg', style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // Dark Summary Box
                pw.Container(
                  margin: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  padding: const pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('#0B0B0C'),
                    borderRadius: pw.BorderRadius.circular(10),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('कुल असल माल', style: pw.TextStyle(color: PdfColor.fromHex('#A8A8AE'), fontSize: 9)),
                          pw.Text(
                            '${NumberFormat('#,##0').format(totalNetWeight)} kg',
                            style: pw.TextStyle(color: PdfColor.fromHex('#C6F432'), fontSize: 16, fontWeight: pw.FontWeight.bold),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 4),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('भाड़ा / चार्ज', style: pw.TextStyle(color: PdfColor.fromHex('#A8A8AE'), fontSize: 9)),
                          pw.Text(
                            '₹${NumberFormat('#,##0').format(charge)}',
                            style: pw.TextStyle(color: PdfColors.white, fontSize: 13, fontWeight: pw.FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Terms & Signature
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text(
                    'नियम व शर्तें: 1. तोल पशु सहित/रहित हुआ है। 2. वजन के जोड़ बाकी की जांच कर लेवें। 3. कांटे से उतरने के बाद जुम्मेवारी नहीं। 4. दोबारा वजन पर चार्ज। 5. रिकॉर्ड एक माह तक। 6. न्याय क्षेत्र रावतसर।',
                    style: const pw.TextStyle(fontSize: 7, color: PdfColors.grey700),
                  ),
                ),

                pw.Spacer(),
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        children: [
                          pw.SizedBox(height: 20),
                          pw.Container(width: 60, height: 1, color: PdfColors.grey400),
                          pw.Text('तुलवानेवाला', style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
                        ],
                      ),
                      pw.Column(
                        children: [
                          pw.SizedBox(height: 20),
                          pw.Container(width: 60, height: 1, color: PdfColors.grey400),
                          pw.Text('कांटा इंचार्ज', style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  static Future<void> sharePdf(Uint8List pdfBytes, String fileName) async {
    final xFile = XFile.fromData(
      pdfBytes,
      name: fileName,
      mimeType: 'application/pdf',
    );
    await Share.shareXFiles([xFile], text: 'Kanta Slip: $fileName');
  }

  static Future<void> printPdf(Uint8List pdfBytes) async {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
    );
  }
}
