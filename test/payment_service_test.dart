import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:kanta_slip/data/db/app_database.dart';
import 'package:kanta_slip/data/db/slip_repository.dart';
import 'package:kanta_slip/features/payments/domain/services/payment_service.dart';

void main() {
  late AppDatabase db;
  late SlipRepository slipRepo;
  late PaymentService paymentService;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    slipRepo = SlipRepository(db);
    paymentService = PaymentService(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('recordCashPayment marks slip as received cash and records payment', () async {
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

    await paymentService.recordCashPayment(slipId: slipId, amount: 400);

    final slip = await slipRepo.getSlipById(slipId);
    expect(slip?.status, 'received');
    expect(slip?.paymentMode, 'cash');

    final summary = await paymentService.getIncomeSummaryForDate(DateTime.now());
    expect(summary['totalIncome'], 400);
    expect(summary['cashTotal'], 400);
    expect(summary['upiTotal'], 0);
  });

  test('recordUpiPayment marks slip as received upi and records payment', () async {
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

    await paymentService.recordUpiPayment(slipId: slipId, amount: 500);

    final slip = await slipRepo.getSlipById(slipId);
    expect(slip?.status, 'received');
    expect(slip?.paymentMode, 'upi');

    final summary = await paymentService.getIncomeSummaryForDate(DateTime.now());
    expect(summary['totalIncome'], 500);
    expect(summary['upiTotal'], 500);
    expect(summary['cashTotal'], 0);
  });

  test('allocateToUdhar marks slip as udhar and assigns udhar customer', () async {
    final slipId = await slipRepo.saveSlip(
      receiptNo: 1034,
      dateStr: '11/10/2026',
      customerName: 'Sonu',
      vehicleNo: 'RJ 07 CC 8812',
      totalNetWeight: 15000,
      charge: 450,
      rounds: [
        {'material': 'Sariya', 'gross': 25000, 'tare': 10000}
      ],
    );

    await paymentService.allocateToUdhar(slipId: slipId, customerName: 'Sonu');

    final slip = await slipRepo.getSlipById(slipId);
    expect(slip?.status, 'udhar');
    expect(slip?.udharCustomerId, isNotNull);

    // Udhar is NOT counted in income
    final summary = await paymentService.getIncomeSummaryForDate(DateTime.now());
    expect(summary['totalIncome'], 0);
  });
}
