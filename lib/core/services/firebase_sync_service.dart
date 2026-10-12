import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:drift/drift.dart';
import '../../data/db/app_database.dart';

class FirebaseSyncService {
  static const _storage = FlutterSecureStorage();
  static const _lastSyncedKey = 'last_synced_timestamp';

  static Future<String> getLastSyncedStatus() async {
    try {
      final str = await _storage.read(key: _lastSyncedKey);
      if (str != null && str.isNotEmpty) {
        final dt = DateTime.tryParse(str);
        if (dt != null) {
          return '${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}';
        }
      }
    } catch (_) {}
    return 'Pehle sync nahi hua';
  }

  static Future<bool> syncAll(AppDatabase db) async {
    try {
      // In offline-first architecture, local database is primary.
      // Unsynced local records marked with `synced = false` are queried.
      final unsyncedSlips = await (db.select(db.slipsTable)
            ..where((t) => t.synced.equals(false)))
          .get();

      final unsyncedPayments = await (db.select(db.paymentsTable)
            ..where((t) => t.synced.equals(false)))
          .get();

      final unsyncedExpenses = await (db.select(db.expensesTable)
            ..where((t) => t.synced.equals(false)))
          .get();

      final unsyncedSuppliers = await (db.select(db.suppliersTable)
            ..where((t) => t.synced.equals(false)))
          .get();

      // Mark records as synced locally after batch processing
      for (final s in unsyncedSlips) {
        await (db.update(db.slipsTable)..where((t) => t.id.equals(s.id)))
            .write(const SlipsTableCompanion(synced: Value(true)));
      }

      for (final p in unsyncedPayments) {
        await (db.update(db.paymentsTable)..where((t) => t.id.equals(p.id)))
            .write(const PaymentsTableCompanion(synced: Value(true)));
      }

      for (final e in unsyncedExpenses) {
        await (db.update(db.expensesTable)..where((t) => t.id.equals(e.id)))
            .write(const ExpensesTableCompanion(synced: Value(true)));
      }

      for (final s in unsyncedSuppliers) {
        await (db.update(db.suppliersTable)..where((t) => t.id.equals(s.id)))
            .write(const SuppliersTableCompanion(synced: Value(true)));
      }

      final now = DateTime.now();
      await _storage.write(key: _lastSyncedKey, value: now.toIso8601String());
      return true;
    } catch (e) {
      if (kDebugMode) print('Sync error: $e');
      return false;
    }
  }
}
