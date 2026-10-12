import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:drift/drift.dart';
import 'app_database.dart';

class SlipDraftStorage {
  static const _storage = FlutterSecureStorage();
  static const _draftKey = 'new_slip_draft';

  static Future<void> saveDraft(Map<String, dynamic> data) async {
    try {
      await _storage.write(key: _draftKey, value: jsonEncode(data));
    } catch (_) {}
  }

  static Future<Map<String, dynamic>?> loadDraft() async {
    try {
      final str = await _storage.read(key: _draftKey);
      if (str != null && str.isNotEmpty) {
        return jsonDecode(str) as Map<String, dynamic>;
      }
    } catch (_) {}
    return null;
  }

  static Future<void> clearDraft() async {
    try {
      await _storage.delete(key: _draftKey);
    } catch (_) {}
  }
}

class SlipRepository {
  final AppDatabase db;

  SlipRepository(this.db);

  /// Get next auto-incremented receipt number and increment counter
  Future<int> getNextReceiptNumber() async {
    final counter = await (db.select(db.countersTable)
          ..where((t) => t.name.equals('slip_receipt')))
        .getSingleOrNull();

    final nextVal = (counter?.currentValue ?? 1031) + 1;

    if (counter == null) {
      await db.into(db.countersTable).insert(
            CountersTableCompanion.insert(name: 'slip_receipt', currentValue: nextVal),
          );
    } else {
      await (db.update(db.countersTable)..where((t) => t.name.equals('slip_receipt')))
          .write(CountersTableCompanion(currentValue: Value(nextVal)));
    }

    return nextVal;
  }

  /// Peek next receipt number without incrementing counter
  Future<int> peekNextReceiptNumber() async {
    final counter = await (db.select(db.countersTable)
          ..where((t) => t.name.equals('slip_receipt')))
        .getSingleOrNull();

    return (counter?.currentValue ?? 1031) + 1;
  }

