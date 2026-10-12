import 'package:drift/drift.dart';

class ShopSettingsTable extends Table {
  TextColumn get id => text()();
  TextColumn get shopName => text()();
  TextColumn get address => text()();
  TextColumn get phones => text()();
  TextColumn get capacityText => text()();
  TextColumn get recognitionText => text()();
  TextColumn get defaultSlipRates => text().nullable()();
  TextColumn get upiId => text().nullable()();
  TextColumn get upiQrImagePath => text().nullable()();
  TextColumn get language => text().withDefault(const Constant('hi'))();
  BoolColumn get lockEnabled => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class CustomersTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class VehiclesTable extends Table {
  TextColumn get id => text()();
  TextColumn get number => text()(); // Uppercase
  TextColumn get lastCustomerId => text().nullable()();
  TextColumn get lastMaterial => text().nullable()();
  IntColumn get lastEmptyWeight => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class SlipsTable extends Table {
  TextColumn get id => text()();
  IntColumn get receiptNo => integer()();
  DateTimeColumn get date => dateTime()();
  TextColumn get customerId => text().nullable()();
  TextColumn get customerName => text().nullable()();
  TextColumn get vehicleNo => text().nullable()();
  IntColumn get charge => integer()();
  TextColumn get status => text()(); // pending, received, udhar
  TextColumn get paymentMode => text().nullable()(); // cash, upi
  DateTimeColumn get receivedAt => dateTime().nullable()();
  TextColumn get udharCustomerId => text().nullable()();
  TextColumn get scanPhotoPath => text().nullable()();
  IntColumn get reprintCount => integer().withDefault(const Constant(0))();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class SlipRoundsTable extends Table {
  TextColumn get id => text()();
  TextColumn get slipId => text()();
  IntColumn get roundNo => integer()();
  TextColumn get material => text().nullable()();
  TextColumn get extra => text().nullable()();
  IntColumn get grossKg => integer()();
  IntColumn get emptyTulaneKg => integer().nullable()();
  IntColumn get emptyDriverKg => integer().nullable()();
  IntColumn get netKg => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class PaymentsTable extends Table {
  TextColumn get id => text()();
  TextColumn get slipId => text().nullable()();
  TextColumn get udharCustomerId => text().nullable()();
  IntColumn get amount => integer()();
  TextColumn get mode => text()(); // cash, upi
  DateTimeColumn get receivedAt => dateTime()();
  TextColumn get kind => text()(); // slip, udhar_jama
  TextColumn get receiptNo => text().nullable()(); // J-0001
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class UdharCustomersTable extends Table {
  TextColumn get id => text()();
  TextColumn get customerId => text().nullable()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class UdharAllocationsTable extends Table {
  TextColumn get id => text()();
  TextColumn get paymentId => text()();
  TextColumn get slipId => text()();
  IntColumn get amountApplied => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class ExpenseCategoriesTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get colorHex => text().nullable()();
  TextColumn get iconName => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class ExpensesTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get amount => integer()();
  TextColumn get mode => text()(); // cash, upi
  DateTimeColumn get date => dateTime()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class SuppliersTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get category => text().nullable()();
  IntColumn get ratePerUnit => integer().nullable()();
  TextColumn get unitName => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class SupplierEntriesTable extends Table {
  TextColumn get id => text()();
  TextColumn get supplierId => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get count => integer().nullable()();
  IntColumn get amount => integer()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class SupplierPaymentsTable extends Table {
  TextColumn get id => text()();
  TextColumn get supplierId => text()();
  IntColumn get amount => integer()();
  TextColumn get mode => text()(); // cash, upi
  DateTimeColumn get date => dateTime()();
  TextColumn get expenseId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class CountersTable extends Table {
  TextColumn get name => text()(); // 'slip_receipt', 'jama_receipt'
  IntColumn get currentValue => integer()();

  @override
  Set<Column> get primaryKey => {name};
}

class AuditLogTable extends Table {
  TextColumn get id => text()();
  TextColumn get entityName => text()();
  TextColumn get entityId => text()();
  TextColumn get action => text()(); // edit, delete
  TextColumn get detailsJson => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
