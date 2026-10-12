import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

class JamaRasidPdfGenerator {
  static Future<Uint8List> generatePdf({
    required String receiptNo,
    required String dateStr,
    required String customerName,
    required int amountPaid,
    required int previousBalance,
    required int remainingBalance,
    required List<String> clearedSlipsText,
    required String shopName,
    required String shopAddress,
    bool isDuplicate = false,
  }) async {
    final pdf = pw.Document();

    final theme = pw.ThemeData.withFont(
      base: await PdfGoogleFonts.notoSansDevanagariRegular(),
    );

    final todayStr = DateFormat('dd MMM yyyy').format(DateTime.now());

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
                      if (isDuplicate) ...[
                        pw.SizedBox(height: 6),
                        pw.Container(
                          padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: pw.BoxDecoration(
                            color: PdfColor.fromHex('#FF8A80'),
                            borderRadius: pw.BorderRadius.circular(10),
                          ),
                          child: pw.Text(
                            'DUPLICATE COPY - reprinted on $todayStr',
                            style: pw.TextStyle(color: PdfColors.white, fontSize: 8, fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Info Grid
                pw.Container(
                  padding: const pw.EdgeInsets.all(12),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('रसीद नं.', style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
                          pw.Text(receiptNo, style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                          pw.SizedBox(height: 4),
                          pw.Text('नाम श्री', style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
                          pw.Text(customerName, style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
                        ],
                      ),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('दिनांक', style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
                          pw.Text(dateStr, style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),

                // Amounts Box
                pw.Container(
                  margin: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  padding: const pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('#FAFAF7'),
                    borderRadius: pw.BorderRadius.circular(12),
                    border: pw.Border.all(color: PdfColor.fromHex('#ECECE8'), width: 0.5),
                  ),
                  child: pw.Column(
                    children: [
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('प्राप्त राशि (आज जमा)', style: pw.TextStyle(fontSize: 10, color: PdfColor.fromHex('#6B6B6B'))),
                          pw.Text('₹$amountPaid', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#1E7A3A'))),
                        ],
                      ),
                      pw.SizedBox(height: 4),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('पिछला बाकी', style: pw.TextStyle(fontSize: 10, color: PdfColor.fromHex('#6B6B6B'))),
                          pw.Text('₹$previousBalance', style: const pw.TextStyle(fontSize: 11)),
                        ],
                      ),
                      pw.Divider(thickness: 0.5, color: PdfColors.grey300),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text('अब बाकी', style: pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold)),
                          pw.Text(
                            remainingBalance == 0 ? '₹0 (Hisaab poora)' : '₹$remainingBalance',
                            style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: remainingBalance == 0 ? PdfColor.fromHex('#1E7A3A') : PdfColors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Cleared Slips
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('कौन सी slips clear हुई:', style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        clearedSlipsText.join(', '),
                        style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey800),
                      ),
                    ],
                  ),
                ),

                pw.Spacer(),

                // Signature
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        children: [
                          pw.SizedBox(height: 20),
                          pw.Container(width: 60, height: 1, color: PdfColors.grey400),
                          pw.Text('जमा करनेवाला', style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
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
    final xFile = XFile.fromData(pdfBytes, name: fileName, mimeType: 'application/pdf');
    await Share.shareXFiles([xFile], text: 'Jama Rasid: $fileName');
  }

  static Future<void> printPdf(Uint8List pdfBytes) async {
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfBytes);
  }
}
