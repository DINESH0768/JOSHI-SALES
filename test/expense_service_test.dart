import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:kanta_slip/data/db/app_database.dart';
import 'package:kanta_slip/data/db/slip_repository.dart';
import 'package:kanta_slip/features/kharcha/domain/services/expense_service.dart';
import 'package:kanta_slip/features/payments/domain/services/payment_service.dart';

void main() {
  late AppDatabase db;
  late SlipRepository slipRepo;
  late PaymentService paymentService;
  late ExpenseService expenseService;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    slipRepo = SlipRepository(db);
    paymentService = PaymentService(db);
    expenseService = ExpenseService(db);

    // Clear initial seeded expenses for clean unit test assertion
    await db.delete(db.expensesTable).go();
  });

  tearDown(() async {
    await db.close();
  });

  test('Bachat calculation correctly subtracts expenses from income received', () async {
    final now = DateTime.now();

    // 1. Record ₹1,000 cash income
    final slipId = await slipRepo.saveSlip(
      receiptNo: 1001,
      dateStr: '11/10/2026',
      customerName: 'Test Customer',
      vehicleNo: 'RJ 31 GA 1111',
      totalNetWeight: 10000,
      charge: 1000,
      rounds: [
        {'material': 'Gehun', 'gross': 20000, 'tare': 10000}
      ],
    );
    await paymentService.recordCashPayment(slipId: slipId, amount: 1000);

    // 2. Add ₹300 expense
    await expenseService.addExpense(
      name: 'Chai-pani',
      amount: 300,
      mode: 'cash',
      date: now,
      note: 'Nashta',
    );

    // 3. Check monthly summary
    final summary = await expenseService.getMonthlySummary(now);
    expect(summary['totalIncome'], 1000);
    expect(summary['totalExpense'], 300);
    expect(summary['bachat'], 700); // 1000 - 300 = 700
  });

  test('Cash in hand calculation correctly subtracts cash expenses from cash income', () async {
    final now = DateTime.now();

    // Cash income: ₹800
    final slip1 = await slipRepo.saveSlip(
      receiptNo: 1002,
      dateStr: '11/10/2026',
      customerName: 'A',
      vehicleNo: 'RJ 01 1111',
      totalNetWeight: 5000,
      charge: 800,
      rounds: [
        {'material': 'Rice', 'gross': 15000, 'tare': 10000}
      ],
    );
    await paymentService.recordCashPayment(slipId: slip1, amount: 800);

    // UPI income: ₹500 (does not affect Cash in hand)
    final slip2 = await slipRepo.saveSlip(
      receiptNo: 1003,
      dateStr: '11/10/2026',
      customerName: 'B',
      vehicleNo: 'RJ 01 2222',
      totalNetWeight: 5000,
      charge: 500,
      rounds: [
        {'material': 'Rice', 'gross': 15000, 'tare': 10000}
      ],
    );
    await paymentService.recordUpiPayment(slipId: slip2, amount: 500);

    // Cash expense: ₹250
    await expenseService.addExpense(
      name: 'Majduri',
      amount: 250,
      mode: 'cash',
      date: now,
    );

    // UPI expense: ₹100 (does not affect Cash in hand)
    await expenseService.addExpense(
      name: 'Bijli',
      amount: 100,
      mode: 'upi',
      date: now,
    );

    final cashExp = await expenseService.getCashExpensesForDate(now);
    expect(cashExp, 250);

    final incomeSummary = await paymentService.getIncomeSummaryForDate(now);
    final cashIncome = incomeSummary['cashTotal'] as int;
    expect(cashIncome, 800);

    final cashInHand = cashIncome - cashExp;
    expect(cashInHand, 550); // 800 - 250 = 550
  });

  test('Soft delete and undo delete expense work as expected', () async {
    final now = DateTime.now();
    final id = await expenseService.addExpense(
      name: 'Repair',
      amount: 500,
      mode: 'cash',
      date: now,
    );

    var summary = await expenseService.getMonthlySummary(now);
    expect(summary['totalExpense'], 500);

    // Soft delete
    await expenseService.softDeleteExpense(id);
    summary = await expenseService.getMonthlySummary(now);
    expect(summary['totalExpense'], 0);

    // Undo delete
    await expenseService.undoDeleteExpense(id);
    summary = await expenseService.getMonthlySummary(now);
    expect(summary['totalExpense'], 500);
  });
}
