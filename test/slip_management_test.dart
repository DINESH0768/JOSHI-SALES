import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:kanta_slip/data/db/app_database.dart';
import 'package:kanta_slip/data/db/slip_repository.dart';

void main() {
  late AppDatabase db;
  late SlipRepository slipRepo;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    slipRepo = SlipRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('incrementReprintCount increments reprint count', () async {
    final slipId = await slipRepo.saveSlip(
      receiptNo: 1032,
      dateStr: '11/10/2026',
      customerName: 'Mohan Lal',
      vehicleNo: 'RJ 31 GA 0987',
      totalNetWeight: 38900,
      charge: 400,
      rounds: [
        {'material': 'Cement', 'gross': 52350, 'tare': 13450}
      ],
    );

    var slip = await slipRepo.getSlipById(slipId);
    expect(slip?.reprintCount, 0);

    await slipRepo.incrementReprintCount(slipId);
    slip = await slipRepo.getSlipById(slipId);
    expect(slip?.reprintCount, 1);
  });

  test('softDeleteSlip and undoDeleteSlip work as expected', () async {
    final slipId = await slipRepo.saveSlip(
      receiptNo: 1033,
      dateStr: '11/10/2026',
      customerName: 'Suresh Kumar',
      vehicleNo: 'RJ 13 GB 4421',
      totalNetWeight: 20000,
      charge: 500,
      rounds: [
        {'material': 'Gehun', 'gross': 30000, 'tare': 10000}
      ],
    );

    await slipRepo.softDeleteSlip(slipId);
    var allActive = await slipRepo.getAllSlips();
    expect(allActive.where((s) => s.id == slipId).isEmpty, isTrue);

    await slipRepo.undoDeleteSlip(slipId);
    allActive = await slipRepo.getAllSlips();
    expect(allActive.where((s) => s.id == slipId).isNotEmpty, isTrue);
  });

  test('editSlip updates slip and records entry in audit log', () async {
    final slipId = await slipRepo.saveSlip(
      receiptNo: 1034,
      dateStr: '11/10/2026',
      customerName: 'Old Customer',
      vehicleNo: 'RJ 07 CC 8812',
      totalNetWeight: 15000,
      charge: 450,
      rounds: [
        {'material': 'Sariya', 'gross': 25000, 'tare': 10000}
      ],
    );

    await slipRepo.editSlip(
      slipId: slipId,
      newCustomerName: 'New Customer',
      newVehicleNo: 'RJ 07 CC 8812',
      newRounds: [
        {'material': 'Sariya', 'gross': 26000, 'tare': 10000}
      ],
    );

    final updatedSlip = await slipRepo.getSlipById(slipId);
    expect(updatedSlip?.customerName, 'New Customer');

    final auditLogs = await db.select(db.auditLogTable).get();
    expect(auditLogs.where((a) => a.entityId == slipId && a.action == 'edit').isNotEmpty, isTrue);
  });
}
