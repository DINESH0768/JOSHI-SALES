import 'dart:io';
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

          // Seed Debug Demo Data for Sonu (40 unpaid slips @ ₹50 = ₹2,000 total)
          const sonuCustId = 'udhar_sonu';
          await into(udharCustomersTable).insert(
            UdharCustomersTableCompanion.insert(
              id: sonuCustId,
              name: 'Sonu',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
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
