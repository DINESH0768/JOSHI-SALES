import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:kanta_slip/data/db/app_database.dart';
import 'package:kanta_slip/features/kharcha/domain/services/expense_service.dart';
import 'package:kanta_slip/features/kharcha/domain/services/supplier_service.dart';

void main() {
  late AppDatabase db;
  late SupplierService supplierService;
  late ExpenseService expenseService;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    supplierService = SupplierService(db);
    expenseService = ExpenseService(db);

    // Clear initial seeded expenses for clean unit test assertion
    await db.delete(db.expensesTable).go();
  });

  tearDown(() async {
    await db.close();
  });

  test('Supplier balance calculated as total entries minus total payments', () async {
    final now = DateTime.now();
    final supplierId = await supplierService.createSupplier(
      name: 'Bhanwar Lal ji',
      category: 'Chai wale',
      ratePerUnit: 10,
      unitName: 'chai',
    );

    // Add entry 1: 40 chai @ 10 = ₹400
    await supplierService.addSupplierEntry(
      supplierId: supplierId,
      date: now,
      amount: 400,
      count: 40,
    );

    // Add entry 2: 10 chai @ 10 = ₹100
    await supplierService.addSupplierEntry(
      supplierId: supplierId,
      date: now,
      amount: 100,
      count: 10,
    );

    int balance = await supplierService.getSupplierBalance(supplierId);
    expect(balance, 500); // 400 + 100 = 500

    // Record payment ₹300
    await supplierService.recordSupplierPayment(
      supplierId: supplierId,
      amount: 300,
      mode: 'cash',
      date: now,
    );

    balance = await supplierService.getSupplierBalance(supplierId);
    expect(balance, 200); // 500 - 300 = 200
  });

  test('Supplier entry is NOT an expense, but payment creates a linked expense on payment date', () async {
    final now = DateTime.now();
    final supplierId = await supplierService.createSupplier(
      name: 'Bhanwar Lal ji',
      category: 'Chai wale',
      ratePerUnit: 10,
      unitName: 'chai',
    );

    // 1. Add supplier entry of ₹500
    await supplierService.addSupplierEntry(
      supplierId: supplierId,
      date: now,
      amount: 500,
      count: 50,
    );

    // Verify NO expense created yet
    var summary = await expenseService.getMonthlySummary(now);
    expect(summary['totalExpense'], 0);

    // 2. Pay ₹200 to supplier
    await supplierService.recordSupplierPayment(
      supplierId: supplierId,
      amount: 200,
      mode: 'cash',
      date: now,
      note: 'Advance payment',
    );

    // Verify linked expense IS created on payment date
    summary = await expenseService.getMonthlySummary(now);
    expect(summary['totalExpense'], 200);

    final expenses = summary['expenses'] as List<ExpensesTableData>;
    expect(expenses.length, 1);
    expect(expenses.first.amount, 200);
    expect(expenses.first.mode, 'cash');
  });
}
