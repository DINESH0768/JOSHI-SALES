import 'package:drift/drift.dart';
import '../../../../data/db/app_database.dart';

class PaymentService {
  final AppDatabase db;

  PaymentService(this.db);

  /// Record cash payment for a slip
  Future<void> recordCashPayment({
    required String slipId,
    required double amount,
  }) async {
    await db.transaction(() async {
      final paymentId = 'pay_${DateTime.now().millisecondsSinceEpoch}';

      // 1. Insert into paymentsTable
      await db.into(db.paymentsTable).insert(
            PaymentsTableCompanion.insert(
              id: paymentId,
              slipId: Value(slipId),
              amount: amount.toInt(),
              mode: 'cash',
              receivedAt: DateTime.now(),
              kind: 'slip',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );

      // 2. Update slip status & payment mode
      await (db.update(db.slipsTable)..where((t) => t.id.equals(slipId))).write(
            SlipsTableCompanion(
              status: const Value('received'),
              paymentMode: const Value('cash'),
              receivedAt: Value(DateTime.now()),
              updatedAt: Value(DateTime.now()),
            ),
          );

      // 3. Log audit action
      await db.into(db.auditLogTable).insert(
            AuditLogTableCompanion.insert(
              id: 'audit_${DateTime.now().millisecondsSinceEpoch}',
              targetType: 'slip',
              entityId: slipId,
              action: 'mark_received_cash',
              detailsJson: '{"amount": $amount}',
              createdAt: DateTime.now(),
            ),
          );
    });
  }

  /// Record UPI payment for a slip
  Future<void> recordUpiPayment({
    required String slipId,
    required double amount,
  }) async {
    await db.transaction(() async {
      final paymentId = 'pay_${DateTime.now().millisecondsSinceEpoch}';

      // 1. Insert into paymentsTable
      await db.into(db.paymentsTable).insert(
            PaymentsTableCompanion.insert(
              id: paymentId,
              slipId: Value(slipId),
              amount: amount.toInt(),
              mode: 'upi',
              receivedAt: DateTime.now(),
              kind: 'slip',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );

      // 2. Update slip status & payment mode
      await (db.update(db.slipsTable)..where((t) => t.id.equals(slipId))).write(
            SlipsTableCompanion(
              status: const Value('received'),
              paymentMode: const Value('upi'),
              receivedAt: Value(DateTime.now()),
              updatedAt: Value(DateTime.now()),
            ),
          );

      // 3. Log audit action
      await db.into(db.auditLogTable).insert(
            AuditLogTableCompanion.insert(
              id: 'audit_${DateTime.now().millisecondsSinceEpoch}',
              targetType: 'slip',
              entityId: slipId,
              action: 'mark_received_upi',
              detailsJson: '{"amount": $amount}',
              createdAt: DateTime.now(),
            ),
          );
    });
  }

  /// Mark slip as Pending
  Future<void> markSlipPending(String slipId) async {
    await (db.update(db.slipsTable)..where((t) => t.id.equals(slipId))).write(
          SlipsTableCompanion(
            status: const Value('pending'),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }

  /// Move/Allocate slip to Udhar customer
  Future<void> allocateToUdhar({
    required String slipId,
    required String customerName,
  }) async {
    await db.transaction(() async {
      // 1. Find or create Udhar Customer
      var udharCust = await (db.select(db.udharCustomersTable)
            ..where((t) => t.name.equals(customerName.trim())))
          .getSingleOrNull();

      if (udharCust == null) {
        final udharCustId = 'udhar_cust_${DateTime.now().millisecondsSinceEpoch}';
        await db.into(db.udharCustomersTable).insert(
              UdharCustomersTableCompanion.insert(
                id: udharCustId,
                name: customerName.trim(),
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
            );
        udharCust = await (db.select(db.udharCustomersTable)
              ..where((t) => t.id.equals(udharCustId)))
            .getSingle();
      }

      // 2. Update slip status to 'udhar'
      await (db.update(db.slipsTable)..where((t) => t.id.equals(slipId))).write(
            SlipsTableCompanion(
              status: const Value('udhar'),
              udharCustomerId: Value(udharCust.id),
              updatedAt: Value(DateTime.now()),
            ),
          );

      // 3. Log audit action
      await db.into(db.auditLogTable).insert(
            AuditLogTableCompanion.insert(
              id: 'audit_${DateTime.now().millisecondsSinceEpoch}',
              targetType: 'slip',
              entityId: slipId,
              action: 'move_to_udhar',
              detailsJson: '{"customer": "$customerName"}',
              createdAt: DateTime.now(),
            ),
          );
    });
  }

  /// Calculate total received income for a given date
  Future<Map<String, dynamic>> getIncomeSummaryForDate(DateTime targetDate) async {
    final startOfDay = DateTime(targetDate.year, targetDate.month, targetDate.day);
    final endOfDay = DateTime(targetDate.year, targetDate.month, targetDate.day, 23, 59, 59);

    final payments = await (db.select(db.paymentsTable)
          ..where((t) => t.receivedAt.isBetweenValues(startOfDay, endOfDay)))
        .get();

    int cashTotal = 0;
    int upiTotal = 0;
    int cashCount = 0;
    int upiCount = 0;

    for (var p in payments) {
      if (p.mode == 'cash') {
        cashTotal += p.amount;
        cashCount++;
      } else if (p.mode == 'upi') {
        upiTotal += p.amount;
        upiCount++;
      }
    }

    return {
      'totalIncome': cashTotal + upiTotal,
      'cashTotal': cashTotal,
      'upiTotal': upiTotal,
      'cashCount': cashCount,
      'upiCount': upiCount,
      'payments': payments,
    };
  }
}
