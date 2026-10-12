import 'package:drift/drift.dart';
import '../../../../data/db/app_database.dart';

class AllocationResult {
  final int clearedSlipsCount;
  final int remainingSlipsCount;
  final int remainingBalance;
  final List<String> clearedSlipIds;

  AllocationResult({
    required this.clearedSlipsCount,
    required this.remainingSlipsCount,
    required this.remainingBalance,
    required this.clearedSlipIds,
  });
}

class UdharService {
  final AppDatabase db;

  UdharService(this.db);

  /// Calculate oldest-first allocation for a jama payment
  static AllocationResult calculateOldestFirstAllocation({
    required int jamaAmount,
    required List<SlipsTableData> unpaidSlips,
  }) {
    // Sort oldest first
    final sortedSlips = List<SlipsTableData>.from(unpaidSlips)
      ..sort((a, b) => a.date.compareTo(b.date));

    int remainingJama = jamaAmount;
    final clearedSlipIds = <String>[];
    int clearedCount = 0;

    for (var slip in sortedSlips) {
      if (remainingJama >= slip.charge) {
        remainingJama -= slip.charge;
        clearedSlipIds.add(slip.id);
        clearedCount++;
      } else {
        break;
      }
    }

    final totalUnpaidCount = unpaidSlips.length;
    final totalUnpaidAmount = unpaidSlips.fold(0, (sum, s) => sum + s.charge);

    final remainingSlipsCount = totalUnpaidCount - clearedCount;
    final remainingBalance = totalUnpaidAmount - (jamaAmount - remainingJama);

    return AllocationResult(
      clearedSlipsCount: clearedCount,
      remainingSlipsCount: remainingSlipsCount,
      remainingBalance: remainingBalance > 0 ? remainingBalance : 0,
      clearedSlipIds: clearedSlipIds,
    );
  }

  /// Get next J-0001 format receipt number
  Future<String> getNextJamaReceiptNumber() async {
    final counter = await (db.select(db.countersTable)
          ..where((t) => t.name.equals('jama_receipt')))
        .getSingleOrNull();

    final nextVal = counter?.currentValue ?? 1;

    await (db.update(db.countersTable)..where((t) => t.name.equals('jama_receipt')))
        .write(CountersTableCompanion(currentValue: Value(nextVal + 1)));

    return 'J-${nextVal.toString().padLeft(4, '0')}';
  }

  /// Record Jama Payment with oldest-first allocation
  Future<String> recordJamaPayment({
    required String customerId,
    required int amount,
    required String mode, // 'cash' or 'upi'
  }) async {
    final receiptNoStr = await getNextJamaReceiptNumber();
    final paymentId = 'pay_jama_${DateTime.now().millisecondsSinceEpoch}';

    final unpaidSlips = await (db.select(db.slipsTable)
          ..where((t) => t.udharCustomerId.equals(customerId))
          ..where((t) => t.status.equals('udhar'))
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .get();

    final allocation = calculateOldestFirstAllocation(
      jamaAmount: amount,
      unpaidSlips: unpaidSlips,
    );

    await db.transaction(() async {
      // 1. Record payment in paymentsTable (kind = 'udhar_jama' = Income)
      await db.into(db.paymentsTable).insert(
            PaymentsTableCompanion.insert(
              id: paymentId,
              udharCustomerId: Value(customerId),
              amount: amount,
              mode: mode,
              receivedAt: DateTime.now(),
              kind: 'udhar_jama',
              receiptNo: Value(receiptNoStr),
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );

      // 2. Mark cleared slips as received
      for (var slipId in allocation.clearedSlipIds) {
        await (db.update(db.slipsTable)..where((t) => t.id.equals(slipId))).write(
              SlipsTableCompanion(
                status: const Value('received'),
                paymentMode: Value(mode),
                receivedAt: Value(DateTime.now()),
                updatedAt: Value(DateTime.now()),
              ),
            );

        // 3. Record Udhar Allocation
        await db.into(db.udharAllocationsTable).insert(
              UdharAllocationsTableCompanion.insert(
                id: 'alloc_${DateTime.now().millisecondsSinceEpoch}_$slipId',
                paymentId: paymentId,
                slipId: slipId,
                amountApplied: amount,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
            );
      }
    });

    return paymentId;
  }

  /// Settle full account ("Poora hisaab")
  Future<String> pooraHisaabSettle({
    required String customerId,
    required String mode,
  }) async {
    final unpaidSlips = await (db.select(db.slipsTable)
          ..where((t) => t.udharCustomerId.equals(customerId))
          ..where((t) => t.status.equals('udhar')))
        .get();

    final totalAmount = unpaidSlips.fold(0, (sum, s) => sum + s.charge);
    return recordJamaPayment(customerId: customerId, amount: totalAmount, mode: mode);
  }
}
