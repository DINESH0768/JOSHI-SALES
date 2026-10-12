import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../../data/db/app_database.dart';

class SupplierService {
  final AppDatabase db;
  final Uuid _uuid = const Uuid();

  SupplierService(this.db);

  Future<List<SuppliersTableData>> getAllSuppliers() async {
    return (db.select(db.suppliersTable)
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm(expression: t.name)]))
        .get();
  }

  Future<SuppliersTableData?> getSupplierById(String id) async {
    return (db.select(db.suppliersTable)
          ..where((t) => t.id.equals(id))
          ..where((t) => t.deletedAt.isNull()))
        .getSingleOrNull();
  }

  Future<String> createSupplier({
    required String name,
    String? category,
    int? ratePerUnit,
    String? unitName,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();

    await db.into(db.suppliersTable).insert(
          SuppliersTableCompanion.insert(
            id: id,
            name: name,
            category: Value(category),
            ratePerUnit: Value(ratePerUnit),
            unitName: Value(unitName),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return id;
  }

  Future<void> updateSupplier({
    required String id,
    required String name,
    String? category,
    int? ratePerUnit,
    String? unitName,
  }) async {
    final now = DateTime.now();
    await (db.update(db.suppliersTable)..where((t) => t.id.equals(id))).write(
      SuppliersTableCompanion(
        name: Value(name),
        category: Value(category),
        ratePerUnit: Value(ratePerUnit),
        unitName: Value(unitName),
        updatedAt: Value(now),
      ),
    );
  }

  Future<int> getSupplierBalance(String supplierId) async {
    final entries = await (db.select(db.supplierEntriesTable)
          ..where((t) => t.supplierId.equals(supplierId))
          ..where((t) => t.deletedAt.isNull()))
        .get();

    final payments = await (db.select(db.supplierPaymentsTable)
          ..where((t) => t.supplierId.equals(supplierId))
          ..where((t) => t.deletedAt.isNull()))
        .get();

    int totalEntries = 0;
    for (final e in entries) {
      totalEntries += e.amount;
    }

    int totalPayments = 0;
    for (final p in payments) {
      totalPayments += p.amount;
    }

    return totalEntries - totalPayments;
  }

  Future<int> getTotalSuppliersDenaBaki() async {
    final suppliers = await getAllSuppliers();
    int total = 0;
    for (final s in suppliers) {
      final bal = await getSupplierBalance(s.id);
      if (bal > 0) {
        total += bal;
      }
    }
    return total;
  }

  Future<String> addSupplierEntry({
    required String supplierId,
    required DateTime date,
    required int amount,
    int? count,
    String? note,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();

    await db.into(db.supplierEntriesTable).insert(
          SupplierEntriesTableCompanion.insert(
            id: id,
            supplierId: supplierId,
            date: date,
            amount: amount,
            count: Value(count),
            note: Value(note),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return id;
  }

  Future<String> recordSupplierPayment({
    required String supplierId,
    required int amount,
    required String mode, // 'cash' or 'upi'
    required DateTime date,
    String? note,
  }) async {
    final supplier = await getSupplierById(supplierId);
    final supplierName = supplier?.name ?? 'Supplier';

    final paymentId = _uuid.v4();
    final expenseId = _uuid.v4();
    final now = DateTime.now();

    // 1. Create linked Expense row
    await db.into(db.expensesTable).insert(
          ExpensesTableCompanion.insert(
            id: expenseId,
            name: supplier?.category != null && supplier!.category!.isNotEmpty
                ? supplier.category!
                : 'Supplier Payment: $supplierName',
            amount: amount,
            mode: mode,
            date: date,
            note: Value(note ?? 'Payment to $supplierName'),
            createdAt: now,
            updatedAt: now,
          ),
        );

    // 2. Create Supplier Payment row
    await db.into(db.supplierPaymentsTable).insert(
          SupplierPaymentsTableCompanion.insert(
            id: paymentId,
            supplierId: supplierId,
            amount: amount,
            mode: mode,
            date: date,
            expenseId: Value(expenseId),
            createdAt: now,
            updatedAt: now,
          ),
        );

    return paymentId;
  }

  Future<List<Map<String, dynamic>>> getPooraHisaab(String supplierId) async {
    final entries = await (db.select(db.supplierEntriesTable)
          ..where((t) => t.supplierId.equals(supplierId))
          ..where((t) => t.deletedAt.isNull()))
        .get();

    final payments = await (db.select(db.supplierPaymentsTable)
          ..where((t) => t.supplierId.equals(supplierId))
          ..where((t) => t.deletedAt.isNull()))
        .get();

    final List<Map<String, dynamic>> combined = [];

    for (final e in entries) {
      combined.add({
        'id': e.id,
        'type': 'entry', // charge/entry (increases baki)
        'date': e.date,
        'amount': e.amount,
        'count': e.count,
        'note': e.note,
        'createdAt': e.createdAt,
      });
    }

    for (final p in payments) {
      combined.add({
        'id': p.id,
        'type': 'payment', // payment (reduces baki)
        'date': p.date,
        'amount': p.amount,
        'mode': p.mode,
        'createdAt': p.createdAt,
      });
    }

    // Sort chronologically (oldest first) to calculate running balance
    combined.sort((a, b) {
      final dateA = a['date'] as DateTime;
      final dateB = b['date'] as DateTime;
      final comp = dateA.compareTo(dateB);
      if (comp != 0) return comp;
      final createdA = a['createdAt'] as DateTime;
      final createdB = b['createdAt'] as DateTime;
      return createdA.compareTo(createdB);
    });

    int runningBalance = 0;
    for (final item in combined) {
      if (item['type'] == 'entry') {
        runningBalance += (item['amount'] as int);
      } else {
        runningBalance -= (item['amount'] as int);
      }
      item['runningBalance'] = runningBalance;
    }

    // Return newest first for display
    return combined.reversed.toList();
  }

  Future<List<SupplierPaymentsTableData>> getDiyeHuePaise(String supplierId) async {
    return (db.select(db.supplierPaymentsTable)
          ..where((t) => t.supplierId.equals(supplierId))
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)]))
        .get();
  }
}
