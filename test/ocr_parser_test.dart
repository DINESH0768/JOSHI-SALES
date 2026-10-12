import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:kanta_slip/data/db/app_database.dart';
import 'package:kanta_slip/data/db/slip_repository.dart';
import 'package:kanta_slip/features/slips/domain/services/ocr_parser.dart';
import 'package:kanta_slip/features/slips/domain/services/ocr_voting_service.dart';

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

  test('OcrParser parses Devanagari slip text correctly (Sample 1)', () {
    const rawText = '''
जोशी कम्प्यूटराइज धर्मकांटा
रसीद नं. 1031
दिनांक: 11/10/2026
नाम श्री: मोहन लाल
वाहन नं.: RJ 31 GA 0987
माल किस्म: गेहूं
वाहन सहित माल: 52,350 kg
खाली तुलाने पर: 13,450 kg
''';

    final data = OcrParser.parseText(rawText);

    expect(data.receiptNo.value, 1031);
    expect(data.receiptNo.isHigh, isTrue);

    expect(data.dateStr.value, '11/10/2026');
    expect(data.dateStr.isHigh, isTrue);

    expect(data.customerName.value, 'मोहन लाल');
    expect(data.vehicleNo.value, 'RJ 31 GA 0987');
    expect(data.material.value, 'गेहूं');
    expect(data.grossKg.value, 52350);
    expect(data.tareKg.value, 13450);

    // Auto-recomputed net weight
    expect(data.calculatedNetKg, 38900); // 52350 - 13450 = 38900
  });

  test('OcrParser parses English slip text correctly (Sample 2)', () {
    const rawText = '''
Joshi Weighbridge
Receipt No: 1050
Date: 12/10/2026
Name: Suresh Kumar
Vehicle No: RJ 13 GB 4421
Material: Cement
Gross Weight: 30,000 kg
Tare Weight: 10,000 kg
''';

    final data = OcrParser.parseText(rawText);

    expect(data.receiptNo.value, 1050);
    expect(data.dateStr.value, '12/10/2026');
    expect(data.customerName.value, 'Suresh Kumar');
    expect(data.vehicleNo.value, 'RJ 13 GB 4421');
    expect(data.material.value, 'Cement');
    expect(data.grossKg.value, 30000);
    expect(data.tareKg.value, 10000);
    expect(data.calculatedNetKg, 20000);
  });

  test('OcrParser parses minimal Devanagari slip text (Sample 3)', () {
    const rawText = '''
क्रमांक 2005
दिनांक 15/10/2026
सरसों
RJ 07 CC 8812
सकल भार 25,000
खाली भार 8,000
''';

    final data = OcrParser.parseText(rawText);

    expect(data.receiptNo.value, 2005);
    expect(data.dateStr.value, '15/10/2026');
    expect(data.vehicleNo.value, 'RJ 07 CC 8812');
    expect(data.material.value, 'सरसों');
    expect(data.grossKg.value, 25000);
    expect(data.tareKg.value, 8000);
    expect(data.calculatedNetKg, 17000);
  });

  test('OcrVotingService consolidates multi-frame votes and detects steady match', () {
    final service = OcrVotingService();

    final f1 = OcrParser.parseText('रसीद नं. 1031\nRJ 31 GA 0987\nवाहन सहित माल 52,350 kg');
    final f2 = OcrParser.parseText('रसीद नं. 1031\nRJ 31 GA 0987\nवाहन सहित माल 52,350 kg');
    final f3 = OcrParser.parseText('रसीद नं. 1031\nRJ 31 GA 0987\nवाहन सहित माल 52,350 kg');

    service.addFrame(f1);
    expect(service.isSteadyMatch, isFalse); // Need 3 frames

    service.addFrame(f2);
    expect(service.isSteadyMatch, isFalse);

    service.addFrame(f3);
    expect(service.isSteadyMatch, isTrue); // 3 matching frames -> steady!

    final consolidated = service.getConsolidatedResult();
    expect(consolidated.receiptNo.value, 1031);
    expect(consolidated.vehicleNo.value, 'RJ 31 GA 0987');
    expect(consolidated.grossKg.value, 52350);
  });

  test('Duplicate receipt detection accurately identifies existing slips in database', () async {
    // 1. Save slip with receipt 1031
    await slipRepo.saveSlip(
      receiptNo: 1031,
      dateStr: '11/10/2026',
      customerName: 'Mohan Lal',
      vehicleNo: 'RJ 31 GA 0987',
      totalNetWeight: 38900,
      charge: 100,
      rounds: [
        {'material': 'Gehun', 'gross': 52350, 'tare': 13450}
      ],
    );

    // 2. Query duplicate check for receipt 1031
    final match = await slipRepo.getSlipByReceiptNo(1031);
    expect(match, isNotNull);
    expect(match?.customerName, 'Mohan Lal');

    // 3. Query non-existent receipt 9999
    final noMatch = await slipRepo.getSlipByReceiptNo(9999);
    expect(noMatch, isNull);
  });
}
