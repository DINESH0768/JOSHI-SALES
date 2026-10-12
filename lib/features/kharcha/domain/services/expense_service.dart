import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../data/db/app_database.dart';

class ExpenseCategoryHelper {
  static String getColorHex(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('majduri') || lower.contains('labor') || lower.contains('wage')) {
      return '#C6F432'; // Lime
    } else if (lower.contains('bijli') || lower.contains('electricity') || lower.contains('power')) {
      return '#8FA8FF'; // Blue
    } else if (lower.contains('chai') || lower.contains('tea') || lower.contains('nashta')) {
      return '#F2B24A'; // Amber
    } else if (lower.contains('repair') || lower.contains('maintenance') || lower.contains('fix')) {
      return '#FF8A65'; // Coral/Orange
    } else if (lower.contains('rent') || lower.contains('kiraya')) {
      return '#B39DDB'; // Purple
    }
    return '#A8A8AE'; // Muted Grey
  }

  static String getIconName(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('majduri') || lower.contains('labor') || lower.contains('wage')) {
      return 'people';
    } else if (lower.contains('bijli') || lower.contains('electricity') || lower.contains('power')) {
      return 'zap';
    } else if (lower.contains('chai') || lower.contains('tea') || lower.contains('nashta')) {
      return 'coffee';
    } else if (lower.contains('repair') || lower.contains('maintenance') || lower.contains('fix')) {
      return 'tool';
    } else if (lower.contains('rent') || lower.contains('kiraya')) {
      return 'home';
    }
    return 'receipt';
  }
}

class ExpenseService {
  final AppDatabase db;
  final Uuid _uuid = const Uuid();

  ExpenseService(this.db);

  Future<String> addExpense({
    required String name,
    required int amount,
    required String mode, // 'cash' or 'upi'
    required DateTime date,
    String? note,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();

    await db.into(db.expensesTable).insert(
          ExpensesTableCompanion.insert(
            id: id,
            name: name,
            amount: amount,
            mode: mode,
            date: date,
            note: Value(note),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return id;
  }

  Future<void> updateExpense({
    required String id,
    required String name,
    required int amount,
    required String mode,
    required DateTime date,
    String? note,
  }) async {
    final now = DateTime.now();
    await (db.update(db.expensesTable)..where((t) => t.id.equals(id))).write(
      ExpensesTableCompanion(
        name: Value(name),
        amount: Value(amount),
        mode: Value(mode),
        date: Value(date),
        note: Value(note),
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> softDeleteExpense(String id) async {
    final now = DateTime.now();
    await (db.update(db.expensesTable)..where((t) => t.id.equals(id))).write(
      ExpensesTableCompanion(
        deletedAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  Future<void> undoDeleteExpense(String id) async {
    final now = DateTime.now();
    await (db.update(db.expensesTable)..where((t) => t.id.equals(id))).write(
      ExpensesTableCompanion(
        deletedAt: const Value(null),
        updatedAt: Value(now),
      ),
    );
  }

  Future<Map<String, dynamic>> getMonthlySummary(DateTime monthDate) async {
    final startOfMonth = DateTime(monthDate.year, monthDate.month, 1);
    final endOfMonth = DateTime(monthDate.year, monthDate.month + 1, 1).subtract(const Duration(milliseconds: 1));

    // Fetch Income received in this month from PaymentsTable
    final payments = await (db.select(db.paymentsTable)
          ..where((t) => t.deletedAt.isNull())
          ..where((t) => t.receivedAt.isBiggerOrEqualValue(startOfMonth))
          ..where((t) => t.receivedAt.isSmallerOrEqualValue(endOfMonth)))
        .get();

    int totalIncome = 0;
    for (final p in payments) {
      totalIncome += p.amount;
    }

    // Fetch Expenses in this month from ExpensesTable
    final expenses = await (db.select(db.expensesTable)
          ..where((t) => t.deletedAt.isNull())
          ..where((t) => t.date.isBiggerOrEqualValue(startOfMonth))
          ..where((t) => t.date.isSmallerOrEqualValue(endOfMonth))
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)]))
        .get();

    int totalExpense = 0;
    final Map<String, int> categoryTotals = {};

    for (final e in expenses) {
      totalExpense += e.amount;
      categoryTotals[e.name] = (categoryTotals[e.name] ?? 0) + e.amount;
    }

    final int bachat = totalIncome - totalExpense;

    return {
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
      'bachat': bachat,
      'expenses': expenses,
      'categoryTotals': categoryTotals,
    };
  }

  Future<int> getCashExpensesForDate(DateTime calendarDate) async {
    final startOfDay = DateTime(calendarDate.year, calendarDate.month, calendarDate.day);
    final endOfDay = DateTime(calendarDate.year, calendarDate.month, calendarDate.day, 23, 59, 59, 999);

    final expenses = await (db.select(db.expensesTable)
          ..where((t) => t.deletedAt.isNull())
          ..where((t) => t.mode.equals('cash'))
          ..where((t) => t.date.isBiggerOrEqualValue(startOfDay))
          ..where((t) => t.date.isSmallerOrEqualValue(endOfDay)))
        .get();

    int total = 0;
    for (final e in expenses) {
      total += e.amount;
    }
    return total;
  }
}
