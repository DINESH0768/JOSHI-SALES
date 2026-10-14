import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
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
    // Insert a test customer and 40 test udhar slips into in-memory DB
    const custId = 'udhar_test_sonu';
    await db.into(db.udharCustomersTable).insert(
          UdharCustomersTableCompanion.insert(
            id: custId,
            name: 'Sonu',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );

    final baseDate = DateTime(2026, 10, 1);
    for (int i = 1; i <= 40; i++) {
      final slipId = 'sonu_slip_$i';
      final slipDate = baseDate.add(Duration(days: i ~/ 2));
      await db.into(db.slipsTable).insert(
            SlipsTableCompanion.insert(
              id: slipId,
              receiptNo: 2000 + i,
              date: slipDate,
              customerName: const Value('Sonu'),
              vehicleNo: const Value('RJ 31 GA 0000'),
              charge: 50,
              status: 'udhar',
              udharCustomerId: const Value(custId),
              createdAt: slipDate,
              updatedAt: slipDate,
            ),
          );
    }

    final cust = await (db.select(db.udharCustomersTable)..where((t) => t.id.equals(custId))).getSingle();

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
