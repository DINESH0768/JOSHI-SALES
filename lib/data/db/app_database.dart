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
