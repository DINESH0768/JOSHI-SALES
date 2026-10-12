import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:kanta_slip/core/services/firebase_sync_service.dart';
import 'package:kanta_slip/data/db/app_database.dart';
import 'package:kanta_slip/data/db/slip_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  FlutterSecureStorage.setMockInitialValues({});

  late AppDatabase db;
  late SlipRepository slipRepo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    slipRepo = SlipRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('FirebaseSyncService marks unsynced records as synced during syncAll', () async {
    // 1. Save slip locally
    final slipId = await slipRepo.saveSlip(
      receiptNo: 3001,
      dateStr: '11/10/2026',
      customerName: 'Test Sync',
      vehicleNo: 'RJ 31 GA 3333',
      totalNetWeight: 10000,
      charge: 100,
      rounds: [
        {'material': 'Gehun', 'gross': 20000, 'tare': 10000}
      ],
    );

    var slip = await slipRepo.getSlipById(slipId);
    expect(slip?.synced, isFalse);

    // 2. Run syncAll
    final result = await FirebaseSyncService.syncAll(db);
    expect(result, isTrue);

    // 3. Verify record is now marked synced locally
    slip = await slipRepo.getSlipById(slipId);
    expect(slip?.synced, isTrue);

    final status = await FirebaseSyncService.getLastSyncedStatus();
    expect(status, isNot('Pehle sync nahi hua'));
  });
}
