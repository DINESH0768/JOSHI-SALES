import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import '../../../../data/db/app_database.dart';

class SupplierPdfGenerator {
  static Future<void> printOrShareStatement({
    required SuppliersTableData supplier,
    required List<Map<String, dynamic>> pooraHisaab,
    required int denaBaki,
    required ShopSettingsTableData? shop,
  }) async {
    final pdf = pw.Document();

    final shopName = shop?.shopName ?? 'जोशी कम्प्यूटराइज धर्मकांटा';
    final shopAddress = shop?.address ?? 'रावतसर (राज.)';
    final shopPhones = shop?.phones ?? '';

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(24),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey200,
                  borderRadius: pw.BorderRadius.circular(8),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text(shopName, style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                    pw.Text(shopAddress, style: const pw.TextStyle(fontSize: 11)),
                    if (shopPhones.isNotEmpty)
                      pw.Text('Mob: $shopPhones', style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ),
              pw.SizedBox(height: 16),

              // Title & Supplier Info
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('SUPPLIER STATEMENT', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.Text('Supplier: ${supplier.name}', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
                      if (supplier.category != null)
                        pw.Text('Category: ${supplier.category}', style: const pw.TextStyle(fontSize: 10)),
                      if (supplier.ratePerUnit != null)
                        pw.Text('Rate: Rs ${supplier.ratePerUnit} / ${supplier.unitName ?? 'unit'}', style: const pw.TextStyle(fontSize: 10)),
                    ],
                  ),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(10),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.red800, width: 1),
                      borderRadius: pw.BorderRadius.circular(6),
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text('ABHI DENA BAKI', style: pw.TextStyle(fontSize: 10, color: PdfColors.red800, fontWeight: pw.FontWeight.bold)),
                        pw.Text('Rs $denaBaki', style: pw.TextStyle(fontSize: 16, color: PdfColors.red800, fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 16),

              // Statement Table Header
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                color: PdfColors.grey300,
                child: pw.Row(
                  children: [
                    pw.Expanded(flex: 2, child: pw.Text('Date', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold))),
                    pw.Expanded(flex: 4, child: pw.Text('Details', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold))),
                    pw.Expanded(flex: 2, child: pw.Text('Entry (+)', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.right)),
                    pw.Expanded(flex: 2, child: pw.Text('Payment (-)', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.right)),
                    pw.Expanded(flex: 2, child: pw.Text('Balance', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.right)),
                  ],
                ),
              ),
              pw.Divider(height: 1),

              // Rows
              ...pooraHisaab.reversed.map((item) {
                final date = item['date'] as DateTime;
                final dateStr = DateFormat('dd MMM yyyy').format(date);
                final isEntry = item['type'] == 'entry';
                final amount = item['amount'] as int;
                final count = item['count'];
                final mode = item['mode'];
                final runningBal = item['runningBalance'] ?? 0;

                String details = isEntry
                    ? '${count != null ? '$count ${supplier.unitName ?? 'unit'}' : 'Entry'}${item['note'] != null && (item['note'] as String).isNotEmpty ? ' · ${item['note']}' : ''}'
                    : 'Paise diye (${(mode ?? '').toUpperCase()})';

                return pw.Container(
                  padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300, width: 0.5)),
                  ),
                  child: pw.Row(
                    children: [
                      pw.Expanded(flex: 2, child: pw.Text(dateStr, style: const pw.TextStyle(fontSize: 9))),
                      pw.Expanded(flex: 4, child: pw.Text(details, style: const pw.TextStyle(fontSize: 9))),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          isEntry ? 'Rs $amount' : '-',
                          style: const pw.TextStyle(fontSize: 9, color: PdfColors.red800),
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          !isEntry ? 'Rs $amount' : '-',
                          style: const pw.TextStyle(fontSize: 9, color: PdfColors.green800),
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          'Rs $runningBal',
                          style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold),
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                );
              }),

              pw.Spacer(),

              // Footer
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text('Generated by Kanta Slip App', style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600)),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'Supplier_Statement_${supplier.name.replaceAll(' ', '_')}.pdf',
    );
  }
}
