import 'package:drift/drift.dart';
import '../../../../data/db/app_database.dart';

class DailyMetricPoint {
  final DateTime date;
  final int income;
  final int expense;
  final int bachat;
  final int cashIncome;
  final int upiIncome;
  final int cashCount;
  final int upiCount;

  DailyMetricPoint({
    required this.date,
    required this.income,
    required this.expense,
    required this.bachat,
    required this.cashIncome,
    required this.upiIncome,
    required this.cashCount,
    required this.upiCount,
  });
}

class HistorySummaryData {
  final int currentTotalIncome;
  final int previousTotalIncome;
  final double percentageChange; // Positive is increase, negative is decrease
  final List<DailyMetricPoint> dailyPoints;
  final Map<DateTime, List<PaymentsTableData>> paymentsByDate;

  HistorySummaryData({
    required this.currentTotalIncome,
    required this.previousTotalIncome,
    required this.percentageChange,
    required this.dailyPoints,
    required this.paymentsByDate,
  });
}

class EarningHistoryService {
  final AppDatabase db;

  EarningHistoryService(this.db);

  static String formatIndianCurrency(int amount) {
    if (amount == 0) return '0';
    final isNegative = amount < 0;
    final absAmount = amount.abs().toString();

    if (absAmount.length <= 3) {
      return (isNegative ? '-' : '') + absAmount;
    }

    final lastThree = absAmount.substring(absAmount.length - 3);
    final otherNumbers = absAmount.substring(0, absAmount.length - 3);

    final buffer = StringBuffer();
    int count = 0;
    for (int i = otherNumbers.length - 1; i >= 0; i--) {
      buffer.write(otherNumbers[i]);
      count++;
      if (count == 2 && i != 0) {
        buffer.write(',');
        count = 0;
      }
    }

    final reversedOther = buffer.toString().split('').reversed.join('');
    final prefix = isNegative ? '-' : '';
    return '$prefix$reversedOther,$lastThree';
  }

  Future<HistorySummaryData> getEarningHistoryForRange({
    required int days, // 7, 15, 30 or 0 if custom month
    DateTime? customMonth,
  }) async {
    DateTime endDate = DateTime.now();
    DateTime startDate;

    if (days > 0) {
      // Normalize to end of today, start of N days ago
      endDate = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59, 999);
      startDate = DateTime(endDate.year, endDate.month, endDate.day).subtract(Duration(days: days - 1));
    } else if (customMonth != null) {
      startDate = DateTime(customMonth.year, customMonth.month, 1);
      endDate = DateTime(customMonth.year, customMonth.month + 1, 1).subtract(const Duration(milliseconds: 1));
      days = endDate.difference(startDate).inDays + 1;
    } else {
      days = 7;
      endDate = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59, 999);
      startDate = DateTime(endDate.year, endDate.month, endDate.day).subtract(const Duration(days: 6));
    }

    // Previous period range for comparison
    final prevEndDate = startDate.subtract(const Duration(milliseconds: 1));
    final prevStartDate = prevEndDate.subtract(Duration(days: days - 1));

    // Query Current Period Payments
    final currentPayments = await (db.select(db.paymentsTable)
          ..where((t) => t.deletedAt.isNull())
          ..where((t) => t.receivedAt.isBiggerOrEqualValue(startDate))
          ..where((t) => t.receivedAt.isSmallerOrEqualValue(endDate)))
        .get();

    // Query Previous Period Payments
    final prevPayments = await (db.select(db.paymentsTable)
          ..where((t) => t.deletedAt.isNull())
          ..where((t) => t.receivedAt.isBiggerOrEqualValue(prevStartDate))
          ..where((t) => t.receivedAt.isSmallerOrEqualValue(prevEndDate)))
        .get();

    // Query Current Period Expenses
    final currentExpenses = await (db.select(db.expensesTable)
          ..where((t) => t.deletedAt.isNull())
          ..where((t) => t.date.isBiggerOrEqualValue(startDate))
          ..where((t) => t.date.isSmallerOrEqualValue(endDate)))
        .get();

    int currentIncomeTotal = 0;
    final Map<DateTime, List<PaymentsTableData>> paymentsByDate = {};

    for (final p in currentPayments) {
      currentIncomeTotal += p.amount;
      final d = DateTime(p.receivedAt.year, p.receivedAt.month, p.receivedAt.day);
      paymentsByDate.putIfAbsent(d, () => []).add(p);
    }

    int prevIncomeTotal = 0;
    for (final p in prevPayments) {
      prevIncomeTotal += p.amount;
    }

    // Group expenses by date
    final Map<DateTime, int> expensesByDate = {};
    for (final e in currentExpenses) {
      final d = DateTime(e.date.year, e.date.month, e.date.day);
      expensesByDate[d] = (expensesByDate[d] ?? 0) + e.amount;
    }

    // Generate daily points for every day in [startDate, endDate]
    final List<DailyMetricPoint> points = [];
    DateTime cursor = DateTime(startDate.year, startDate.month, startDate.day);
    final targetEnd = DateTime(endDate.year, endDate.month, endDate.day);

    while (!cursor.isAfter(targetEnd)) {
      final dayPayments = paymentsByDate[cursor] ?? [];
      int dayIncome = 0;
      int dayCash = 0;
      int dayUpi = 0;
      int dayCashCount = 0;
      int dayUpiCount = 0;

      for (final p in dayPayments) {
        dayIncome += p.amount;
        if (p.mode == 'cash') {
          dayCash += p.amount;
          dayCashCount++;
        } else if (p.mode == 'upi') {
          dayUpi += p.amount;
          dayUpiCount++;
        }
      }

      final dayExp = expensesByDate[cursor] ?? 0;
      final dayBachat = dayIncome - dayExp;

      points.add(DailyMetricPoint(
        date: cursor,
        income: dayIncome,
        expense: dayExp,
        bachat: dayBachat,
        cashIncome: dayCash,
        upiIncome: dayUpi,
        cashCount: dayCashCount,
        upiCount: dayUpiCount,
      ));

      cursor = cursor.add(const Duration(days: 1));
    }

    // Percentage change calculation
    double pctChange = 0.0;
    if (prevIncomeTotal > 0) {
      pctChange = ((currentIncomeTotal - prevIncomeTotal) / prevIncomeTotal) * 100;
    } else if (currentIncomeTotal > 0) {
      pctChange = 100.0;
    }

    return HistorySummaryData(
      currentTotalIncome: currentIncomeTotal,
      previousTotalIncome: prevIncomeTotal,
      percentageChange: pctChange,
      dailyPoints: points,
      paymentsByDate: paymentsByDate,
    );
  }
}
