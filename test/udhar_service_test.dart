import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:kanta_slip/data/db/app_database.dart';
import 'package:kanta_slip/features/udhar/domain/services/udhar_service.dart';

void main() {
  late AppDatabase db;
  late UdharService udharService;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    udharService = UdharService(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('Oldest-first allocation 40 slips example: ₹500 jama clears 10 oldest slips, 30 slips / ₹1,500 remaining', () {
    final baseDate = DateTime(2026, 10, 1);
    final unpaidSlips = List.generate(40, (i) {
      return SlipsTableData(
        id: 'slip_$i',
        receiptNo: 2000 + i,
        date: baseDate.add(Duration(days: i)),
        charge: 50,
        status: 'udhar',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        reprintCount: 0,
        synced: false,
      );
    });

    final alloc = UdharService.calculateOldestFirstAllocation(
      jamaAmount: 500,
      unpaidSlips: unpaidSlips,
    );

    expect(alloc.clearedSlipsCount, 10);
    expect(alloc.remainingSlipsCount, 30);
    expect(alloc.remainingBalance, 1500);
    expect(alloc.clearedSlipIds.length, 10);
    expect(alloc.clearedSlipIds.first, 'slip_0'); // Oldest
  });

  test('recordJamaPayment creates payment J-0001 and updates income and slips', () async {
    final cust = await (db.select(db.udharCustomersTable)).getSingle(); // Sonu

    final paymentId = await udharService.recordJamaPayment(
      customerId: cust.id,
      amount: 500,
      mode: 'cash',
    );

    expect(paymentId, isNotEmpty);

    final payment = await (db.select(db.paymentsTable)..where((t) => t.id.equals(paymentId))).getSingle();
    expect(payment.receiptNo, 'J-0001');
    expect(payment.kind, 'udhar_jama');
    expect(payment.amount, 500);

    // Unpaid slips remaining count should now be 30
    final remainingUnpaid = await (db.select(db.slipsTable)
          ..where((t) => t.udharCustomerId.equals(cust.id))
          ..where((t) => t.status.equals('udhar')))
        .get();
    expect(remainingUnpaid.length, 30);
  });
}