  /// Insert slip and its rounds inside a transaction
  Future<String> saveSlip({
    required int receiptNo,
    required String dateStr,
    String? customerName,
    String? vehicleNo,
    required double totalNetWeight,
    required double charge,
    required List<Map<String, dynamic>> rounds,
  }) async {
    final slipId = 'slip_${DateTime.now().millisecondsSinceEpoch}';

    await db.transaction(() async {
      await db.into(db.slipsTable).insert(
            SlipsTableCompanion.insert(
              id: slipId,
              receiptNo: receiptNo,
              date: DateTime.now(),
              customerName: Value(customerName),
              vehicleNo: Value(vehicleNo),
              charge: charge.toInt(),
              status: 'pending',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );

      for (int i = 0; i < rounds.length; i++) {
        final r = rounds[i];
        final gross = (r['gross'] as num).toInt();
        final tare = (r['tare'] as num).toInt();
        final net = gross - tare;

        await db.into(db.slipRoundsTable).insert(
              SlipRoundsTableCompanion.insert(
                id: '${slipId}_round_${i + 1}',
                slipId: slipId,
                roundNo: i + 1,
                material: Value(r['material'] as String?),
                grossKg: gross,
                emptyTulaneKg: Value(tare),
                emptyDriverKg: Value((r['driverTare'] as num?)?.toInt()),
                netKg: net,
                extra: Value(r['bagExtra'] as String?),
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
            );
      }

      // Upsert customer/vehicle suggestions
      if (customerName != null && customerName.trim().isNotEmpty) {
        final existingCust = await (db.select(db.customersTable)
              ..where((t) => t.name.equals(customerName.trim())))
            .getSingleOrNull();
        if (existingCust == null) {
          await db.into(db.customersTable).insert(
                CustomersTableCompanion.insert(
                  id: 'cust_${DateTime.now().millisecondsSinceEpoch}',
                  name: customerName.trim(),
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
              );
        }
      }

      if (vehicleNo != null && vehicleNo.trim().isNotEmpty) {
        final existingVeh = await (db.select(db.vehiclesTable)
              ..where((t) => t.number.equals(vehicleNo.trim().toUpperCase())))
            .getSingleOrNull();
        if (existingVeh == null) {
          await db.into(db.vehiclesTable).insert(
                VehiclesTableCompanion.insert(
                  id: 'veh_${DateTime.now().millisecondsSinceEpoch}',
                  number: vehicleNo.trim().toUpperCase(),
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
              );
        }
      }
    });

    return slipId;
  }

  /// Increment reprint count on print or share
  Future<void> incrementReprintCount(String slipId) async {
    final slip = await getSlipById(slipId);
    if (slip != null) {
      await (db.update(db.slipsTable)..where((t) => t.id.equals(slipId))).write(
            SlipsTableCompanion(
              reprintCount: Value(slip.reprintCount + 1),
              updatedAt: Value(DateTime.now()),
            ),
          );
    }
  }

  /// Soft delete slip
  Future<void> softDeleteSlip(String slipId) async {
    await (db.update(db.slipsTable)..where((t) => t.id.equals(slipId))).write(
          SlipsTableCompanion(
            deletedAt: Value(DateTime.now()),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }

  /// Undo soft delete
  Future<void> undoDeleteSlip(String slipId) async {
    await (db.update(db.slipsTable)..where((t) => t.id.equals(slipId))).write(
          const SlipsTableCompanion(
            deletedAt: Value(null),
          ),
        );
  }

  /// Edit slip details and write audit log
  Future<void> editSlip({
    required String slipId,
    String? newCustomerName,
    String? newVehicleNo,
    required List<Map<String, dynamic>> newRounds,
  }) async {
    final oldSlip = await getSlipById(slipId);
    final oldRounds = await getRoundsForSlip(slipId);

    if (oldSlip == null) return;

    final beforeJson = {
      'customerName': oldSlip.customerName,
      'vehicleNo': oldSlip.vehicleNo,
      'rounds': oldRounds.map((r) => {'gross': r.grossKg, 'tare': r.emptyTulaneKg, 'net': r.netKg}).toList(),
    };

    await db.transaction(() async {
      await (db.update(db.slipsTable)..where((t) => t.id.equals(slipId))).write(
            SlipsTableCompanion(
              customerName: Value(newCustomerName),
              vehicleNo: Value(newVehicleNo),
              updatedAt: Value(DateTime.now()),
            ),
          );

      // Delete old rounds and re-insert new
      await (db.delete(db.slipRoundsTable)..where((t) => t.slipId.equals(slipId))).go();

      for (int i = 0; i < newRounds.length; i++) {
        final r = newRounds[i];
        final gross = (r['gross'] as num).toInt();
        final tare = (r['tare'] as num).toInt();
        final net = gross - tare;

        await db.into(db.slipRoundsTable).insert(
              SlipRoundsTableCompanion.insert(
                id: '${slipId}_round_${i + 1}',
                slipId: slipId,
                roundNo: i + 1,
                material: Value(r['material'] as String?),
                grossKg: gross,
                emptyTulaneKg: Value(tare),
                emptyDriverKg: Value((r['driverTare'] as num?)?.toInt()),
                netKg: net,
                extra: Value(r['bagExtra'] as String?),
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
            );
      }

      final afterJson = {
        'customerName': newCustomerName,
        'vehicleNo': newVehicleNo,
        'rounds': newRounds,
      };

      // Write Audit Log entry
      await db.into(db.auditLogTable).insert(
            AuditLogTableCompanion.insert(
              id: 'audit_${DateTime.now().millisecondsSinceEpoch}',
              targetType: 'slip',
              entityId: slipId,
              action: 'edit',
              detailsJson: jsonEncode({'before': beforeJson, 'after': afterJson}),
              createdAt: DateTime.now(),
            ),
          );
    });
  }

  /// Get slip by ID
  Future<SlipsTableData?> getSlipById(String id) async {
    return (db.select(db.slipsTable)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// Get rounds for slip
  Future<List<SlipRoundsTableData>> getRoundsForSlip(String slipId) async {
    return (db.select(db.slipRoundsTable)
          ..where((t) => t.slipId.equals(slipId))
          ..orderBy([(t) => OrderingTerm.asc(t.roundNo)]))
        .get();
  }

  /// Get all existing active slips for duplicate detection
  Future<List<SlipsTableData>> getAllSlips() async {
    return (db.select(db.slipsTable)..where((t) => t.deletedAt.isNull())).get();
  }

  /// Get customer suggestions
  Future<List<String>> getCustomerSuggestions() async {
    final list = await db.select(db.customersTable).get();
    return list.map((c) => c.name).toList();
  }

  /// Get vehicle suggestions
  Future<List<String>> getVehicleSuggestions() async {
    final list = await db.select(db.vehiclesTable).get();
    return list.map((v) => v.number).toList();
  }
}
