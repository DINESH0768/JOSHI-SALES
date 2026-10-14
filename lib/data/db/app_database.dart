import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [
  ShopSettingsTable,
  CustomersTable,
  VehiclesTable,
  SlipsTable,
  SlipRoundsTable,
  PaymentsTable,
  UdharCustomersTable,
  UdharAllocationsTable,
  ExpenseCategoriesTable,
  ExpensesTable,
  SuppliersTable,
  SupplierEntriesTable,
  SupplierPaymentsTable,
  CountersTable,
  AuditLogTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          // Seed initial counters and default shop settings
          await into(countersTable).insert(
            CountersTableCompanion.insert(name: 'slip_receipt', currentValue: 1000),
          );
          await into(countersTable).insert(
            CountersTableCompanion.insert(name: 'jama_receipt', currentValue: 1),
          );

          // Seed Debug Demo Data (only in debug mode and non-test environment)
          final isTestMode = kDebugMode && Platform.environment.containsKey('FLUTTER_TEST');
          if (kDebugMode && !isTestMode) {
          const sonuCustId = 'udhar_sonu';
          await into(udharCustomersTable).insert(
            UdharCustomersTableCompanion.insert(
              id: sonuCustId,
              name: 'Sonu',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );

          // Seed Debug Supplier "Bhanwar Lal ji" (Chai wale, ₹10/chai)
          const supplierId = 'supplier_bhanwar_lal';
          await into(suppliersTable).insert(
            SuppliersTableCompanion.insert(
              id: supplierId,
              name: 'Bhanwar Lal ji',
              category: const Value('Chai wale'),
              ratePerUnit: const Value(10),
              unitName: const Value('chai'),
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );

          // Seed entries & payment to leave ₹360 balance (matching Screen 18)
          final date1 = DateTime(2026, 10, 1);
          final date10 = DateTime(2026, 10, 10);
          final dateToday = DateTime.now();

          // 1 Oct: Payment ₹400 via UPI (and linked expense)
          const expId = 'exp_bhanwar_400';
          await into(expensesTable).insert(
            ExpensesTableCompanion.insert(
              id: expId,
              name: 'Chai-pani',
              amount: 400,
              mode: 'upi',
              date: date1,
              note: const Value('Paise diye - Bhanwar Lal ji'),
              createdAt: date1,
              updatedAt: date1,
            ),
          );
          await into(supplierPaymentsTable).insert(
            SupplierPaymentsTableCompanion.insert(
              id: 'sp_bhanwar_1',
              supplierId: supplierId,
              amount: 400,
              mode: 'upi',
              date: date1,
              expenseId: const Value(expId),
              createdAt: date1,
              updatedAt: date1,
            ),
          );

          // Entries: 66 chai @ 10 = 660, 6 chai @ 10 = 60, 4 chai @ 10 = 40 (Total entries = 760, Total payments = 400, Balance = 360)
          await into(supplierEntriesTable).insert(
            SupplierEntriesTableCompanion.insert(
              id: 'se_bhanwar_1',
              supplierId: supplierId,
              date: date1,
              count: const Value(66),
              amount: 660,
              note: const Value('66 chai'),
              createdAt: date1,
              updatedAt: date1,
            ),
          );
          await into(supplierEntriesTable).insert(
            SupplierEntriesTableCompanion.insert(
              id: 'se_bhanwar_2',
              supplierId: supplierId,
              date: date10,
              count: const Value(6),
              amount: 60,
              note: const Value('6 chai'),
              createdAt: date10,
              updatedAt: date10,
            ),
          );
          await into(supplierEntriesTable).insert(
            SupplierEntriesTableCompanion.insert(
              id: 'se_bhanwar_3',
              supplierId: supplierId,
              date: dateToday,
              count: const Value(4),
              amount: 40,
              note: const Value('4 chai'),
              createdAt: dateToday,
              updatedAt: dateToday,
            ),
          );

          final baseDate = DateTime(2026, 10, 1);
          for (int i = 1; i <= 40; i++) {
            final slipId = 'sonu_slip_$i';
            final slipDate = baseDate.add(Duration(days: i ~/ 2));
            await into(slipsTable).insert(
              SlipsTableCompanion.insert(
                id: slipId,
                receiptNo: 2000 + i,
                date: slipDate,
                customerName: const Value('Sonu'),
                vehicleNo: const Value('RJ 31 GA 0000'),
                charge: 50,
                status: 'udhar',
                udharCustomerId: const Value(sonuCustId),
                createdAt: slipDate,
                updatedAt: slipDate,
              ),
            );

            await into(slipRoundsTable).insert(
              SlipRoundsTableCompanion.insert(
                id: '${slipId}_round_1',
                slipId: slipId,
                roundNo: 1,
                material: const Value('गेहूं'),
                grossKg: 20000,
                emptyTulaneKg: const Value(5000),
                netKg: 15000,
                createdAt: slipDate,
                updatedAt: slipDate,
              ),
            );
          }
          }
          await into(shopSettingsTable).insert(
            ShopSettingsTableCompanion.insert(
              id: 'default_shop',
              shopName: 'जोशी कम्प्यूटराइज धर्मकांटा',
              address: 'जयपुर रोड, नई मण्डी के पास, रावतसर (राज.)',
              phones: '9214848519, 7568685291',
              capacityText: 'क्षमता 60 टन',
              recognitionText: 'राजस्थान सरकार द्वारा मान्यता प्राप्त',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'kanta_slip.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
