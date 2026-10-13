import 'dart:convert';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../data/db/app_database.dart';

class DataExportService {
  static Future<String> exportFullJsonBackup(AppDatabase db) async {
    final slips = await db.select(db.slipsTable).get();
    final rounds = await db.select(db.slipRoundsTable).get();
    final payments = await db.select(db.paymentsTable).get();
    final udharCusts = await db.select(db.udharCustomersTable).get();
    final expenses = await db.select(db.expensesTable).get();
    final suppliers = await db.select(db.suppliersTable).get();
    final supplierEntries = await db.select(db.supplierEntriesTable).get();
    final supplierPayments = await db.select(db.supplierPaymentsTable).get();

    final backupMap = {
      'version': 1,
      'exportedAt': DateTime.now().toIso8601String(),
      'slips': slips.map((s) => s.toJson()).toList(),
      'rounds': rounds.map((r) => r.toJson()).toList(),
      'payments': payments.map((p) => p.toJson()).toList(),
      'udharCustomers': udharCusts.map((u) => u.toJson()).toList(),
      'expenses': expenses.map((e) => e.toJson()).toList(),
      'suppliers': suppliers.map((sup) => sup.toJson()).toList(),
      'supplierEntries': supplierEntries.map((se) => se.toJson()).toList(),
      'supplierPayments': supplierPayments.map((sp) => sp.toJson()).toList(),
    };

    return jsonEncode(backupMap);
  }

  static Future<bool> restoreFullJsonBackup(AppDatabase db, String jsonStr) async {
    try {
      final Map<String, dynamic> data = jsonDecode(jsonStr);

      await db.transaction(() async {
        // Import Slips
        if (data.containsKey('slips')) {
          for (final s in data['slips']) {
            await db.into(db.slipsTable).insertOnConflictUpdate(SlipsTableData.fromJson(s));
          }
        }

        // Import Rounds
        if (data.containsKey('rounds')) {
          for (final r in data['rounds']) {
            await db.into(db.slipRoundsTable).insertOnConflictUpdate(SlipRoundsTableData.fromJson(r));
          }
        }

        // Import Payments
        if (data.containsKey('payments')) {
          for (final p in data['payments']) {
            await db.into(db.paymentsTable).insertOnConflictUpdate(PaymentsTableData.fromJson(p));
          }
        }

        // Import Expenses
        if (data.containsKey('expenses')) {
          for (final e in data['expenses']) {
            await db.into(db.expensesTable).insertOnConflictUpdate(ExpensesTableData.fromJson(e));
          }
        }

        // Import Suppliers
        if (data.containsKey('suppliers')) {
          for (final sup in data['suppliers']) {
            await db.into(db.suppliersTable).insertOnConflictUpdate(SuppliersTableData.fromJson(sup));
          }
        }
      });

      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<void> exportPdfSummaryReport(AppDatabase db) async {
    final pdf = pw.Document();

    final slips = await (db.select(db.slipsTable)..where((t) => t.deletedAt.isNull())).get();
    final payments = await (db.select(db.paymentsTable)..where((t) => t.deletedAt.isNull())).get();
    final expenses = await (db.select(db.expensesTable)..where((t) => t.deletedAt.isNull())).get();
    final rounds = await (db.select(db.slipRoundsTable)..where((t) => t.deletedAt.isNull())).get();

    int totalIncome = 0;
    for (final p in payments) {
      totalIncome += p.amount;
    }

    int totalExpense = 0;
    for (final e in expenses) {
      totalExpense += e.amount;
    }

    final Map<String, int> maalTotals = {};
    for (final r in rounds) {
      if (r.material != null && r.material!.isNotEmpty) {
        maalTotals[r.material!] = (maalTotals[r.material!] ?? 0) + r.netKg;
      }
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(24),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(12),
                color: PdfColors.grey200,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Text('KANTA SLIP - SUMMARY REPORT', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    pw.Text('Exported: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}', style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ),
              pw.SizedBox(height: 16),

              // Summary Grid
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Column(
                    children: [
                      pw.Text('TOTAL SLIPS', style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700)),
                      pw.Text('${slips.length}', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Text('TOTAL KAMAI', style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700)),
                      pw.Text('Rs $totalIncome', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColors.green800)),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Text('TOTAL KHARCHA', style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700)),
                      pw.Text('Rs $totalExpense', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColors.red800)),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Text('NET BACHAT', style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700)),
                      pw.Text('Rs ${totalIncome - totalExpense}', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColors.blue800)),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 20),

              pw.Text('Maal-wise Net Weight Totals', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 8),

              ...maalTotals.entries.map((entry) {
                return pw.Container(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(entry.key, style: const pw.TextStyle(fontSize: 10)),
                      pw.Text('${entry.value} kg', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                );
              }),

              pw.Spacer(),
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
      onLayout: (format) async => pdf.save(),
      name: 'Kanta_Slip_Summary_Report.pdf',
    );
  }
}
