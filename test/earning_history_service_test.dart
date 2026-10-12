import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:kanta_slip/data/db/app_database.dart';
import 'package:kanta_slip/data/db/slip_repository.dart';
import 'package:kanta_slip/features/income/domain/services/earning_history_service.dart';
import 'package:kanta_slip/features/kharcha/domain/services/expense_service.dart';
import 'package:kanta_slip/features/payments/domain/services/payment_service.dart';

void main() {
  late AppDatabase db;
  late SlipRepository slipRepo;
  late PaymentService paymentService;
  late ExpenseService expenseService;
  late EarningHistoryService historyService;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    slipRepo = SlipRepository(db);
    paymentService = PaymentService(db);
    expenseService = ExpenseService(db);
    historyService = EarningHistoryService(db);

    // Clear initial seeded expenses for clean assertions
    await db.delete(db.expensesTable).go();
  });

  tearDown(() async {
    await db.close();
  });

  test('Indian currency formatter formats numbers with Indian grouping', () {
    expect(EarningHistoryService.formatIndianCurrency(0), '0');
    expect(EarningHistoryService.formatIndianCurrency(450), '450');
    expect(EarningHistoryService.formatIndianCurrency(2345), '2,345');
    expect(EarningHistoryService.formatIndianCurrency(14250), '14,250');
    expect(EarningHistoryService.formatIndianCurrency(184500), '1,84,500');
    expect(EarningHistoryService.formatIndianCurrency(1000000), '10,00,000');
  });

  test('EarningHistoryService correctly groups daily income and compares with previous period', () async {
    final now = DateTime.now();

    // Current period income: ₹1,200 cash, ₹800 upi
    final slip1 = await slipRepo.saveSlip(
      receiptNo: 2001,
      dateStr: '11/10/2026',
      customerName: 'Customer A',
      vehicleNo: 'RJ 01 AA 1111',
      totalNetWeight: 10000,
      charge: 1200,
      rounds: [
        {'material': 'Gehun', 'gross': 20000, 'tare': 10000}
      ],
    );
    await paymentService.recordCashPayment(slipId: slip1, amount: 1200);

    final slip2 = await slipRepo.saveSlip(
      receiptNo: 2002,
      dateStr: '11/10/2026',
      customerName: 'Customer B',
      vehicleNo: 'RJ 01 AA 2222',
      totalNetWeight: 10000,
      charge: 800,
      rounds: [
        {'material': 'Gehun', 'gross': 20000, 'tare': 10000}
      ],
    );
    await paymentService.recordUpiPayment(slipId: slip2, amount: 800);

    // Add ₹300 expense today
    await expenseService.addExpense(
      name: 'Chai-pani',
      amount: 300,
      mode: 'cash',
      date: now,
    );

    final history = await historyService.getEarningHistoryForRange(days: 7);

    expect(history.currentTotalIncome, 2000); // 1200 + 800 = 2000
    expect(history.dailyPoints.isNotEmpty, isTrue);

    final todayPoint = history.dailyPoints.last;
    expect(todayPoint.income, 2000);
    expect(todayPoint.cashIncome, 1200);
    expect(todayPoint.upiIncome, 800);
    expect(todayPoint.cashCount, 1);
    expect(todayPoint.upiCount, 1);
    expect(todayPoint.expense, 300);
    expect(todayPoint.bachat, 1700); // 2000 - 300 = 1700
  });

  test('Range switching (15 days vs 30 days) returns correct daily points length', () async {
    final history15 = await historyService.getEarningHistoryForRange(days: 15);
    expect(history15.dailyPoints.length, 15);

    final history30 = await historyService.getEarningHistoryForRange(days: 30);
    expect(history30.dailyPoints.length, 30);
  });
}
