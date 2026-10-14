import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:kanta_slip/data/db/app_database.dart';
import 'package:kanta_slip/data/db/slip_repository.dart';

void main() {
  late AppDatabase db;
  late SlipRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = SlipRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('SlipRepository saves slip and rounds to database cleanly', () async {
    final initialNext = await repo.peekNextReceiptNumber();
    final nextReceipt = await repo.getNextReceiptNumber();
    expect(nextReceipt, initialNext);

    final slipId = await repo.saveSlip(
      receiptNo: nextReceipt,
      dateStr: '01/01/2026',
      customerName: 'Suresh Kumar',
      vehicleNo: 'RJ 31 GA 5555',
      totalNetWeight: 20000,
      charge: 400,
      rounds: [
        {
          'material': 'सीमेंट',
          'gross': 25000,
          'tare': 5000,
          'driverTare': null,
          'bagExtra': '400 bag cement',
        }
      ],
    );

    expect(slipId, isNotEmpty);

    final savedSlip = await repo.getSlipById(slipId);
    expect(savedSlip, isNotNull);
    expect(savedSlip!.customerName, 'Suresh Kumar');
    expect(savedSlip.vehicleNo, 'RJ 31 GA 5555');
    expect(savedSlip.charge, 400);

    final rounds = await repo.getRoundsForSlip(slipId);
    expect(rounds.length, 1);
    expect(rounds.first.grossKg, 25000);
    expect(rounds.first.emptyTulaneKg, 5000);
    expect(rounds.first.netKg, 20000);

    final nextReceiptAfter = await repo.peekNextReceiptNumber();
    expect(nextReceiptAfter, nextReceipt + 1);
  });
}
