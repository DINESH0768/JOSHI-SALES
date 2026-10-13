import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:kanta_slip/core/services/data_export_service.dart';
import 'package:kanta_slip/data/db/app_database.dart';
import 'package:kanta_slip/data/db/slip_repository.dart';

void main() {
  late AppDatabase db;
  late SlipRepository slipRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    slipRepo = SlipRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('DataExportService exports full JSON backup and restores roundtrip correctly', () async {
    // 1. Save slip locally
    await slipRepo.saveSlip(
      receiptNo: 4001,
      dateStr: '11/10/2026',
      customerName: 'Export Customer',
      vehicleNo: 'RJ 31 GA 4444',
      totalNetWeight: 12000,
      charge: 150,
      rounds: [
        {'material': 'Sarson', 'gross': 22000, 'tare': 10000}
      ],
    );

    // 2. Export full JSON backup
    final jsonStr = await DataExportService.exportFullJsonBackup(db);
    expect(jsonStr, isNotEmpty);

    final Map<String, dynamic> parsed = jsonDecode(jsonStr);
    expect(parsed['version'], 1);
    expect(parsed['slips'], isNotEmpty);

    // 3. Create fresh memory DB and restore backup
    final db2 = AppDatabase(NativeDatabase.memory());
    final restored = await DataExportService.restoreFullJsonBackup(db2, jsonStr);
    expect(restored, isTrue);

    final restoredRepo = SlipRepository(db2);
    final restoredSlip = await restoredRepo.getSlipByReceiptNo(4001);

    expect(restoredSlip, isNotNull);
    expect(restoredSlip?.customerName, 'Export Customer');
    expect(restoredSlip?.vehicleNo, 'RJ 31 GA 4444');

    await db2.close();
  });
}
