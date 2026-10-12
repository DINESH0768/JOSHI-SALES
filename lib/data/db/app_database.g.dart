// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ShopSettingsTableTable extends ShopSettingsTable
    with TableInfo<$ShopSettingsTableTable, ShopSettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShopSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shopNameMeta =
      const VerificationMeta('shopName');
  @override
  late final GeneratedColumn<String> shopName = GeneratedColumn<String>(
      'shop_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phonesMeta = const VerificationMeta('phones');
  @override
  late final GeneratedColumn<String> phones = GeneratedColumn<String>(
      'phones', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _capacityTextMeta =
      const VerificationMeta('capacityText');
  @override
  late final GeneratedColumn<String> capacityText = GeneratedColumn<String>(
      'capacity_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recognitionTextMeta =
      const VerificationMeta('recognitionText');
  @override
  late final GeneratedColumn<String> recognitionText = GeneratedColumn<String>(
      'recognition_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _defaultSlipRatesMeta =
      const VerificationMeta('defaultSlipRates');
  @override
  late final GeneratedColumn<String> defaultSlipRates = GeneratedColumn<String>(
      'default_slip_rates', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _upiIdMeta = const VerificationMeta('upiId');
  @override
  late final GeneratedColumn<String> upiId = GeneratedColumn<String>(
      'upi_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _upiQrImagePathMeta =
      const VerificationMeta('upiQrImagePath');
  @override
  late final GeneratedColumn<String> upiQrImagePath = GeneratedColumn<String>(
      'upi_qr_image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
      'language', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('hi'));
  static const VerificationMeta _lockEnabledMeta =
      const VerificationMeta('lockEnabled');
  @override
  late final GeneratedColumn<bool> lockEnabled = GeneratedColumn<bool>(
      'lock_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("lock_enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        shopName,
        address,
        phones,
        capacityText,
        recognitionText,
        defaultSlipRates,
        upiId,
        upiQrImagePath,
        language,
        lockEnabled,
        createdAt,
        updatedAt,
        deletedAt,
        synced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shop_settings_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ShopSettingsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_name')) {
      context.handle(_shopNameMeta,
          shopName.isAcceptableOrUnknown(data['shop_name']!, _shopNameMeta));
    } else if (isInserting) {
      context.missing(_shopNameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('phones')) {
      context.handle(_phonesMeta,
          phones.isAcceptableOrUnknown(data['phones']!, _phonesMeta));
    } else if (isInserting) {
      context.missing(_phonesMeta);
    }
    if (data.containsKey('capacity_text')) {
      context.handle(
          _capacityTextMeta,
          capacityText.isAcceptableOrUnknown(
              data['capacity_text']!, _capacityTextMeta));
    } else if (isInserting) {
      context.missing(_capacityTextMeta);
    }
    if (data.containsKey('recognition_text')) {
      context.handle(
          _recognitionTextMeta,
          recognitionText.isAcceptableOrUnknown(
              data['recognition_text']!, _recognitionTextMeta));
    } else if (isInserting) {
      context.missing(_recognitionTextMeta);
    }
    if (data.containsKey('default_slip_rates')) {
      context.handle(
          _defaultSlipRatesMeta,
          defaultSlipRates.isAcceptableOrUnknown(
              data['default_slip_rates']!, _defaultSlipRatesMeta));
    }
    if (data.containsKey('upi_id')) {
      context.handle(
          _upiIdMeta, upiId.isAcceptableOrUnknown(data['upi_id']!, _upiIdMeta));
    }
    if (data.containsKey('upi_qr_image_path')) {
      context.handle(
          _upiQrImagePathMeta,
          upiQrImagePath.isAcceptableOrUnknown(
              data['upi_qr_image_path']!, _upiQrImagePathMeta));
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    }
    if (data.containsKey('lock_enabled')) {
      context.handle(
          _lockEnabledMeta,
          lockEnabled.isAcceptableOrUnknown(
              data['lock_enabled']!, _lockEnabledMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShopSettingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShopSettingsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      shopName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}shop_name'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address'])!,
      phones: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phones'])!,
      capacityText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}capacity_text'])!,
      recognitionText: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}recognition_text'])!,
      defaultSlipRates: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}default_slip_rates']),
      upiId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}upi_id']),
      upiQrImagePath: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}upi_qr_image_path']),
      language: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language'])!,
      lockEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}lock_enabled'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
    );
  }

  @override
  $ShopSettingsTableTable createAlias(String alias) {
    return $ShopSettingsTableTable(attachedDatabase, alias);
  }
}

class ShopSettingsTableData extends DataClass
    implements Insertable<ShopSettingsTableData> {
  final String id;
  final String shopName;
  final String address;
  final String phones;
  final String capacityText;
  final String recognitionText;
  final String? defaultSlipRates;
  final String? upiId;
  final String? upiQrImagePath;
  final String language;
  final bool lockEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool synced;
  const ShopSettingsTableData(
      {required this.id,
      required this.shopName,
      required this.address,
      required this.phones,
      required this.capacityText,
      required this.recognitionText,
      this.defaultSlipRates,
      this.upiId,
      this.upiQrImagePath,
      required this.language,
      required this.lockEnabled,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.synced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_name'] = Variable<String>(shopName);
    map['address'] = Variable<String>(address);
    map['phones'] = Variable<String>(phones);
    map['capacity_text'] = Variable<String>(capacityText);
    map['recognition_text'] = Variable<String>(recognitionText);
    if (!nullToAbsent || defaultSlipRates != null) {
      map['default_slip_rates'] = Variable<String>(defaultSlipRates);
    }
    if (!nullToAbsent || upiId != null) {
      map['upi_id'] = Variable<String>(upiId);
    }
    if (!nullToAbsent || upiQrImagePath != null) {
      map['upi_qr_image_path'] = Variable<String>(upiQrImagePath);
    }
    map['language'] = Variable<String>(language);
    map['lock_enabled'] = Variable<bool>(lockEnabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  ShopSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return ShopSettingsTableCompanion(
      id: Value(id),
      shopName: Value(shopName),
      address: Value(address),
      phones: Value(phones),
      capacityText: Value(capacityText),
      recognitionText: Value(recognitionText),
      defaultSlipRates: defaultSlipRates == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultSlipRates),
      upiId:
          upiId == null && nullToAbsent ? const Value.absent() : Value(upiId),
      upiQrImagePath: upiQrImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(upiQrImagePath),
      language: Value(language),
      lockEnabled: Value(lockEnabled),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      synced: Value(synced),
    );
  }

  factory ShopSettingsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShopSettingsTableData(
      id: serializer.fromJson<String>(json['id']),
      shopName: serializer.fromJson<String>(json['shopName']),
      address: serializer.fromJson<String>(json['address']),
      phones: serializer.fromJson<String>(json['phones']),
      capacityText: serializer.fromJson<String>(json['capacityText']),
      recognitionText: serializer.fromJson<String>(json['recognitionText']),
      defaultSlipRates: serializer.fromJson<String?>(json['defaultSlipRates']),
      upiId: serializer.fromJson<String?>(json['upiId']),
      upiQrImagePath: serializer.fromJson<String?>(json['upiQrImagePath']),
      language: serializer.fromJson<String>(json['language']),
      lockEnabled: serializer.fromJson<bool>(json['lockEnabled']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopName': serializer.toJson<String>(shopName),
      'address': serializer.toJson<String>(address),
      'phones': serializer.toJson<String>(phones),
      'capacityText': serializer.toJson<String>(capacityText),
      'recognitionText': serializer.toJson<String>(recognitionText),
      'defaultSlipRates': serializer.toJson<String?>(defaultSlipRates),
      'upiId': serializer.toJson<String?>(upiId),
      'upiQrImagePath': serializer.toJson<String?>(upiQrImagePath),
      'language': serializer.toJson<String>(language),
      'lockEnabled': serializer.toJson<bool>(lockEnabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  ShopSettingsTableData copyWith(
          {String? id,
          String? shopName,
          String? address,
          String? phones,
          String? capacityText,
          String? recognitionText,
          Value<String?> defaultSlipRates = const Value.absent(),
          Value<String?> upiId = const Value.absent(),
          Value<String?> upiQrImagePath = const Value.absent(),
          String? language,
          bool? lockEnabled,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          bool? synced}) =>
      ShopSettingsTableData(
        id: id ?? this.id,
        shopName: shopName ?? this.shopName,
        address: address ?? this.address,
        phones: phones ?? this.phones,
        capacityText: capacityText ?? this.capacityText,
        recognitionText: recognitionText ?? this.recognitionText,
        defaultSlipRates: defaultSlipRates.present
            ? defaultSlipRates.value
            : this.defaultSlipRates,
        upiId: upiId.present ? upiId.value : this.upiId,
        upiQrImagePath:
            upiQrImagePath.present ? upiQrImagePath.value : this.upiQrImagePath,
        language: language ?? this.language,
        lockEnabled: lockEnabled ?? this.lockEnabled,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        synced: synced ?? this.synced,
      );
  ShopSettingsTableData copyWithCompanion(ShopSettingsTableCompanion data) {
    return ShopSettingsTableData(
      id: data.id.present ? data.id.value : this.id,
      shopName: data.shopName.present ? data.shopName.value : this.shopName,
      address: data.address.present ? data.address.value : this.address,
      phones: data.phones.present ? data.phones.value : this.phones,
      capacityText: data.capacityText.present
          ? data.capacityText.value
          : this.capacityText,
      recognitionText: data.recognitionText.present
          ? data.recognitionText.value
          : this.recognitionText,
      defaultSlipRates: data.defaultSlipRates.present
          ? data.defaultSlipRates.value
          : this.defaultSlipRates,
      upiId: data.upiId.present ? data.upiId.value : this.upiId,
      upiQrImagePath: data.upiQrImagePath.present
          ? data.upiQrImagePath.value
          : this.upiQrImagePath,
      language: data.language.present ? data.language.value : this.language,
      lockEnabled:
          data.lockEnabled.present ? data.lockEnabled.value : this.lockEnabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShopSettingsTableData(')
          ..write('id: $id, ')
          ..write('shopName: $shopName, ')
          ..write('address: $address, ')
          ..write('phones: $phones, ')
          ..write('capacityText: $capacityText, ')
          ..write('recognitionText: $recognitionText, ')
          ..write('defaultSlipRates: $defaultSlipRates, ')
          ..write('upiId: $upiId, ')
          ..write('upiQrImagePath: $upiQrImagePath, ')
          ..write('language: $language, ')
          ..write('lockEnabled: $lockEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      shopName,
      address,
      phones,
      capacityText,
      recognitionText,
      defaultSlipRates,
      upiId,
      upiQrImagePath,
      language,
      lockEnabled,
      createdAt,
      updatedAt,
      deletedAt,
      synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShopSettingsTableData &&
          other.id == this.id &&
          other.shopName == this.shopName &&
          other.address == this.address &&
          other.phones == this.phones &&
          other.capacityText == this.capacityText &&
          other.recognitionText == this.recognitionText &&
          other.defaultSlipRates == this.defaultSlipRates &&
          other.upiId == this.upiId &&
          other.upiQrImagePath == this.upiQrImagePath &&
          other.language == this.language &&
          other.lockEnabled == this.lockEnabled &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.synced == this.synced);
}

class ShopSettingsTableCompanion
    extends UpdateCompanion<ShopSettingsTableData> {
  final Value<String> id;
  final Value<String> shopName;
  final Value<String> address;
  final Value<String> phones;
  final Value<String> capacityText;
  final Value<String> recognitionText;
  final Value<String?> defaultSlipRates;
  final Value<String?> upiId;
  final Value<String?> upiQrImagePath;
  final Value<String> language;
  final Value<bool> lockEnabled;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> synced;
  final Value<int> rowid;
  const ShopSettingsTableCompanion({
    this.id = const Value.absent(),
    this.shopName = const Value.absent(),
    this.address = const Value.absent(),
    this.phones = const Value.absent(),
    this.capacityText = const Value.absent(),
    this.recognitionText = const Value.absent(),
    this.defaultSlipRates = const Value.absent(),
    this.upiId = const Value.absent(),
    this.upiQrImagePath = const Value.absent(),
    this.language = const Value.absent(),
    this.lockEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShopSettingsTableCompanion.insert({
    required String id,
    required String shopName,
    required String address,
    required String phones,
    required String capacityText,
    required String recognitionText,
    this.defaultSlipRates = const Value.absent(),
    this.upiId = const Value.absent(),
    this.upiQrImagePath = const Value.absent(),
    this.language = const Value.absent(),
    this.lockEnabled = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        shopName = Value(shopName),
        address = Value(address),
        phones = Value(phones),
        capacityText = Value(capacityText),
        recognitionText = Value(recognitionText),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<ShopSettingsTableData> custom({
    Expression<String>? id,
    Expression<String>? shopName,
    Expression<String>? address,
    Expression<String>? phones,
    Expression<String>? capacityText,
    Expression<String>? recognitionText,
    Expression<String>? defaultSlipRates,
    Expression<String>? upiId,
    Expression<String>? upiQrImagePath,
    Expression<String>? language,
    Expression<bool>? lockEnabled,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopName != null) 'shop_name': shopName,
      if (address != null) 'address': address,
      if (phones != null) 'phones': phones,
      if (capacityText != null) 'capacity_text': capacityText,
      if (recognitionText != null) 'recognition_text': recognitionText,
      if (defaultSlipRates != null) 'default_slip_rates': defaultSlipRates,
      if (upiId != null) 'upi_id': upiId,
      if (upiQrImagePath != null) 'upi_qr_image_path': upiQrImagePath,
      if (language != null) 'language': language,
      if (lockEnabled != null) 'lock_enabled': lockEnabled,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShopSettingsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? shopName,
      Value<String>? address,
      Value<String>? phones,
      Value<String>? capacityText,
      Value<String>? recognitionText,
      Value<String?>? defaultSlipRates,
      Value<String?>? upiId,
      Value<String?>? upiQrImagePath,
      Value<String>? language,
      Value<bool>? lockEnabled,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<bool>? synced,
      Value<int>? rowid}) {
    return ShopSettingsTableCompanion(
      id: id ?? this.id,
      shopName: shopName ?? this.shopName,
      address: address ?? this.address,
      phones: phones ?? this.phones,
      capacityText: capacityText ?? this.capacityText,
      recognitionText: recognitionText ?? this.recognitionText,
      defaultSlipRates: defaultSlipRates ?? this.defaultSlipRates,
      upiId: upiId ?? this.upiId,
      upiQrImagePath: upiQrImagePath ?? this.upiQrImagePath,
      language: language ?? this.language,
      lockEnabled: lockEnabled ?? this.lockEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopName.present) {
      map['shop_name'] = Variable<String>(shopName.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (phones.present) {
      map['phones'] = Variable<String>(phones.value);
    }
    if (capacityText.present) {
      map['capacity_text'] = Variable<String>(capacityText.value);
    }
    if (recognitionText.present) {
      map['recognition_text'] = Variable<String>(recognitionText.value);
    }
    if (defaultSlipRates.present) {
      map['default_slip_rates'] = Variable<String>(defaultSlipRates.value);
    }
    if (upiId.present) {
      map['upi_id'] = Variable<String>(upiId.value);
    }
    if (upiQrImagePath.present) {
      map['upi_qr_image_path'] = Variable<String>(upiQrImagePath.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (lockEnabled.present) {
      map['lock_enabled'] = Variable<bool>(lockEnabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShopSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('shopName: $shopName, ')
          ..write('address: $address, ')
          ..write('phones: $phones, ')
          ..write('capacityText: $capacityText, ')
          ..write('recognitionText: $recognitionText, ')
          ..write('defaultSlipRates: $defaultSlipRates, ')
          ..write('upiId: $upiId, ')
          ..write('upiQrImagePath: $upiQrImagePath, ')
          ..write('language: $language, ')
          ..write('lockEnabled: $lockEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomersTableTable extends CustomersTable
    with TableInfo<$CustomersTableTable, CustomersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, phone, notes, createdAt, updatedAt, deletedAt, synced];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers_table';
  @override
  VerificationContext validateIntegrity(Insertable<CustomersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomersTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
    );
  }

  @override
  $CustomersTableTable createAlias(String alias) {
    return $CustomersTableTable(attachedDatabase, alias);
  }
}

class CustomersTableData extends DataClass
    implements Insertable<CustomersTableData> {
  final String id;
  final String name;
  final String? phone;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool synced;
  const CustomersTableData(
      {required this.id,
      required this.name,
      this.phone,
      this.notes,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.synced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  CustomersTableCompanion toCompanion(bool nullToAbsent) {
    return CustomersTableCompanion(
      id: Value(id),
      name: Value(name),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      synced: Value(synced),
    );
  }

  factory CustomersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomersTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  CustomersTableData copyWith(
          {String? id,
          String? name,
          Value<String?> phone = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          bool? synced}) =>
      CustomersTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone.present ? phone.value : this.phone,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        synced: synced ?? this.synced,
      );
  CustomersTableData copyWithCompanion(CustomersTableCompanion data) {
    return CustomersTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomersTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, phone, notes, createdAt, updatedAt, deletedAt, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomersTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.synced == this.synced);
}

class CustomersTableCompanion extends UpdateCompanion<CustomersTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> synced;
  final Value<int> rowid;
  const CustomersTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomersTableCompanion.insert({
    required String id,
    required String name,
    this.phone = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<CustomersTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomersTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? phone,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<bool>? synced,
      Value<int>? rowid}) {
    return CustomersTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VehiclesTableTable extends VehiclesTable
    with TableInfo<$VehiclesTableTable, VehiclesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiclesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
      'number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastCustomerIdMeta =
      const VerificationMeta('lastCustomerId');
  @override
  late final GeneratedColumn<String> lastCustomerId = GeneratedColumn<String>(
      'last_customer_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastMaterialMeta =
      const VerificationMeta('lastMaterial');
  @override
  late final GeneratedColumn<String> lastMaterial = GeneratedColumn<String>(
      'last_material', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastEmptyWeightMeta =
      const VerificationMeta('lastEmptyWeight');
  @override
  late final GeneratedColumn<int> lastEmptyWeight = GeneratedColumn<int>(
      'last_empty_weight', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        number,
        lastCustomerId,
        lastMaterial,
        lastEmptyWeight,
        createdAt,
        updatedAt,
        deletedAt,
        synced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicles_table';
  @override
  VerificationContext validateIntegrity(Insertable<VehiclesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('last_customer_id')) {
      context.handle(
          _lastCustomerIdMeta,
          lastCustomerId.isAcceptableOrUnknown(
              data['last_customer_id']!, _lastCustomerIdMeta));
    }
    if (data.containsKey('last_material')) {
      context.handle(
          _lastMaterialMeta,
          lastMaterial.isAcceptableOrUnknown(
              data['last_material']!, _lastMaterialMeta));
    }
    if (data.containsKey('last_empty_weight')) {
      context.handle(
          _lastEmptyWeightMeta,
          lastEmptyWeight.isAcceptableOrUnknown(
              data['last_empty_weight']!, _lastEmptyWeightMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VehiclesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VehiclesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}number'])!,
      lastCustomerId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_customer_id']),
      lastMaterial: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_material']),
      lastEmptyWeight: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_empty_weight']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
    );
  }

  @override
  $VehiclesTableTable createAlias(String alias) {
    return $VehiclesTableTable(attachedDatabase, alias);
  }
}

class VehiclesTableData extends DataClass
    implements Insertable<VehiclesTableData> {
  final String id;
  final String number;
  final String? lastCustomerId;
  final String? lastMaterial;
  final int? lastEmptyWeight;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool synced;
  const VehiclesTableData(
      {required this.id,
      required this.number,
      this.lastCustomerId,
      this.lastMaterial,
      this.lastEmptyWeight,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.synced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['number'] = Variable<String>(number);
    if (!nullToAbsent || lastCustomerId != null) {
      map['last_customer_id'] = Variable<String>(lastCustomerId);
    }
    if (!nullToAbsent || lastMaterial != null) {
      map['last_material'] = Variable<String>(lastMaterial);
    }
    if (!nullToAbsent || lastEmptyWeight != null) {
      map['last_empty_weight'] = Variable<int>(lastEmptyWeight);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  VehiclesTableCompanion toCompanion(bool nullToAbsent) {
    return VehiclesTableCompanion(
      id: Value(id),
      number: Value(number),
      lastCustomerId: lastCustomerId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCustomerId),
      lastMaterial: lastMaterial == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMaterial),
      lastEmptyWeight: lastEmptyWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(lastEmptyWeight),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      synced: Value(synced),
    );
  }

  factory VehiclesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VehiclesTableData(
      id: serializer.fromJson<String>(json['id']),
      number: serializer.fromJson<String>(json['number']),
      lastCustomerId: serializer.fromJson<String?>(json['lastCustomerId']),
      lastMaterial: serializer.fromJson<String?>(json['lastMaterial']),
      lastEmptyWeight: serializer.fromJson<int?>(json['lastEmptyWeight']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'number': serializer.toJson<String>(number),
      'lastCustomerId': serializer.toJson<String?>(lastCustomerId),
      'lastMaterial': serializer.toJson<String?>(lastMaterial),
      'lastEmptyWeight': serializer.toJson<int?>(lastEmptyWeight),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  VehiclesTableData copyWith(
          {String? id,
          String? number,
          Value<String?> lastCustomerId = const Value.absent(),
          Value<String?> lastMaterial = const Value.absent(),
          Value<int?> lastEmptyWeight = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          bool? synced}) =>
      VehiclesTableData(
        id: id ?? this.id,
        number: number ?? this.number,
        lastCustomerId:
            lastCustomerId.present ? lastCustomerId.value : this.lastCustomerId,
        lastMaterial:
            lastMaterial.present ? lastMaterial.value : this.lastMaterial,
        lastEmptyWeight: lastEmptyWeight.present
            ? lastEmptyWeight.value
            : this.lastEmptyWeight,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        synced: synced ?? this.synced,
      );
  VehiclesTableData copyWithCompanion(VehiclesTableCompanion data) {
    return VehiclesTableData(
      id: data.id.present ? data.id.value : this.id,
      number: data.number.present ? data.number.value : this.number,
      lastCustomerId: data.lastCustomerId.present
          ? data.lastCustomerId.value
          : this.lastCustomerId,
      lastMaterial: data.lastMaterial.present
          ? data.lastMaterial.value
          : this.lastMaterial,
      lastEmptyWeight: data.lastEmptyWeight.present
          ? data.lastEmptyWeight.value
          : this.lastEmptyWeight,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesTableData(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('lastCustomerId: $lastCustomerId, ')
          ..write('lastMaterial: $lastMaterial, ')
          ..write('lastEmptyWeight: $lastEmptyWeight, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, number, lastCustomerId, lastMaterial,
      lastEmptyWeight, createdAt, updatedAt, deletedAt, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehiclesTableData &&
          other.id == this.id &&
          other.number == this.number &&
          other.lastCustomerId == this.lastCustomerId &&
          other.lastMaterial == this.lastMaterial &&
          other.lastEmptyWeight == this.lastEmptyWeight &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.synced == this.synced);
}

class VehiclesTableCompanion extends UpdateCompanion<VehiclesTableData> {
  final Value<String> id;
  final Value<String> number;
  final Value<String?> lastCustomerId;
  final Value<String?> lastMaterial;
  final Value<int?> lastEmptyWeight;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> synced;
  final Value<int> rowid;
  const VehiclesTableCompanion({
    this.id = const Value.absent(),
    this.number = const Value.absent(),
    this.lastCustomerId = const Value.absent(),
    this.lastMaterial = const Value.absent(),
    this.lastEmptyWeight = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VehiclesTableCompanion.insert({
    required String id,
    required String number,
    this.lastCustomerId = const Value.absent(),
    this.lastMaterial = const Value.absent(),
    this.lastEmptyWeight = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        number = Value(number),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<VehiclesTableData> custom({
    Expression<String>? id,
    Expression<String>? number,
    Expression<String>? lastCustomerId,
    Expression<String>? lastMaterial,
    Expression<int>? lastEmptyWeight,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (number != null) 'number': number,
      if (lastCustomerId != null) 'last_customer_id': lastCustomerId,
      if (lastMaterial != null) 'last_material': lastMaterial,
      if (lastEmptyWeight != null) 'last_empty_weight': lastEmptyWeight,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VehiclesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? number,
      Value<String?>? lastCustomerId,
      Value<String?>? lastMaterial,
      Value<int?>? lastEmptyWeight,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<bool>? synced,
      Value<int>? rowid}) {
    return VehiclesTableCompanion(
      id: id ?? this.id,
      number: number ?? this.number,
      lastCustomerId: lastCustomerId ?? this.lastCustomerId,
      lastMaterial: lastMaterial ?? this.lastMaterial,
      lastEmptyWeight: lastEmptyWeight ?? this.lastEmptyWeight,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (lastCustomerId.present) {
      map['last_customer_id'] = Variable<String>(lastCustomerId.value);
    }
    if (lastMaterial.present) {
      map['last_material'] = Variable<String>(lastMaterial.value);
    }
    if (lastEmptyWeight.present) {
      map['last_empty_weight'] = Variable<int>(lastEmptyWeight.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesTableCompanion(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('lastCustomerId: $lastCustomerId, ')
          ..write('lastMaterial: $lastMaterial, ')
          ..write('lastEmptyWeight: $lastEmptyWeight, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SlipsTableTable extends SlipsTable
    with TableInfo<$SlipsTableTable, SlipsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SlipsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _receiptNoMeta =
      const VerificationMeta('receiptNo');
  @override
  late final GeneratedColumn<int> receiptNo = GeneratedColumn<int>(
      'receipt_no', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
      'customer_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _customerNameMeta =
      const VerificationMeta('customerName');
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
      'customer_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _vehicleNoMeta =
      const VerificationMeta('vehicleNo');
  @override
  late final GeneratedColumn<String> vehicleNo = GeneratedColumn<String>(
      'vehicle_no', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _chargeMeta = const VerificationMeta('charge');
  @override
  late final GeneratedColumn<int> charge = GeneratedColumn<int>(
      'charge', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _paymentModeMeta =
      const VerificationMeta('paymentMode');
  @override
  late final GeneratedColumn<String> paymentMode = GeneratedColumn<String>(
      'payment_mode', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _receivedAtMeta =
      const VerificationMeta('receivedAt');
  @override
  late final GeneratedColumn<DateTime> receivedAt = GeneratedColumn<DateTime>(
      'received_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _udharCustomerIdMeta =
      const VerificationMeta('udharCustomerId');
  @override
  late final GeneratedColumn<String> udharCustomerId = GeneratedColumn<String>(
      'udhar_customer_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _scanPhotoPathMeta =
      const VerificationMeta('scanPhotoPath');
  @override
  late final GeneratedColumn<String> scanPhotoPath = GeneratedColumn<String>(
      'scan_photo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _reprintCountMeta =
      const VerificationMeta('reprintCount');
  @override
  late final GeneratedColumn<int> reprintCount = GeneratedColumn<int>(
      'reprint_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        receiptNo,
        date,
        customerId,
        customerName,
        vehicleNo,
        charge,
        status,
        paymentMode,
        receivedAt,
        udharCustomerId,
        scanPhotoPath,
        reprintCount,
        note,
        createdAt,
        updatedAt,
        deletedAt,
        synced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'slips_table';
  @override
  VerificationContext validateIntegrity(Insertable<SlipsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('receipt_no')) {
      context.handle(_receiptNoMeta,
          receiptNo.isAcceptableOrUnknown(data['receipt_no']!, _receiptNoMeta));
    } else if (isInserting) {
      context.missing(_receiptNoMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    }
    if (data.containsKey('customer_name')) {
      context.handle(
          _customerNameMeta,
          customerName.isAcceptableOrUnknown(
              data['customer_name']!, _customerNameMeta));
    }
    if (data.containsKey('vehicle_no')) {
      context.handle(_vehicleNoMeta,
          vehicleNo.isAcceptableOrUnknown(data['vehicle_no']!, _vehicleNoMeta));
    }
    if (data.containsKey('charge')) {
      context.handle(_chargeMeta,
          charge.isAcceptableOrUnknown(data['charge']!, _chargeMeta));
    } else if (isInserting) {
      context.missing(_chargeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('payment_mode')) {
      context.handle(
          _paymentModeMeta,
          paymentMode.isAcceptableOrUnknown(
              data['payment_mode']!, _paymentModeMeta));
    }
    if (data.containsKey('received_at')) {
      context.handle(
          _receivedAtMeta,
          receivedAt.isAcceptableOrUnknown(
              data['received_at']!, _receivedAtMeta));
    }
    if (data.containsKey('udhar_customer_id')) {
      context.handle(
          _udharCustomerIdMeta,
          udharCustomerId.isAcceptableOrUnknown(
              data['udhar_customer_id']!, _udharCustomerIdMeta));
    }
    if (data.containsKey('scan_photo_path')) {
      context.handle(
          _scanPhotoPathMeta,
          scanPhotoPath.isAcceptableOrUnknown(
              data['scan_photo_path']!, _scanPhotoPathMeta));
    }
    if (data.containsKey('reprint_count')) {
      context.handle(
          _reprintCountMeta,
          reprintCount.isAcceptableOrUnknown(
              data['reprint_count']!, _reprintCountMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SlipsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SlipsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      receiptNo: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}receipt_no'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_id']),
      customerName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_name']),
      vehicleNo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vehicle_no']),
      charge: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}charge'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      paymentMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_mode']),
      receivedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}received_at']),
      udharCustomerId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}udhar_customer_id']),
      scanPhotoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}scan_photo_path']),
      reprintCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reprint_count'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
    );
  }

  @override
  $SlipsTableTable createAlias(String alias) {
    return $SlipsTableTable(attachedDatabase, alias);
  }
}

class SlipsTableData extends DataClass implements Insertable<SlipsTableData> {
  final String id;
  final int receiptNo;
  final DateTime date;
  final String? customerId;
  final String? customerName;
  final String? vehicleNo;
  final int charge;
  final String status;
  final String? paymentMode;
  final DateTime? receivedAt;
  final String? udharCustomerId;
  final String? scanPhotoPath;
  final int reprintCount;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool synced;
  const SlipsTableData(
      {required this.id,
      required this.receiptNo,
      required this.date,
      this.customerId,
      this.customerName,
      this.vehicleNo,
      required this.charge,
      required this.status,
      this.paymentMode,
      this.receivedAt,
      this.udharCustomerId,
      this.scanPhotoPath,
      required this.reprintCount,
      this.note,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.synced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['receipt_no'] = Variable<int>(receiptNo);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<String>(customerId);
    }
    if (!nullToAbsent || customerName != null) {
      map['customer_name'] = Variable<String>(customerName);
    }
    if (!nullToAbsent || vehicleNo != null) {
      map['vehicle_no'] = Variable<String>(vehicleNo);
    }
    map['charge'] = Variable<int>(charge);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || paymentMode != null) {
      map['payment_mode'] = Variable<String>(paymentMode);
    }
    if (!nullToAbsent || receivedAt != null) {
      map['received_at'] = Variable<DateTime>(receivedAt);
    }
    if (!nullToAbsent || udharCustomerId != null) {
      map['udhar_customer_id'] = Variable<String>(udharCustomerId);
    }
    if (!nullToAbsent || scanPhotoPath != null) {
      map['scan_photo_path'] = Variable<String>(scanPhotoPath);
    }
    map['reprint_count'] = Variable<int>(reprintCount);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  SlipsTableCompanion toCompanion(bool nullToAbsent) {
    return SlipsTableCompanion(
      id: Value(id),
      receiptNo: Value(receiptNo),
      date: Value(date),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      customerName: customerName == null && nullToAbsent
          ? const Value.absent()
          : Value(customerName),
      vehicleNo: vehicleNo == null && nullToAbsent
          ? const Value.absent()
          : Value(vehicleNo),
      charge: Value(charge),
      status: Value(status),
      paymentMode: paymentMode == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMode),
      receivedAt: receivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(receivedAt),
      udharCustomerId: udharCustomerId == null && nullToAbsent
          ? const Value.absent()
          : Value(udharCustomerId),
      scanPhotoPath: scanPhotoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(scanPhotoPath),
      reprintCount: Value(reprintCount),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      synced: Value(synced),
    );
  }

  factory SlipsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SlipsTableData(
      id: serializer.fromJson<String>(json['id']),
      receiptNo: serializer.fromJson<int>(json['receiptNo']),
      date: serializer.fromJson<DateTime>(json['date']),
      customerId: serializer.fromJson<String?>(json['customerId']),
      customerName: serializer.fromJson<String?>(json['customerName']),
      vehicleNo: serializer.fromJson<String?>(json['vehicleNo']),
      charge: serializer.fromJson<int>(json['charge']),
      status: serializer.fromJson<String>(json['status']),
      paymentMode: serializer.fromJson<String?>(json['paymentMode']),
      receivedAt: serializer.fromJson<DateTime?>(json['receivedAt']),
      udharCustomerId: serializer.fromJson<String?>(json['udharCustomerId']),
      scanPhotoPath: serializer.fromJson<String?>(json['scanPhotoPath']),
      reprintCount: serializer.fromJson<int>(json['reprintCount']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'receiptNo': serializer.toJson<int>(receiptNo),
      'date': serializer.toJson<DateTime>(date),
      'customerId': serializer.toJson<String?>(customerId),
      'customerName': serializer.toJson<String?>(customerName),
      'vehicleNo': serializer.toJson<String?>(vehicleNo),
      'charge': serializer.toJson<int>(charge),
      'status': serializer.toJson<String>(status),
      'paymentMode': serializer.toJson<String?>(paymentMode),
      'receivedAt': serializer.toJson<DateTime?>(receivedAt),
      'udharCustomerId': serializer.toJson<String?>(udharCustomerId),
      'scanPhotoPath': serializer.toJson<String?>(scanPhotoPath),
      'reprintCount': serializer.toJson<int>(reprintCount),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  SlipsTableData copyWith(
          {String? id,
          int? receiptNo,
          DateTime? date,
          Value<String?> customerId = const Value.absent(),
          Value<String?> customerName = const Value.absent(),
          Value<String?> vehicleNo = const Value.absent(),
          int? charge,
          String? status,
          Value<String?> paymentMode = const Value.absent(),
          Value<DateTime?> receivedAt = const Value.absent(),
          Value<String?> udharCustomerId = const Value.absent(),
          Value<String?> scanPhotoPath = const Value.absent(),
          int? reprintCount,
          Value<String?> note = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          bool? synced}) =>
      SlipsTableData(
        id: id ?? this.id,
        receiptNo: receiptNo ?? this.receiptNo,
        date: date ?? this.date,
        customerId: customerId.present ? customerId.value : this.customerId,
        customerName:
            customerName.present ? customerName.value : this.customerName,
        vehicleNo: vehicleNo.present ? vehicleNo.value : this.vehicleNo,
        charge: charge ?? this.charge,
        status: status ?? this.status,
        paymentMode: paymentMode.present ? paymentMode.value : this.paymentMode,
        receivedAt: receivedAt.present ? receivedAt.value : this.receivedAt,
        udharCustomerId: udharCustomerId.present
            ? udharCustomerId.value
            : this.udharCustomerId,
        scanPhotoPath:
            scanPhotoPath.present ? scanPhotoPath.value : this.scanPhotoPath,
        reprintCount: reprintCount ?? this.reprintCount,
        note: note.present ? note.value : this.note,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        synced: synced ?? this.synced,
      );
  SlipsTableData copyWithCompanion(SlipsTableCompanion data) {
    return SlipsTableData(
      id: data.id.present ? data.id.value : this.id,
      receiptNo: data.receiptNo.present ? data.receiptNo.value : this.receiptNo,
      date: data.date.present ? data.date.value : this.date,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      vehicleNo: data.vehicleNo.present ? data.vehicleNo.value : this.vehicleNo,
      charge: data.charge.present ? data.charge.value : this.charge,
      status: data.status.present ? data.status.value : this.status,
      paymentMode:
          data.paymentMode.present ? data.paymentMode.value : this.paymentMode,
      receivedAt:
          data.receivedAt.present ? data.receivedAt.value : this.receivedAt,
      udharCustomerId: data.udharCustomerId.present
          ? data.udharCustomerId.value
          : this.udharCustomerId,
      scanPhotoPath: data.scanPhotoPath.present
          ? data.scanPhotoPath.value
          : this.scanPhotoPath,
      reprintCount: data.reprintCount.present
          ? data.reprintCount.value
          : this.reprintCount,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SlipsTableData(')
          ..write('id: $id, ')
          ..write('receiptNo: $receiptNo, ')
          ..write('date: $date, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('vehicleNo: $vehicleNo, ')
          ..write('charge: $charge, ')
          ..write('status: $status, ')
          ..write('paymentMode: $paymentMode, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('udharCustomerId: $udharCustomerId, ')
          ..write('scanPhotoPath: $scanPhotoPath, ')
          ..write('reprintCount: $reprintCount, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      receiptNo,
      date,
      customerId,
      customerName,
      vehicleNo,
      charge,
      status,
      paymentMode,
      receivedAt,
      udharCustomerId,
      scanPhotoPath,
      reprintCount,
      note,
      createdAt,
      updatedAt,
      deletedAt,
      synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SlipsTableData &&
          other.id == this.id &&
          other.receiptNo == this.receiptNo &&
          other.date == this.date &&
          other.customerId == this.customerId &&
          other.customerName == this.customerName &&
          other.vehicleNo == this.vehicleNo &&
          other.charge == this.charge &&
          other.status == this.status &&
          other.paymentMode == this.paymentMode &&
          other.receivedAt == this.receivedAt &&
          other.udharCustomerId == this.udharCustomerId &&
          other.scanPhotoPath == this.scanPhotoPath &&
          other.reprintCount == this.reprintCount &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.synced == this.synced);
}

class SlipsTableCompanion extends UpdateCompanion<SlipsTableData> {
  final Value<String> id;
  final Value<int> receiptNo;
  final Value<DateTime> date;
  final Value<String?> customerId;
  final Value<String?> customerName;
  final Value<String?> vehicleNo;
  final Value<int> charge;
  final Value<String> status;
  final Value<String?> paymentMode;
  final Value<DateTime?> receivedAt;
  final Value<String?> udharCustomerId;
  final Value<String?> scanPhotoPath;
  final Value<int> reprintCount;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> synced;
  final Value<int> rowid;
  const SlipsTableCompanion({
    this.id = const Value.absent(),
    this.receiptNo = const Value.absent(),
    this.date = const Value.absent(),
    this.customerId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.vehicleNo = const Value.absent(),
    this.charge = const Value.absent(),
    this.status = const Value.absent(),
    this.paymentMode = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.udharCustomerId = const Value.absent(),
    this.scanPhotoPath = const Value.absent(),
    this.reprintCount = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SlipsTableCompanion.insert({
    required String id,
    required int receiptNo,
    required DateTime date,
    this.customerId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.vehicleNo = const Value.absent(),
    required int charge,
    required String status,
    this.paymentMode = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.udharCustomerId = const Value.absent(),
    this.scanPhotoPath = const Value.absent(),
    this.reprintCount = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        receiptNo = Value(receiptNo),
        date = Value(date),
        charge = Value(charge),
        status = Value(status),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<SlipsTableData> custom({
    Expression<String>? id,
    Expression<int>? receiptNo,
    Expression<DateTime>? date,
    Expression<String>? customerId,
    Expression<String>? customerName,
    Expression<String>? vehicleNo,
    Expression<int>? charge,
    Expression<String>? status,
    Expression<String>? paymentMode,
    Expression<DateTime>? receivedAt,
    Expression<String>? udharCustomerId,
    Expression<String>? scanPhotoPath,
    Expression<int>? reprintCount,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (receiptNo != null) 'receipt_no': receiptNo,
      if (date != null) 'date': date,
      if (customerId != null) 'customer_id': customerId,
      if (customerName != null) 'customer_name': customerName,
      if (vehicleNo != null) 'vehicle_no': vehicleNo,
      if (charge != null) 'charge': charge,
      if (status != null) 'status': status,
      if (paymentMode != null) 'payment_mode': paymentMode,
      if (receivedAt != null) 'received_at': receivedAt,
      if (udharCustomerId != null) 'udhar_customer_id': udharCustomerId,
      if (scanPhotoPath != null) 'scan_photo_path': scanPhotoPath,
      if (reprintCount != null) 'reprint_count': reprintCount,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SlipsTableCompanion copyWith(
      {Value<String>? id,
      Value<int>? receiptNo,
      Value<DateTime>? date,
      Value<String?>? customerId,
      Value<String?>? customerName,
      Value<String?>? vehicleNo,
      Value<int>? charge,
      Value<String>? status,
      Value<String?>? paymentMode,
      Value<DateTime?>? receivedAt,
      Value<String?>? udharCustomerId,
      Value<String?>? scanPhotoPath,
      Value<int>? reprintCount,
      Value<String?>? note,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<bool>? synced,
      Value<int>? rowid}) {
    return SlipsTableCompanion(
      id: id ?? this.id,
      receiptNo: receiptNo ?? this.receiptNo,
      date: date ?? this.date,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      vehicleNo: vehicleNo ?? this.vehicleNo,
      charge: charge ?? this.charge,
      status: status ?? this.status,
      paymentMode: paymentMode ?? this.paymentMode,
      receivedAt: receivedAt ?? this.receivedAt,
      udharCustomerId: udharCustomerId ?? this.udharCustomerId,
      scanPhotoPath: scanPhotoPath ?? this.scanPhotoPath,
      reprintCount: reprintCount ?? this.reprintCount,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (receiptNo.present) {
      map['receipt_no'] = Variable<int>(receiptNo.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (vehicleNo.present) {
      map['vehicle_no'] = Variable<String>(vehicleNo.value);
    }
    if (charge.present) {
      map['charge'] = Variable<int>(charge.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (paymentMode.present) {
      map['payment_mode'] = Variable<String>(paymentMode.value);
    }
    if (receivedAt.present) {
      map['received_at'] = Variable<DateTime>(receivedAt.value);
    }
    if (udharCustomerId.present) {
      map['udhar_customer_id'] = Variable<String>(udharCustomerId.value);
    }
    if (scanPhotoPath.present) {
      map['scan_photo_path'] = Variable<String>(scanPhotoPath.value);
    }
    if (reprintCount.present) {
      map['reprint_count'] = Variable<int>(reprintCount.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SlipsTableCompanion(')
          ..write('id: $id, ')
          ..write('receiptNo: $receiptNo, ')
          ..write('date: $date, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('vehicleNo: $vehicleNo, ')
          ..write('charge: $charge, ')
          ..write('status: $status, ')
          ..write('paymentMode: $paymentMode, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('udharCustomerId: $udharCustomerId, ')
          ..write('scanPhotoPath: $scanPhotoPath, ')
          ..write('reprintCount: $reprintCount, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SlipRoundsTableTable extends SlipRoundsTable
    with TableInfo<$SlipRoundsTableTable, SlipRoundsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SlipRoundsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _slipIdMeta = const VerificationMeta('slipId');
  @override
  late final GeneratedColumn<String> slipId = GeneratedColumn<String>(
      'slip_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _roundNoMeta =
      const VerificationMeta('roundNo');
  @override
  late final GeneratedColumn<int> roundNo = GeneratedColumn<int>(
      'round_no', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _materialMeta =
      const VerificationMeta('material');
  @override
  late final GeneratedColumn<String> material = GeneratedColumn<String>(
      'material', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _extraMeta = const VerificationMeta('extra');
  @override
  late final GeneratedColumn<String> extra = GeneratedColumn<String>(
      'extra', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _grossKgMeta =
      const VerificationMeta('grossKg');
  @override
  late final GeneratedColumn<int> grossKg = GeneratedColumn<int>(
      'gross_kg', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _emptyTulaneKgMeta =
      const VerificationMeta('emptyTulaneKg');
  @override
  late final GeneratedColumn<int> emptyTulaneKg = GeneratedColumn<int>(
      'empty_tulane_kg', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _emptyDriverKgMeta =
      const VerificationMeta('emptyDriverKg');
  @override
  late final GeneratedColumn<int> emptyDriverKg = GeneratedColumn<int>(
      'empty_driver_kg', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _netKgMeta = const VerificationMeta('netKg');
  @override
  late final GeneratedColumn<int> netKg = GeneratedColumn<int>(
      'net_kg', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        slipId,
        roundNo,
        material,
        extra,
        grossKg,
        emptyTulaneKg,
        emptyDriverKg,
        netKg,
        createdAt,
        updatedAt,
        deletedAt,
        synced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'slip_rounds_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<SlipRoundsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('slip_id')) {
      context.handle(_slipIdMeta,
          slipId.isAcceptableOrUnknown(data['slip_id']!, _slipIdMeta));
    } else if (isInserting) {
      context.missing(_slipIdMeta);
    }
    if (data.containsKey('round_no')) {
      context.handle(_roundNoMeta,
          roundNo.isAcceptableOrUnknown(data['round_no']!, _roundNoMeta));
    } else if (isInserting) {
      context.missing(_roundNoMeta);
    }
    if (data.containsKey('material')) {
      context.handle(_materialMeta,
          material.isAcceptableOrUnknown(data['material']!, _materialMeta));
    }
    if (data.containsKey('extra')) {
      context.handle(
          _extraMeta, extra.isAcceptableOrUnknown(data['extra']!, _extraMeta));
    }
    if (data.containsKey('gross_kg')) {
      context.handle(_grossKgMeta,
          grossKg.isAcceptableOrUnknown(data['gross_kg']!, _grossKgMeta));
    } else if (isInserting) {
      context.missing(_grossKgMeta);
    }
    if (data.containsKey('empty_tulane_kg')) {
      context.handle(
          _emptyTulaneKgMeta,
          emptyTulaneKg.isAcceptableOrUnknown(
              data['empty_tulane_kg']!, _emptyTulaneKgMeta));
    }
    if (data.containsKey('empty_driver_kg')) {
      context.handle(
          _emptyDriverKgMeta,
          emptyDriverKg.isAcceptableOrUnknown(
              data['empty_driver_kg']!, _emptyDriverKgMeta));
    }
    if (data.containsKey('net_kg')) {
      context.handle(
          _netKgMeta, netKg.isAcceptableOrUnknown(data['net_kg']!, _netKgMeta));
    } else if (isInserting) {
      context.missing(_netKgMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SlipRoundsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SlipRoundsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      slipId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slip_id'])!,
      roundNo: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}round_no'])!,
      material: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}material']),
      extra: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}extra']),
      grossKg: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}gross_kg'])!,
      emptyTulaneKg: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}empty_tulane_kg']),
      emptyDriverKg: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}empty_driver_kg']),
      netKg: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}net_kg'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
    );
  }

  @override
  $SlipRoundsTableTable createAlias(String alias) {
    return $SlipRoundsTableTable(attachedDatabase, alias);
  }
}

class SlipRoundsTableData extends DataClass
    implements Insertable<SlipRoundsTableData> {
  final String id;
  final String slipId;
  final int roundNo;
  final String? material;
  final String? extra;
  final int grossKg;
  final int? emptyTulaneKg;
  final int? emptyDriverKg;
  final int netKg;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool synced;
  const SlipRoundsTableData(
      {required this.id,
      required this.slipId,
      required this.roundNo,
      this.material,
      this.extra,
      required this.grossKg,
      this.emptyTulaneKg,
      this.emptyDriverKg,
      required this.netKg,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.synced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['slip_id'] = Variable<String>(slipId);
    map['round_no'] = Variable<int>(roundNo);
    if (!nullToAbsent || material != null) {
      map['material'] = Variable<String>(material);
    }
    if (!nullToAbsent || extra != null) {
      map['extra'] = Variable<String>(extra);
    }
    map['gross_kg'] = Variable<int>(grossKg);
    if (!nullToAbsent || emptyTulaneKg != null) {
      map['empty_tulane_kg'] = Variable<int>(emptyTulaneKg);
    }
    if (!nullToAbsent || emptyDriverKg != null) {
      map['empty_driver_kg'] = Variable<int>(emptyDriverKg);
    }
    map['net_kg'] = Variable<int>(netKg);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  SlipRoundsTableCompanion toCompanion(bool nullToAbsent) {
    return SlipRoundsTableCompanion(
      id: Value(id),
      slipId: Value(slipId),
      roundNo: Value(roundNo),
      material: material == null && nullToAbsent
          ? const Value.absent()
          : Value(material),
      extra:
          extra == null && nullToAbsent ? const Value.absent() : Value(extra),
      grossKg: Value(grossKg),
      emptyTulaneKg: emptyTulaneKg == null && nullToAbsent
          ? const Value.absent()
          : Value(emptyTulaneKg),
      emptyDriverKg: emptyDriverKg == null && nullToAbsent
          ? const Value.absent()
          : Value(emptyDriverKg),
      netKg: Value(netKg),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      synced: Value(synced),
    );
  }

  factory SlipRoundsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SlipRoundsTableData(
      id: serializer.fromJson<String>(json['id']),
      slipId: serializer.fromJson<String>(json['slipId']),
      roundNo: serializer.fromJson<int>(json['roundNo']),
      material: serializer.fromJson<String?>(json['material']),
      extra: serializer.fromJson<String?>(json['extra']),
      grossKg: serializer.fromJson<int>(json['grossKg']),
      emptyTulaneKg: serializer.fromJson<int?>(json['emptyTulaneKg']),
      emptyDriverKg: serializer.fromJson<int?>(json['emptyDriverKg']),
      netKg: serializer.fromJson<int>(json['netKg']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'slipId': serializer.toJson<String>(slipId),
      'roundNo': serializer.toJson<int>(roundNo),
      'material': serializer.toJson<String?>(material),
      'extra': serializer.toJson<String?>(extra),
      'grossKg': serializer.toJson<int>(grossKg),
      'emptyTulaneKg': serializer.toJson<int?>(emptyTulaneKg),
      'emptyDriverKg': serializer.toJson<int?>(emptyDriverKg),
      'netKg': serializer.toJson<int>(netKg),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  SlipRoundsTableData copyWith(
          {String? id,
          String? slipId,
          int? roundNo,
          Value<String?> material = const Value.absent(),
          Value<String?> extra = const Value.absent(),
          int? grossKg,
          Value<int?> emptyTulaneKg = const Value.absent(),
          Value<int?> emptyDriverKg = const Value.absent(),
          int? netKg,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          bool? synced}) =>
      SlipRoundsTableData(
        id: id ?? this.id,
        slipId: slipId ?? this.slipId,
        roundNo: roundNo ?? this.roundNo,
        material: material.present ? material.value : this.material,
        extra: extra.present ? extra.value : this.extra,
        grossKg: grossKg ?? this.grossKg,
        emptyTulaneKg:
            emptyTulaneKg.present ? emptyTulaneKg.value : this.emptyTulaneKg,
        emptyDriverKg:
            emptyDriverKg.present ? emptyDriverKg.value : this.emptyDriverKg,
        netKg: netKg ?? this.netKg,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        synced: synced ?? this.synced,
      );
  SlipRoundsTableData copyWithCompanion(SlipRoundsTableCompanion data) {
    return SlipRoundsTableData(
      id: data.id.present ? data.id.value : this.id,
      slipId: data.slipId.present ? data.slipId.value : this.slipId,
      roundNo: data.roundNo.present ? data.roundNo.value : this.roundNo,
      material: data.material.present ? data.material.value : this.material,
      extra: data.extra.present ? data.extra.value : this.extra,
      grossKg: data.grossKg.present ? data.grossKg.value : this.grossKg,
      emptyTulaneKg: data.emptyTulaneKg.present
          ? data.emptyTulaneKg.value
          : this.emptyTulaneKg,
      emptyDriverKg: data.emptyDriverKg.present
          ? data.emptyDriverKg.value
          : this.emptyDriverKg,
      netKg: data.netKg.present ? data.netKg.value : this.netKg,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SlipRoundsTableData(')
          ..write('id: $id, ')
          ..write('slipId: $slipId, ')
          ..write('roundNo: $roundNo, ')
          ..write('material: $material, ')
          ..write('extra: $extra, ')
          ..write('grossKg: $grossKg, ')
          ..write('emptyTulaneKg: $emptyTulaneKg, ')
          ..write('emptyDriverKg: $emptyDriverKg, ')
          ..write('netKg: $netKg, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      slipId,
      roundNo,
      material,
      extra,
      grossKg,
      emptyTulaneKg,
      emptyDriverKg,
      netKg,
      createdAt,
      updatedAt,
      deletedAt,
      synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SlipRoundsTableData &&
          other.id == this.id &&
          other.slipId == this.slipId &&
          other.roundNo == this.roundNo &&
          other.material == this.material &&
          other.extra == this.extra &&
          other.grossKg == this.grossKg &&
          other.emptyTulaneKg == this.emptyTulaneKg &&
          other.emptyDriverKg == this.emptyDriverKg &&
          other.netKg == this.netKg &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.synced == this.synced);
}

class SlipRoundsTableCompanion extends UpdateCompanion<SlipRoundsTableData> {
  final Value<String> id;
  final Value<String> slipId;
  final Value<int> roundNo;
  final Value<String?> material;
  final Value<String?> extra;
  final Value<int> grossKg;
  final Value<int?> emptyTulaneKg;
  final Value<int?> emptyDriverKg;
  final Value<int> netKg;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> synced;
  final Value<int> rowid;
  const SlipRoundsTableCompanion({
    this.id = const Value.absent(),
    this.slipId = const Value.absent(),
    this.roundNo = const Value.absent(),
    this.material = const Value.absent(),
    this.extra = const Value.absent(),
    this.grossKg = const Value.absent(),
    this.emptyTulaneKg = const Value.absent(),
    this.emptyDriverKg = const Value.absent(),
    this.netKg = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SlipRoundsTableCompanion.insert({
    required String id,
    required String slipId,
    required int roundNo,
    this.material = const Value.absent(),
    this.extra = const Value.absent(),
    required int grossKg,
    this.emptyTulaneKg = const Value.absent(),
    this.emptyDriverKg = const Value.absent(),
    required int netKg,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        slipId = Value(slipId),
        roundNo = Value(roundNo),
        grossKg = Value(grossKg),
        netKg = Value(netKg),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<SlipRoundsTableData> custom({
    Expression<String>? id,
    Expression<String>? slipId,
    Expression<int>? roundNo,
    Expression<String>? material,
    Expression<String>? extra,
    Expression<int>? grossKg,
    Expression<int>? emptyTulaneKg,
    Expression<int>? emptyDriverKg,
    Expression<int>? netKg,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slipId != null) 'slip_id': slipId,
      if (roundNo != null) 'round_no': roundNo,
      if (material != null) 'material': material,
      if (extra != null) 'extra': extra,
      if (grossKg != null) 'gross_kg': grossKg,
      if (emptyTulaneKg != null) 'empty_tulane_kg': emptyTulaneKg,
      if (emptyDriverKg != null) 'empty_driver_kg': emptyDriverKg,
      if (netKg != null) 'net_kg': netKg,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SlipRoundsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? slipId,
      Value<int>? roundNo,
      Value<String?>? material,
      Value<String?>? extra,
      Value<int>? grossKg,
      Value<int?>? emptyTulaneKg,
      Value<int?>? emptyDriverKg,
      Value<int>? netKg,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<bool>? synced,
      Value<int>? rowid}) {
    return SlipRoundsTableCompanion(
      id: id ?? this.id,
      slipId: slipId ?? this.slipId,
      roundNo: roundNo ?? this.roundNo,
      material: material ?? this.material,
      extra: extra ?? this.extra,
      grossKg: grossKg ?? this.grossKg,
      emptyTulaneKg: emptyTulaneKg ?? this.emptyTulaneKg,
      emptyDriverKg: emptyDriverKg ?? this.emptyDriverKg,
      netKg: netKg ?? this.netKg,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (slipId.present) {
      map['slip_id'] = Variable<String>(slipId.value);
    }
    if (roundNo.present) {
      map['round_no'] = Variable<int>(roundNo.value);
    }
    if (material.present) {
      map['material'] = Variable<String>(material.value);
    }
    if (extra.present) {
      map['extra'] = Variable<String>(extra.value);
    }
    if (grossKg.present) {
      map['gross_kg'] = Variable<int>(grossKg.value);
    }
    if (emptyTulaneKg.present) {
      map['empty_tulane_kg'] = Variable<int>(emptyTulaneKg.value);
    }
    if (emptyDriverKg.present) {
      map['empty_driver_kg'] = Variable<int>(emptyDriverKg.value);
    }
    if (netKg.present) {
      map['net_kg'] = Variable<int>(netKg.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SlipRoundsTableCompanion(')
          ..write('id: $id, ')
          ..write('slipId: $slipId, ')
          ..write('roundNo: $roundNo, ')
          ..write('material: $material, ')
          ..write('extra: $extra, ')
          ..write('grossKg: $grossKg, ')
          ..write('emptyTulaneKg: $emptyTulaneKg, ')
          ..write('emptyDriverKg: $emptyDriverKg, ')
          ..write('netKg: $netKg, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTableTable extends PaymentsTable
    with TableInfo<$PaymentsTableTable, PaymentsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _slipIdMeta = const VerificationMeta('slipId');
  @override
  late final GeneratedColumn<String> slipId = GeneratedColumn<String>(
      'slip_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _udharCustomerIdMeta =
      const VerificationMeta('udharCustomerId');
  @override
  late final GeneratedColumn<String> udharCustomerId = GeneratedColumn<String>(
      'udhar_customer_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
      'mode', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _receivedAtMeta =
      const VerificationMeta('receivedAt');
  @override
  late final GeneratedColumn<DateTime> receivedAt = GeneratedColumn<DateTime>(
      'received_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
      'kind', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _receiptNoMeta =
      const VerificationMeta('receiptNo');
  @override
  late final GeneratedColumn<String> receiptNo = GeneratedColumn<String>(
      'receipt_no', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        slipId,
        udharCustomerId,
        amount,
        mode,
        receivedAt,
        kind,
        receiptNo,
        createdAt,
        updatedAt,
        deletedAt,
        synced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments_table';
  @override
  VerificationContext validateIntegrity(Insertable<PaymentsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('slip_id')) {
      context.handle(_slipIdMeta,
          slipId.isAcceptableOrUnknown(data['slip_id']!, _slipIdMeta));
    }
    if (data.containsKey('udhar_customer_id')) {
      context.handle(
          _udharCustomerIdMeta,
          udharCustomerId.isAcceptableOrUnknown(
              data['udhar_customer_id']!, _udharCustomerIdMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
          _modeMeta, mode.isAcceptableOrUnknown(data['mode']!, _modeMeta));
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('received_at')) {
      context.handle(
          _receivedAtMeta,
          receivedAt.isAcceptableOrUnknown(
              data['received_at']!, _receivedAtMeta));
    } else if (isInserting) {
      context.missing(_receivedAtMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
          _kindMeta, kind.isAcceptableOrUnknown(data['kind']!, _kindMeta));
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('receipt_no')) {
      context.handle(_receiptNoMeta,
          receiptNo.isAcceptableOrUnknown(data['receipt_no']!, _receiptNoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      slipId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slip_id']),
      udharCustomerId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}udhar_customer_id']),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      mode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mode'])!,
      receivedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}received_at'])!,
      kind: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kind'])!,
      receiptNo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}receipt_no']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
    );
  }

  @override
  $PaymentsTableTable createAlias(String alias) {
    return $PaymentsTableTable(attachedDatabase, alias);
  }
}

class PaymentsTableData extends DataClass
    implements Insertable<PaymentsTableData> {
  final String id;
  final String? slipId;
  final String? udharCustomerId;
  final int amount;
  final String mode;
  final DateTime receivedAt;
  final String kind;
  final String? receiptNo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool synced;
  const PaymentsTableData(
      {required this.id,
      this.slipId,
      this.udharCustomerId,
      required this.amount,
      required this.mode,
      required this.receivedAt,
      required this.kind,
      this.receiptNo,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.synced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || slipId != null) {
      map['slip_id'] = Variable<String>(slipId);
    }
    if (!nullToAbsent || udharCustomerId != null) {
      map['udhar_customer_id'] = Variable<String>(udharCustomerId);
    }
    map['amount'] = Variable<int>(amount);
    map['mode'] = Variable<String>(mode);
    map['received_at'] = Variable<DateTime>(receivedAt);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || receiptNo != null) {
      map['receipt_no'] = Variable<String>(receiptNo);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  PaymentsTableCompanion toCompanion(bool nullToAbsent) {
    return PaymentsTableCompanion(
      id: Value(id),
      slipId:
          slipId == null && nullToAbsent ? const Value.absent() : Value(slipId),
      udharCustomerId: udharCustomerId == null && nullToAbsent
          ? const Value.absent()
          : Value(udharCustomerId),
      amount: Value(amount),
      mode: Value(mode),
      receivedAt: Value(receivedAt),
      kind: Value(kind),
      receiptNo: receiptNo == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptNo),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      synced: Value(synced),
    );
  }

  factory PaymentsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentsTableData(
      id: serializer.fromJson<String>(json['id']),
      slipId: serializer.fromJson<String?>(json['slipId']),
      udharCustomerId: serializer.fromJson<String?>(json['udharCustomerId']),
      amount: serializer.fromJson<int>(json['amount']),
      mode: serializer.fromJson<String>(json['mode']),
      receivedAt: serializer.fromJson<DateTime>(json['receivedAt']),
      kind: serializer.fromJson<String>(json['kind']),
      receiptNo: serializer.fromJson<String?>(json['receiptNo']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'slipId': serializer.toJson<String?>(slipId),
      'udharCustomerId': serializer.toJson<String?>(udharCustomerId),
      'amount': serializer.toJson<int>(amount),
      'mode': serializer.toJson<String>(mode),
      'receivedAt': serializer.toJson<DateTime>(receivedAt),
      'kind': serializer.toJson<String>(kind),
      'receiptNo': serializer.toJson<String?>(receiptNo),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  PaymentsTableData copyWith(
          {String? id,
          Value<String?> slipId = const Value.absent(),
          Value<String?> udharCustomerId = const Value.absent(),
          int? amount,
          String? mode,
          DateTime? receivedAt,
          String? kind,
          Value<String?> receiptNo = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          bool? synced}) =>
      PaymentsTableData(
        id: id ?? this.id,
        slipId: slipId.present ? slipId.value : this.slipId,
        udharCustomerId: udharCustomerId.present
            ? udharCustomerId.value
            : this.udharCustomerId,
        amount: amount ?? this.amount,
        mode: mode ?? this.mode,
        receivedAt: receivedAt ?? this.receivedAt,
        kind: kind ?? this.kind,
        receiptNo: receiptNo.present ? receiptNo.value : this.receiptNo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        synced: synced ?? this.synced,
      );
  PaymentsTableData copyWithCompanion(PaymentsTableCompanion data) {
    return PaymentsTableData(
      id: data.id.present ? data.id.value : this.id,
      slipId: data.slipId.present ? data.slipId.value : this.slipId,
      udharCustomerId: data.udharCustomerId.present
          ? data.udharCustomerId.value
          : this.udharCustomerId,
      amount: data.amount.present ? data.amount.value : this.amount,
      mode: data.mode.present ? data.mode.value : this.mode,
      receivedAt:
          data.receivedAt.present ? data.receivedAt.value : this.receivedAt,
      kind: data.kind.present ? data.kind.value : this.kind,
      receiptNo: data.receiptNo.present ? data.receiptNo.value : this.receiptNo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsTableData(')
          ..write('id: $id, ')
          ..write('slipId: $slipId, ')
          ..write('udharCustomerId: $udharCustomerId, ')
          ..write('amount: $amount, ')
          ..write('mode: $mode, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('kind: $kind, ')
          ..write('receiptNo: $receiptNo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, slipId, udharCustomerId, amount, mode,
      receivedAt, kind, receiptNo, createdAt, updatedAt, deletedAt, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentsTableData &&
          other.id == this.id &&
          other.slipId == this.slipId &&
          other.udharCustomerId == this.udharCustomerId &&
          other.amount == this.amount &&
          other.mode == this.mode &&
          other.receivedAt == this.receivedAt &&
          other.kind == this.kind &&
          other.receiptNo == this.receiptNo &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.synced == this.synced);
}

class PaymentsTableCompanion extends UpdateCompanion<PaymentsTableData> {
  final Value<String> id;
  final Value<String?> slipId;
  final Value<String?> udharCustomerId;
  final Value<int> amount;
  final Value<String> mode;
  final Value<DateTime> receivedAt;
  final Value<String> kind;
  final Value<String?> receiptNo;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> synced;
  final Value<int> rowid;
  const PaymentsTableCompanion({
    this.id = const Value.absent(),
    this.slipId = const Value.absent(),
    this.udharCustomerId = const Value.absent(),
    this.amount = const Value.absent(),
    this.mode = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.kind = const Value.absent(),
    this.receiptNo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentsTableCompanion.insert({
    required String id,
    this.slipId = const Value.absent(),
    this.udharCustomerId = const Value.absent(),
    required int amount,
    required String mode,
    required DateTime receivedAt,
    required String kind,
    this.receiptNo = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        amount = Value(amount),
        mode = Value(mode),
        receivedAt = Value(receivedAt),
        kind = Value(kind),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<PaymentsTableData> custom({
    Expression<String>? id,
    Expression<String>? slipId,
    Expression<String>? udharCustomerId,
    Expression<int>? amount,
    Expression<String>? mode,
    Expression<DateTime>? receivedAt,
    Expression<String>? kind,
    Expression<String>? receiptNo,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slipId != null) 'slip_id': slipId,
      if (udharCustomerId != null) 'udhar_customer_id': udharCustomerId,
      if (amount != null) 'amount': amount,
      if (mode != null) 'mode': mode,
      if (receivedAt != null) 'received_at': receivedAt,
      if (kind != null) 'kind': kind,
      if (receiptNo != null) 'receipt_no': receiptNo,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentsTableCompanion copyWith(
      {Value<String>? id,
      Value<String?>? slipId,
      Value<String?>? udharCustomerId,
      Value<int>? amount,
      Value<String>? mode,
      Value<DateTime>? receivedAt,
      Value<String>? kind,
      Value<String?>? receiptNo,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<bool>? synced,
      Value<int>? rowid}) {
    return PaymentsTableCompanion(
      id: id ?? this.id,
      slipId: slipId ?? this.slipId,
      udharCustomerId: udharCustomerId ?? this.udharCustomerId,
      amount: amount ?? this.amount,
      mode: mode ?? this.mode,
      receivedAt: receivedAt ?? this.receivedAt,
      kind: kind ?? this.kind,
      receiptNo: receiptNo ?? this.receiptNo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (slipId.present) {
      map['slip_id'] = Variable<String>(slipId.value);
    }
    if (udharCustomerId.present) {
      map['udhar_customer_id'] = Variable<String>(udharCustomerId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (receivedAt.present) {
      map['received_at'] = Variable<DateTime>(receivedAt.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (receiptNo.present) {
      map['receipt_no'] = Variable<String>(receiptNo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsTableCompanion(')
          ..write('id: $id, ')
          ..write('slipId: $slipId, ')
          ..write('udharCustomerId: $udharCustomerId, ')
          ..write('amount: $amount, ')
          ..write('mode: $mode, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('kind: $kind, ')
          ..write('receiptNo: $receiptNo, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UdharCustomersTableTable extends UdharCustomersTable
    with TableInfo<$UdharCustomersTableTable, UdharCustomersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UdharCustomersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
      'customer_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, customerId, name, phone, createdAt, updatedAt, deletedAt, synced];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'udhar_customers_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<UdharCustomersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UdharCustomersTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UdharCustomersTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
    );
  }

  @override
  $UdharCustomersTableTable createAlias(String alias) {
    return $UdharCustomersTableTable(attachedDatabase, alias);
  }
}

class UdharCustomersTableData extends DataClass
    implements Insertable<UdharCustomersTableData> {
  final String id;
  final String? customerId;
  final String name;
  final String? phone;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool synced;
  const UdharCustomersTableData(
      {required this.id,
      this.customerId,
      required this.name,
      this.phone,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.synced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<String>(customerId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  UdharCustomersTableCompanion toCompanion(bool nullToAbsent) {
    return UdharCustomersTableCompanion(
      id: Value(id),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      name: Value(name),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      synced: Value(synced),
    );
  }

  factory UdharCustomersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UdharCustomersTableData(
      id: serializer.fromJson<String>(json['id']),
      customerId: serializer.fromJson<String?>(json['customerId']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'customerId': serializer.toJson<String?>(customerId),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  UdharCustomersTableData copyWith(
          {String? id,
          Value<String?> customerId = const Value.absent(),
          String? name,
          Value<String?> phone = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          bool? synced}) =>
      UdharCustomersTableData(
        id: id ?? this.id,
        customerId: customerId.present ? customerId.value : this.customerId,
        name: name ?? this.name,
        phone: phone.present ? phone.value : this.phone,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        synced: synced ?? this.synced,
      );
  UdharCustomersTableData copyWithCompanion(UdharCustomersTableCompanion data) {
    return UdharCustomersTableData(
      id: data.id.present ? data.id.value : this.id,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UdharCustomersTableData(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, customerId, name, phone, createdAt, updatedAt, deletedAt, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UdharCustomersTableData &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.synced == this.synced);
}

class UdharCustomersTableCompanion
    extends UpdateCompanion<UdharCustomersTableData> {
  final Value<String> id;
  final Value<String?> customerId;
  final Value<String> name;
  final Value<String?> phone;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> synced;
  final Value<int> rowid;
  const UdharCustomersTableCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UdharCustomersTableCompanion.insert({
    required String id,
    this.customerId = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<UdharCustomersTableData> custom({
    Expression<String>? id,
    Expression<String>? customerId,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UdharCustomersTableCompanion copyWith(
      {Value<String>? id,
      Value<String?>? customerId,
      Value<String>? name,
      Value<String?>? phone,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<bool>? synced,
      Value<int>? rowid}) {
    return UdharCustomersTableCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UdharCustomersTableCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UdharAllocationsTableTable extends UdharAllocationsTable
    with TableInfo<$UdharAllocationsTableTable, UdharAllocationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UdharAllocationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _paymentIdMeta =
      const VerificationMeta('paymentId');
  @override
  late final GeneratedColumn<String> paymentId = GeneratedColumn<String>(
      'payment_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _slipIdMeta = const VerificationMeta('slipId');
  @override
  late final GeneratedColumn<String> slipId = GeneratedColumn<String>(
      'slip_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountAppliedMeta =
      const VerificationMeta('amountApplied');
  @override
  late final GeneratedColumn<int> amountApplied = GeneratedColumn<int>(
      'amount_applied', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        paymentId,
        slipId,
        amountApplied,
        createdAt,
        updatedAt,
        deletedAt,
        synced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'udhar_allocations_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<UdharAllocationsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('payment_id')) {
      context.handle(_paymentIdMeta,
          paymentId.isAcceptableOrUnknown(data['payment_id']!, _paymentIdMeta));
    } else if (isInserting) {
      context.missing(_paymentIdMeta);
    }
    if (data.containsKey('slip_id')) {
      context.handle(_slipIdMeta,
          slipId.isAcceptableOrUnknown(data['slip_id']!, _slipIdMeta));
    } else if (isInserting) {
      context.missing(_slipIdMeta);
    }
    if (data.containsKey('amount_applied')) {
      context.handle(
          _amountAppliedMeta,
          amountApplied.isAcceptableOrUnknown(
              data['amount_applied']!, _amountAppliedMeta));
    } else if (isInserting) {
      context.missing(_amountAppliedMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UdharAllocationsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UdharAllocationsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      paymentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_id'])!,
      slipId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}slip_id'])!,
      amountApplied: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount_applied'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
    );
  }

  @override
  $UdharAllocationsTableTable createAlias(String alias) {
    return $UdharAllocationsTableTable(attachedDatabase, alias);
  }
}

class UdharAllocationsTableData extends DataClass
    implements Insertable<UdharAllocationsTableData> {
  final String id;
  final String paymentId;
  final String slipId;
  final int amountApplied;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool synced;
  const UdharAllocationsTableData(
      {required this.id,
      required this.paymentId,
      required this.slipId,
      required this.amountApplied,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.synced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['payment_id'] = Variable<String>(paymentId);
    map['slip_id'] = Variable<String>(slipId);
    map['amount_applied'] = Variable<int>(amountApplied);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  UdharAllocationsTableCompanion toCompanion(bool nullToAbsent) {
    return UdharAllocationsTableCompanion(
      id: Value(id),
      paymentId: Value(paymentId),
      slipId: Value(slipId),
      amountApplied: Value(amountApplied),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      synced: Value(synced),
    );
  }

  factory UdharAllocationsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UdharAllocationsTableData(
      id: serializer.fromJson<String>(json['id']),
      paymentId: serializer.fromJson<String>(json['paymentId']),
      slipId: serializer.fromJson<String>(json['slipId']),
      amountApplied: serializer.fromJson<int>(json['amountApplied']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'paymentId': serializer.toJson<String>(paymentId),
      'slipId': serializer.toJson<String>(slipId),
      'amountApplied': serializer.toJson<int>(amountApplied),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  UdharAllocationsTableData copyWith(
          {String? id,
          String? paymentId,
          String? slipId,
          int? amountApplied,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          bool? synced}) =>
      UdharAllocationsTableData(
        id: id ?? this.id,
        paymentId: paymentId ?? this.paymentId,
        slipId: slipId ?? this.slipId,
        amountApplied: amountApplied ?? this.amountApplied,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        synced: synced ?? this.synced,
      );
  UdharAllocationsTableData copyWithCompanion(
      UdharAllocationsTableCompanion data) {
    return UdharAllocationsTableData(
      id: data.id.present ? data.id.value : this.id,
      paymentId: data.paymentId.present ? data.paymentId.value : this.paymentId,
      slipId: data.slipId.present ? data.slipId.value : this.slipId,
      amountApplied: data.amountApplied.present
          ? data.amountApplied.value
          : this.amountApplied,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UdharAllocationsTableData(')
          ..write('id: $id, ')
          ..write('paymentId: $paymentId, ')
          ..write('slipId: $slipId, ')
          ..write('amountApplied: $amountApplied, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, paymentId, slipId, amountApplied,
      createdAt, updatedAt, deletedAt, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UdharAllocationsTableData &&
          other.id == this.id &&
          other.paymentId == this.paymentId &&
          other.slipId == this.slipId &&
          other.amountApplied == this.amountApplied &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.synced == this.synced);
}

class UdharAllocationsTableCompanion
    extends UpdateCompanion<UdharAllocationsTableData> {
  final Value<String> id;
  final Value<String> paymentId;
  final Value<String> slipId;
  final Value<int> amountApplied;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> synced;
  final Value<int> rowid;
  const UdharAllocationsTableCompanion({
    this.id = const Value.absent(),
    this.paymentId = const Value.absent(),
    this.slipId = const Value.absent(),
    this.amountApplied = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UdharAllocationsTableCompanion.insert({
    required String id,
    required String paymentId,
    required String slipId,
    required int amountApplied,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        paymentId = Value(paymentId),
        slipId = Value(slipId),
        amountApplied = Value(amountApplied),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<UdharAllocationsTableData> custom({
    Expression<String>? id,
    Expression<String>? paymentId,
    Expression<String>? slipId,
    Expression<int>? amountApplied,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (paymentId != null) 'payment_id': paymentId,
      if (slipId != null) 'slip_id': slipId,
      if (amountApplied != null) 'amount_applied': amountApplied,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UdharAllocationsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? paymentId,
      Value<String>? slipId,
      Value<int>? amountApplied,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<bool>? synced,
      Value<int>? rowid}) {
    return UdharAllocationsTableCompanion(
      id: id ?? this.id,
      paymentId: paymentId ?? this.paymentId,
      slipId: slipId ?? this.slipId,
      amountApplied: amountApplied ?? this.amountApplied,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (paymentId.present) {
      map['payment_id'] = Variable<String>(paymentId.value);
    }
    if (slipId.present) {
      map['slip_id'] = Variable<String>(slipId.value);
    }
    if (amountApplied.present) {
      map['amount_applied'] = Variable<int>(amountApplied.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UdharAllocationsTableCompanion(')
          ..write('id: $id, ')
          ..write('paymentId: $paymentId, ')
          ..write('slipId: $slipId, ')
          ..write('amountApplied: $amountApplied, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpenseCategoriesTableTable extends ExpenseCategoriesTable
    with TableInfo<$ExpenseCategoriesTableTable, ExpenseCategoriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseCategoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorHexMeta =
      const VerificationMeta('colorHex');
  @override
  late final GeneratedColumn<String> colorHex = GeneratedColumn<String>(
      'color_hex', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _iconNameMeta =
      const VerificationMeta('iconName');
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
      'icon_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, colorHex, iconName, createdAt, updatedAt, deletedAt, synced];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_categories_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ExpenseCategoriesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color_hex')) {
      context.handle(_colorHexMeta,
          colorHex.isAcceptableOrUnknown(data['color_hex']!, _colorHexMeta));
    }
    if (data.containsKey('icon_name')) {
      context.handle(_iconNameMeta,
          iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseCategoriesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseCategoriesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      colorHex: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_hex']),
      iconName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_name']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
    );
  }

  @override
  $ExpenseCategoriesTableTable createAlias(String alias) {
    return $ExpenseCategoriesTableTable(attachedDatabase, alias);
  }
}

class ExpenseCategoriesTableData extends DataClass
    implements Insertable<ExpenseCategoriesTableData> {
  final String id;
  final String name;
  final String? colorHex;
  final String? iconName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool synced;
  const ExpenseCategoriesTableData(
      {required this.id,
      required this.name,
      this.colorHex,
      this.iconName,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.synced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || colorHex != null) {
      map['color_hex'] = Variable<String>(colorHex);
    }
    if (!nullToAbsent || iconName != null) {
      map['icon_name'] = Variable<String>(iconName);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  ExpenseCategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return ExpenseCategoriesTableCompanion(
      id: Value(id),
      name: Value(name),
      colorHex: colorHex == null && nullToAbsent
          ? const Value.absent()
          : Value(colorHex),
      iconName: iconName == null && nullToAbsent
          ? const Value.absent()
          : Value(iconName),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      synced: Value(synced),
    );
  }

  factory ExpenseCategoriesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseCategoriesTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      colorHex: serializer.fromJson<String?>(json['colorHex']),
      iconName: serializer.fromJson<String?>(json['iconName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'colorHex': serializer.toJson<String?>(colorHex),
      'iconName': serializer.toJson<String?>(iconName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  ExpenseCategoriesTableData copyWith(
          {String? id,
          String? name,
          Value<String?> colorHex = const Value.absent(),
          Value<String?> iconName = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          bool? synced}) =>
      ExpenseCategoriesTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        colorHex: colorHex.present ? colorHex.value : this.colorHex,
        iconName: iconName.present ? iconName.value : this.iconName,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        synced: synced ?? this.synced,
      );
  ExpenseCategoriesTableData copyWithCompanion(
      ExpenseCategoriesTableCompanion data) {
    return ExpenseCategoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      colorHex: data.colorHex.present ? data.colorHex.value : this.colorHex,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseCategoriesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorHex: $colorHex, ')
          ..write('iconName: $iconName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, colorHex, iconName, createdAt, updatedAt, deletedAt, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseCategoriesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.colorHex == this.colorHex &&
          other.iconName == this.iconName &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.synced == this.synced);
}

class ExpenseCategoriesTableCompanion
    extends UpdateCompanion<ExpenseCategoriesTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> colorHex;
  final Value<String?> iconName;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> synced;
  final Value<int> rowid;
  const ExpenseCategoriesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.colorHex = const Value.absent(),
    this.iconName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpenseCategoriesTableCompanion.insert({
    required String id,
    required String name,
    this.colorHex = const Value.absent(),
    this.iconName = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<ExpenseCategoriesTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? colorHex,
    Expression<String>? iconName,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (colorHex != null) 'color_hex': colorHex,
      if (iconName != null) 'icon_name': iconName,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpenseCategoriesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? colorHex,
      Value<String?>? iconName,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<bool>? synced,
      Value<int>? rowid}) {
    return ExpenseCategoriesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      colorHex: colorHex ?? this.colorHex,
      iconName: iconName ?? this.iconName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (colorHex.present) {
      map['color_hex'] = Variable<String>(colorHex.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseCategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colorHex: $colorHex, ')
          ..write('iconName: $iconName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTableTable extends ExpensesTable
    with TableInfo<$ExpensesTableTable, ExpensesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
      'mode', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        amount,
        mode,
        date,
        note,
        createdAt,
        updatedAt,
        deletedAt,
        synced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses_table';
  @override
  VerificationContext validateIntegrity(Insertable<ExpensesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
          _modeMeta, mode.isAcceptableOrUnknown(data['mode']!, _modeMeta));
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpensesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpensesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      mode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mode'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
    );
  }

  @override
  $ExpensesTableTable createAlias(String alias) {
    return $ExpensesTableTable(attachedDatabase, alias);
  }
}

class ExpensesTableData extends DataClass
    implements Insertable<ExpensesTableData> {
  final String id;
  final String name;
  final int amount;
  final String mode;
  final DateTime date;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool synced;
  const ExpensesTableData(
      {required this.id,
      required this.name,
      required this.amount,
      required this.mode,
      required this.date,
      this.note,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.synced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<int>(amount);
    map['mode'] = Variable<String>(mode);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  ExpensesTableCompanion toCompanion(bool nullToAbsent) {
    return ExpensesTableCompanion(
      id: Value(id),
      name: Value(name),
      amount: Value(amount),
      mode: Value(mode),
      date: Value(date),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      synced: Value(synced),
    );
  }

  factory ExpensesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpensesTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<int>(json['amount']),
      mode: serializer.fromJson<String>(json['mode']),
      date: serializer.fromJson<DateTime>(json['date']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<int>(amount),
      'mode': serializer.toJson<String>(mode),
      'date': serializer.toJson<DateTime>(date),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  ExpensesTableData copyWith(
          {String? id,
          String? name,
          int? amount,
          String? mode,
          DateTime? date,
          Value<String?> note = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          bool? synced}) =>
      ExpensesTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        mode: mode ?? this.mode,
        date: date ?? this.date,
        note: note.present ? note.value : this.note,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        synced: synced ?? this.synced,
      );
  ExpensesTableData copyWithCompanion(ExpensesTableCompanion data) {
    return ExpensesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      amount: data.amount.present ? data.amount.value : this.amount,
      mode: data.mode.present ? data.mode.value : this.mode,
      date: data.date.present ? data.date.value : this.date,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('mode: $mode, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, amount, mode, date, note, createdAt,
      updatedAt, deletedAt, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpensesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.mode == this.mode &&
          other.date == this.date &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.synced == this.synced);
}

class ExpensesTableCompanion extends UpdateCompanion<ExpensesTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> amount;
  final Value<String> mode;
  final Value<DateTime> date;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> synced;
  final Value<int> rowid;
  const ExpensesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.mode = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesTableCompanion.insert({
    required String id,
    required String name,
    required int amount,
    required String mode,
    required DateTime date,
    this.note = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        amount = Value(amount),
        mode = Value(mode),
        date = Value(date),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<ExpensesTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? amount,
    Expression<String>? mode,
    Expression<DateTime>? date,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (mode != null) 'mode': mode,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<int>? amount,
      Value<String>? mode,
      Value<DateTime>? date,
      Value<String?>? note,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<bool>? synced,
      Value<int>? rowid}) {
    return ExpensesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      mode: mode ?? this.mode,
      date: date ?? this.date,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('mode: $mode, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTableTable extends SuppliersTable
    with TableInfo<$SuppliersTableTable, SuppliersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ratePerUnitMeta =
      const VerificationMeta('ratePerUnit');
  @override
  late final GeneratedColumn<int> ratePerUnit = GeneratedColumn<int>(
      'rate_per_unit', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _unitNameMeta =
      const VerificationMeta('unitName');
  @override
  late final GeneratedColumn<String> unitName = GeneratedColumn<String>(
      'unit_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        category,
        ratePerUnit,
        unitName,
        createdAt,
        updatedAt,
        deletedAt,
        synced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suppliers_table';
  @override
  VerificationContext validateIntegrity(Insertable<SuppliersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('rate_per_unit')) {
      context.handle(
          _ratePerUnitMeta,
          ratePerUnit.isAcceptableOrUnknown(
              data['rate_per_unit']!, _ratePerUnitMeta));
    }
    if (data.containsKey('unit_name')) {
      context.handle(_unitNameMeta,
          unitName.isAcceptableOrUnknown(data['unit_name']!, _unitNameMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SuppliersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SuppliersTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      ratePerUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rate_per_unit']),
      unitName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit_name']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
    );
  }

  @override
  $SuppliersTableTable createAlias(String alias) {
    return $SuppliersTableTable(attachedDatabase, alias);
  }
}

class SuppliersTableData extends DataClass
    implements Insertable<SuppliersTableData> {
  final String id;
  final String name;
  final String? category;
  final int? ratePerUnit;
  final String? unitName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool synced;
  const SuppliersTableData(
      {required this.id,
      required this.name,
      this.category,
      this.ratePerUnit,
      this.unitName,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.synced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || ratePerUnit != null) {
      map['rate_per_unit'] = Variable<int>(ratePerUnit);
    }
    if (!nullToAbsent || unitName != null) {
      map['unit_name'] = Variable<String>(unitName);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  SuppliersTableCompanion toCompanion(bool nullToAbsent) {
    return SuppliersTableCompanion(
      id: Value(id),
      name: Value(name),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      ratePerUnit: ratePerUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(ratePerUnit),
      unitName: unitName == null && nullToAbsent
          ? const Value.absent()
          : Value(unitName),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      synced: Value(synced),
    );
  }

  factory SuppliersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SuppliersTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String?>(json['category']),
      ratePerUnit: serializer.fromJson<int?>(json['ratePerUnit']),
      unitName: serializer.fromJson<String?>(json['unitName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String?>(category),
      'ratePerUnit': serializer.toJson<int?>(ratePerUnit),
      'unitName': serializer.toJson<String?>(unitName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  SuppliersTableData copyWith(
          {String? id,
          String? name,
          Value<String?> category = const Value.absent(),
          Value<int?> ratePerUnit = const Value.absent(),
          Value<String?> unitName = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          bool? synced}) =>
      SuppliersTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category.present ? category.value : this.category,
        ratePerUnit: ratePerUnit.present ? ratePerUnit.value : this.ratePerUnit,
        unitName: unitName.present ? unitName.value : this.unitName,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        synced: synced ?? this.synced,
      );
  SuppliersTableData copyWithCompanion(SuppliersTableCompanion data) {
    return SuppliersTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      ratePerUnit:
          data.ratePerUnit.present ? data.ratePerUnit.value : this.ratePerUnit,
      unitName: data.unitName.present ? data.unitName.value : this.unitName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('ratePerUnit: $ratePerUnit, ')
          ..write('unitName: $unitName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, category, ratePerUnit, unitName,
      createdAt, updatedAt, deletedAt, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SuppliersTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.ratePerUnit == this.ratePerUnit &&
          other.unitName == this.unitName &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.synced == this.synced);
}

class SuppliersTableCompanion extends UpdateCompanion<SuppliersTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> category;
  final Value<int?> ratePerUnit;
  final Value<String?> unitName;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> synced;
  final Value<int> rowid;
  const SuppliersTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.ratePerUnit = const Value.absent(),
    this.unitName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SuppliersTableCompanion.insert({
    required String id,
    required String name,
    this.category = const Value.absent(),
    this.ratePerUnit = const Value.absent(),
    this.unitName = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<SuppliersTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<int>? ratePerUnit,
    Expression<String>? unitName,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (ratePerUnit != null) 'rate_per_unit': ratePerUnit,
      if (unitName != null) 'unit_name': unitName,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SuppliersTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? category,
      Value<int?>? ratePerUnit,
      Value<String?>? unitName,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<bool>? synced,
      Value<int>? rowid}) {
    return SuppliersTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      ratePerUnit: ratePerUnit ?? this.ratePerUnit,
      unitName: unitName ?? this.unitName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (ratePerUnit.present) {
      map['rate_per_unit'] = Variable<int>(ratePerUnit.value);
    }
    if (unitName.present) {
      map['unit_name'] = Variable<String>(unitName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('ratePerUnit: $ratePerUnit, ')
          ..write('unitName: $unitName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SupplierEntriesTableTable extends SupplierEntriesTable
    with TableInfo<$SupplierEntriesTableTable, SupplierEntriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupplierEntriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _supplierIdMeta =
      const VerificationMeta('supplierId');
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
      'supplier_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
      'count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        supplierId,
        date,
        count,
        amount,
        note,
        createdAt,
        updatedAt,
        deletedAt,
        synced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supplier_entries_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<SupplierEntriesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
          _supplierIdMeta,
          supplierId.isAcceptableOrUnknown(
              data['supplier_id']!, _supplierIdMeta));
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count']!, _countMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SupplierEntriesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierEntriesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      supplierId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}supplier_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      count: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}count']),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
    );
  }

  @override
  $SupplierEntriesTableTable createAlias(String alias) {
    return $SupplierEntriesTableTable(attachedDatabase, alias);
  }
}

class SupplierEntriesTableData extends DataClass
    implements Insertable<SupplierEntriesTableData> {
  final String id;
  final String supplierId;
  final DateTime date;
  final int? count;
  final int amount;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool synced;
  const SupplierEntriesTableData(
      {required this.id,
      required this.supplierId,
      required this.date,
      this.count,
      required this.amount,
      this.note,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.synced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['supplier_id'] = Variable<String>(supplierId);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || count != null) {
      map['count'] = Variable<int>(count);
    }
    map['amount'] = Variable<int>(amount);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  SupplierEntriesTableCompanion toCompanion(bool nullToAbsent) {
    return SupplierEntriesTableCompanion(
      id: Value(id),
      supplierId: Value(supplierId),
      date: Value(date),
      count:
          count == null && nullToAbsent ? const Value.absent() : Value(count),
      amount: Value(amount),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      synced: Value(synced),
    );
  }

  factory SupplierEntriesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierEntriesTableData(
      id: serializer.fromJson<String>(json['id']),
      supplierId: serializer.fromJson<String>(json['supplierId']),
      date: serializer.fromJson<DateTime>(json['date']),
      count: serializer.fromJson<int?>(json['count']),
      amount: serializer.fromJson<int>(json['amount']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'supplierId': serializer.toJson<String>(supplierId),
      'date': serializer.toJson<DateTime>(date),
      'count': serializer.toJson<int?>(count),
      'amount': serializer.toJson<int>(amount),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  SupplierEntriesTableData copyWith(
          {String? id,
          String? supplierId,
          DateTime? date,
          Value<int?> count = const Value.absent(),
          int? amount,
          Value<String?> note = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          bool? synced}) =>
      SupplierEntriesTableData(
        id: id ?? this.id,
        supplierId: supplierId ?? this.supplierId,
        date: date ?? this.date,
        count: count.present ? count.value : this.count,
        amount: amount ?? this.amount,
        note: note.present ? note.value : this.note,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        synced: synced ?? this.synced,
      );
  SupplierEntriesTableData copyWithCompanion(
      SupplierEntriesTableCompanion data) {
    return SupplierEntriesTableData(
      id: data.id.present ? data.id.value : this.id,
      supplierId:
          data.supplierId.present ? data.supplierId.value : this.supplierId,
      date: data.date.present ? data.date.value : this.date,
      count: data.count.present ? data.count.value : this.count,
      amount: data.amount.present ? data.amount.value : this.amount,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierEntriesTableData(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('date: $date, ')
          ..write('count: $count, ')
          ..write('amount: $amount, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, supplierId, date, count, amount, note,
      createdAt, updatedAt, deletedAt, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierEntriesTableData &&
          other.id == this.id &&
          other.supplierId == this.supplierId &&
          other.date == this.date &&
          other.count == this.count &&
          other.amount == this.amount &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.synced == this.synced);
}

class SupplierEntriesTableCompanion
    extends UpdateCompanion<SupplierEntriesTableData> {
  final Value<String> id;
  final Value<String> supplierId;
  final Value<DateTime> date;
  final Value<int?> count;
  final Value<int> amount;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> synced;
  final Value<int> rowid;
  const SupplierEntriesTableCompanion({
    this.id = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.date = const Value.absent(),
    this.count = const Value.absent(),
    this.amount = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SupplierEntriesTableCompanion.insert({
    required String id,
    required String supplierId,
    required DateTime date,
    this.count = const Value.absent(),
    required int amount,
    this.note = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        supplierId = Value(supplierId),
        date = Value(date),
        amount = Value(amount),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<SupplierEntriesTableData> custom({
    Expression<String>? id,
    Expression<String>? supplierId,
    Expression<DateTime>? date,
    Expression<int>? count,
    Expression<int>? amount,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (supplierId != null) 'supplier_id': supplierId,
      if (date != null) 'date': date,
      if (count != null) 'count': count,
      if (amount != null) 'amount': amount,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SupplierEntriesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? supplierId,
      Value<DateTime>? date,
      Value<int?>? count,
      Value<int>? amount,
      Value<String?>? note,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<bool>? synced,
      Value<int>? rowid}) {
    return SupplierEntriesTableCompanion(
      id: id ?? this.id,
      supplierId: supplierId ?? this.supplierId,
      date: date ?? this.date,
      count: count ?? this.count,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SupplierEntriesTableCompanion(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('date: $date, ')
          ..write('count: $count, ')
          ..write('amount: $amount, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SupplierPaymentsTableTable extends SupplierPaymentsTable
    with TableInfo<$SupplierPaymentsTableTable, SupplierPaymentsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupplierPaymentsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _supplierIdMeta =
      const VerificationMeta('supplierId');
  @override
  late final GeneratedColumn<String> supplierId = GeneratedColumn<String>(
      'supplier_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
      'mode', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _expenseIdMeta =
      const VerificationMeta('expenseId');
  @override
  late final GeneratedColumn<String> expenseId = GeneratedColumn<String>(
      'expense_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        supplierId,
        amount,
        mode,
        date,
        expenseId,
        createdAt,
        updatedAt,
        deletedAt,
        synced
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supplier_payments_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<SupplierPaymentsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('supplier_id')) {
      context.handle(
          _supplierIdMeta,
          supplierId.isAcceptableOrUnknown(
              data['supplier_id']!, _supplierIdMeta));
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
          _modeMeta, mode.isAcceptableOrUnknown(data['mode']!, _modeMeta));
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('expense_id')) {
      context.handle(_expenseIdMeta,
          expenseId.isAcceptableOrUnknown(data['expense_id']!, _expenseIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SupplierPaymentsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierPaymentsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      supplierId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}supplier_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      mode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mode'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      expenseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}expense_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
    );
  }

  @override
  $SupplierPaymentsTableTable createAlias(String alias) {
    return $SupplierPaymentsTableTable(attachedDatabase, alias);
  }
}

class SupplierPaymentsTableData extends DataClass
    implements Insertable<SupplierPaymentsTableData> {
  final String id;
  final String supplierId;
  final int amount;
  final String mode;
  final DateTime date;
  final String? expenseId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool synced;
  const SupplierPaymentsTableData(
      {required this.id,
      required this.supplierId,
      required this.amount,
      required this.mode,
      required this.date,
      this.expenseId,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.synced});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['supplier_id'] = Variable<String>(supplierId);
    map['amount'] = Variable<int>(amount);
    map['mode'] = Variable<String>(mode);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || expenseId != null) {
      map['expense_id'] = Variable<String>(expenseId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['synced'] = Variable<bool>(synced);
    return map;
  }

  SupplierPaymentsTableCompanion toCompanion(bool nullToAbsent) {
    return SupplierPaymentsTableCompanion(
      id: Value(id),
      supplierId: Value(supplierId),
      amount: Value(amount),
      mode: Value(mode),
      date: Value(date),
      expenseId: expenseId == null && nullToAbsent
          ? const Value.absent()
          : Value(expenseId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      synced: Value(synced),
    );
  }

  factory SupplierPaymentsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierPaymentsTableData(
      id: serializer.fromJson<String>(json['id']),
      supplierId: serializer.fromJson<String>(json['supplierId']),
      amount: serializer.fromJson<int>(json['amount']),
      mode: serializer.fromJson<String>(json['mode']),
      date: serializer.fromJson<DateTime>(json['date']),
      expenseId: serializer.fromJson<String?>(json['expenseId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'supplierId': serializer.toJson<String>(supplierId),
      'amount': serializer.toJson<int>(amount),
      'mode': serializer.toJson<String>(mode),
      'date': serializer.toJson<DateTime>(date),
      'expenseId': serializer.toJson<String?>(expenseId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  SupplierPaymentsTableData copyWith(
          {String? id,
          String? supplierId,
          int? amount,
          String? mode,
          DateTime? date,
          Value<String?> expenseId = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent(),
          bool? synced}) =>
      SupplierPaymentsTableData(
        id: id ?? this.id,
        supplierId: supplierId ?? this.supplierId,
        amount: amount ?? this.amount,
        mode: mode ?? this.mode,
        date: date ?? this.date,
        expenseId: expenseId.present ? expenseId.value : this.expenseId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
        synced: synced ?? this.synced,
      );
  SupplierPaymentsTableData copyWithCompanion(
      SupplierPaymentsTableCompanion data) {
    return SupplierPaymentsTableData(
      id: data.id.present ? data.id.value : this.id,
      supplierId:
          data.supplierId.present ? data.supplierId.value : this.supplierId,
      amount: data.amount.present ? data.amount.value : this.amount,
      mode: data.mode.present ? data.mode.value : this.mode,
      date: data.date.present ? data.date.value : this.date,
      expenseId: data.expenseId.present ? data.expenseId.value : this.expenseId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierPaymentsTableData(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('amount: $amount, ')
          ..write('mode: $mode, ')
          ..write('date: $date, ')
          ..write('expenseId: $expenseId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, supplierId, amount, mode, date, expenseId,
      createdAt, updatedAt, deletedAt, synced);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierPaymentsTableData &&
          other.id == this.id &&
          other.supplierId == this.supplierId &&
          other.amount == this.amount &&
          other.mode == this.mode &&
          other.date == this.date &&
          other.expenseId == this.expenseId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.synced == this.synced);
}

class SupplierPaymentsTableCompanion
    extends UpdateCompanion<SupplierPaymentsTableData> {
  final Value<String> id;
  final Value<String> supplierId;
  final Value<int> amount;
  final Value<String> mode;
  final Value<DateTime> date;
  final Value<String?> expenseId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<bool> synced;
  final Value<int> rowid;
  const SupplierPaymentsTableCompanion({
    this.id = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.amount = const Value.absent(),
    this.mode = const Value.absent(),
    this.date = const Value.absent(),
    this.expenseId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SupplierPaymentsTableCompanion.insert({
    required String id,
    required String supplierId,
    required int amount,
    required String mode,
    required DateTime date,
    this.expenseId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        supplierId = Value(supplierId),
        amount = Value(amount),
        mode = Value(mode),
        date = Value(date),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<SupplierPaymentsTableData> custom({
    Expression<String>? id,
    Expression<String>? supplierId,
    Expression<int>? amount,
    Expression<String>? mode,
    Expression<DateTime>? date,
    Expression<String>? expenseId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<bool>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (supplierId != null) 'supplier_id': supplierId,
      if (amount != null) 'amount': amount,
      if (mode != null) 'mode': mode,
      if (date != null) 'date': date,
      if (expenseId != null) 'expense_id': expenseId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SupplierPaymentsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? supplierId,
      Value<int>? amount,
      Value<String>? mode,
      Value<DateTime>? date,
      Value<String?>? expenseId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<bool>? synced,
      Value<int>? rowid}) {
    return SupplierPaymentsTableCompanion(
      id: id ?? this.id,
      supplierId: supplierId ?? this.supplierId,
      amount: amount ?? this.amount,
      mode: mode ?? this.mode,
      date: date ?? this.date,
      expenseId: expenseId ?? this.expenseId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<String>(supplierId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (expenseId.present) {
      map['expense_id'] = Variable<String>(expenseId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SupplierPaymentsTableCompanion(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('amount: $amount, ')
          ..write('mode: $mode, ')
          ..write('date: $date, ')
          ..write('expenseId: $expenseId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CountersTableTable extends CountersTable
    with TableInfo<$CountersTableTable, CountersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CountersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _currentValueMeta =
      const VerificationMeta('currentValue');
  @override
  late final GeneratedColumn<int> currentValue = GeneratedColumn<int>(
      'current_value', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [name, currentValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'counters_table';
  @override
  VerificationContext validateIntegrity(Insertable<CountersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('current_value')) {
      context.handle(
          _currentValueMeta,
          currentValue.isAcceptableOrUnknown(
              data['current_value']!, _currentValueMeta));
    } else if (isInserting) {
      context.missing(_currentValueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  CountersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CountersTableData(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      currentValue: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_value'])!,
    );
  }

  @override
  $CountersTableTable createAlias(String alias) {
    return $CountersTableTable(attachedDatabase, alias);
  }
}

class CountersTableData extends DataClass
    implements Insertable<CountersTableData> {
  final String name;
  final int currentValue;
  const CountersTableData({required this.name, required this.currentValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['current_value'] = Variable<int>(currentValue);
    return map;
  }

  CountersTableCompanion toCompanion(bool nullToAbsent) {
    return CountersTableCompanion(
      name: Value(name),
      currentValue: Value(currentValue),
    );
  }

  factory CountersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CountersTableData(
      name: serializer.fromJson<String>(json['name']),
      currentValue: serializer.fromJson<int>(json['currentValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'currentValue': serializer.toJson<int>(currentValue),
    };
  }

  CountersTableData copyWith({String? name, int? currentValue}) =>
      CountersTableData(
        name: name ?? this.name,
        currentValue: currentValue ?? this.currentValue,
      );
  CountersTableData copyWithCompanion(CountersTableCompanion data) {
    return CountersTableData(
      name: data.name.present ? data.name.value : this.name,
      currentValue: data.currentValue.present
          ? data.currentValue.value
          : this.currentValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CountersTableData(')
          ..write('name: $name, ')
          ..write('currentValue: $currentValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, currentValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CountersTableData &&
          other.name == this.name &&
          other.currentValue == this.currentValue);
}

class CountersTableCompanion extends UpdateCompanion<CountersTableData> {
  final Value<String> name;
  final Value<int> currentValue;
  final Value<int> rowid;
  const CountersTableCompanion({
    this.name = const Value.absent(),
    this.currentValue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CountersTableCompanion.insert({
    required String name,
    required int currentValue,
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        currentValue = Value(currentValue);
  static Insertable<CountersTableData> custom({
    Expression<String>? name,
    Expression<int>? currentValue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (currentValue != null) 'current_value': currentValue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CountersTableCompanion copyWith(
      {Value<String>? name, Value<int>? currentValue, Value<int>? rowid}) {
    return CountersTableCompanion(
      name: name ?? this.name,
      currentValue: currentValue ?? this.currentValue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (currentValue.present) {
      map['current_value'] = Variable<int>(currentValue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CountersTableCompanion(')
          ..write('name: $name, ')
          ..write('currentValue: $currentValue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuditLogTableTable extends AuditLogTable
    with TableInfo<$AuditLogTableTable, AuditLogTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityNameMeta =
      const VerificationMeta('entityName');
  @override
  late final GeneratedColumn<String> entityName = GeneratedColumn<String>(
      'entity_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
      'action', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _detailsJsonMeta =
      const VerificationMeta('detailsJson');
  @override
  late final GeneratedColumn<String> detailsJson = GeneratedColumn<String>(
      'details_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, entityName, entityId, action, detailsJson, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_log_table';
  @override
  VerificationContext validateIntegrity(Insertable<AuditLogTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entity_name')) {
      context.handle(
          _entityNameMeta,
          entityName.isAcceptableOrUnknown(
              data['entity_name']!, _entityNameMeta));
    } else if (isInserting) {
      context.missing(_entityNameMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('action')) {
      context.handle(_actionMeta,
          action.isAcceptableOrUnknown(data['action']!, _actionMeta));
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('details_json')) {
      context.handle(
          _detailsJsonMeta,
          detailsJson.isAcceptableOrUnknown(
              data['details_json']!, _detailsJsonMeta));
    } else if (isInserting) {
      context.missing(_detailsJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLogTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLogTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      entityName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_name'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      action: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}action'])!,
      detailsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}details_json'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AuditLogTableTable createAlias(String alias) {
    return $AuditLogTableTable(attachedDatabase, alias);
  }
}

class AuditLogTableData extends DataClass
    implements Insertable<AuditLogTableData> {
  final String id;
  final String entityName;
  final String entityId;
  final String action;
  final String detailsJson;
  final DateTime createdAt;
  const AuditLogTableData(
      {required this.id,
      required this.entityName,
      required this.entityId,
      required this.action,
      required this.detailsJson,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entity_name'] = Variable<String>(entityName);
    map['entity_id'] = Variable<String>(entityId);
    map['action'] = Variable<String>(action);
    map['details_json'] = Variable<String>(detailsJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AuditLogTableCompanion toCompanion(bool nullToAbsent) {
    return AuditLogTableCompanion(
      id: Value(id),
      entityName: Value(entityName),
      entityId: Value(entityId),
      action: Value(action),
      detailsJson: Value(detailsJson),
      createdAt: Value(createdAt),
    );
  }

  factory AuditLogTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLogTableData(
      id: serializer.fromJson<String>(json['id']),
      entityName: serializer.fromJson<String>(json['entityName']),
      entityId: serializer.fromJson<String>(json['entityId']),
      action: serializer.fromJson<String>(json['action']),
      detailsJson: serializer.fromJson<String>(json['detailsJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entityName': serializer.toJson<String>(entityName),
      'entityId': serializer.toJson<String>(entityId),
      'action': serializer.toJson<String>(action),
      'detailsJson': serializer.toJson<String>(detailsJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AuditLogTableData copyWith(
          {String? id,
          String? entityName,
          String? entityId,
          String? action,
          String? detailsJson,
          DateTime? createdAt}) =>
      AuditLogTableData(
        id: id ?? this.id,
        entityName: entityName ?? this.entityName,
        entityId: entityId ?? this.entityId,
        action: action ?? this.action,
        detailsJson: detailsJson ?? this.detailsJson,
        createdAt: createdAt ?? this.createdAt,
      );
  AuditLogTableData copyWithCompanion(AuditLogTableCompanion data) {
    return AuditLogTableData(
      id: data.id.present ? data.id.value : this.id,
      entityName:
          data.entityName.present ? data.entityName.value : this.entityName,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      action: data.action.present ? data.action.value : this.action,
      detailsJson:
          data.detailsJson.present ? data.detailsJson.value : this.detailsJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogTableData(')
          ..write('id: $id, ')
          ..write('entityName: $entityName, ')
          ..write('entityId: $entityId, ')
          ..write('action: $action, ')
          ..write('detailsJson: $detailsJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, entityName, entityId, action, detailsJson, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLogTableData &&
          other.id == this.id &&
          other.entityName == this.entityName &&
          other.entityId == this.entityId &&
          other.action == this.action &&
          other.detailsJson == this.detailsJson &&
          other.createdAt == this.createdAt);
}

class AuditLogTableCompanion extends UpdateCompanion<AuditLogTableData> {
  final Value<String> id;
  final Value<String> entityName;
  final Value<String> entityId;
  final Value<String> action;
  final Value<String> detailsJson;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AuditLogTableCompanion({
    this.id = const Value.absent(),
    this.entityName = const Value.absent(),
    this.entityId = const Value.absent(),
    this.action = const Value.absent(),
    this.detailsJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuditLogTableCompanion.insert({
    required String id,
    required String entityName,
    required String entityId,
    required String action,
    required String detailsJson,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        entityName = Value(entityName),
        entityId = Value(entityId),
        action = Value(action),
        detailsJson = Value(detailsJson),
        createdAt = Value(createdAt);
  static Insertable<AuditLogTableData> custom({
    Expression<String>? id,
    Expression<String>? entityName,
    Expression<String>? entityId,
    Expression<String>? action,
    Expression<String>? detailsJson,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityName != null) 'entity_name': entityName,
      if (entityId != null) 'entity_id': entityId,
      if (action != null) 'action': action,
      if (detailsJson != null) 'details_json': detailsJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuditLogTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? entityName,
      Value<String>? entityId,
      Value<String>? action,
      Value<String>? detailsJson,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return AuditLogTableCompanion(
      id: id ?? this.id,
      entityName: entityName ?? this.entityName,
      entityId: entityId ?? this.entityId,
      action: action ?? this.action,
      detailsJson: detailsJson ?? this.detailsJson,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entityName.present) {
      map['entity_name'] = Variable<String>(entityName.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (detailsJson.present) {
      map['details_json'] = Variable<String>(detailsJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogTableCompanion(')
          ..write('id: $id, ')
          ..write('entityName: $entityName, ')
          ..write('entityId: $entityId, ')
          ..write('action: $action, ')
          ..write('detailsJson: $detailsJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ShopSettingsTableTable shopSettingsTable =
      $ShopSettingsTableTable(this);
  late final $CustomersTableTable customersTable = $CustomersTableTable(this);
  late final $VehiclesTableTable vehiclesTable = $VehiclesTableTable(this);
  late final $SlipsTableTable slipsTable = $SlipsTableTable(this);
  late final $SlipRoundsTableTable slipRoundsTable =
      $SlipRoundsTableTable(this);
  late final $PaymentsTableTable paymentsTable = $PaymentsTableTable(this);
  late final $UdharCustomersTableTable udharCustomersTable =
      $UdharCustomersTableTable(this);
  late final $UdharAllocationsTableTable udharAllocationsTable =
      $UdharAllocationsTableTable(this);
  late final $ExpenseCategoriesTableTable expenseCategoriesTable =
      $ExpenseCategoriesTableTable(this);
  late final $ExpensesTableTable expensesTable = $ExpensesTableTable(this);
  late final $SuppliersTableTable suppliersTable = $SuppliersTableTable(this);
  late final $SupplierEntriesTableTable supplierEntriesTable =
      $SupplierEntriesTableTable(this);
  late final $SupplierPaymentsTableTable supplierPaymentsTable =
      $SupplierPaymentsTableTable(this);
  late final $CountersTableTable countersTable = $CountersTableTable(this);
  late final $AuditLogTableTable auditLogTable = $AuditLogTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        shopSettingsTable,
        customersTable,
        vehiclesTable,
        slipsTable,
        slipRoundsTable,
        paymentsTable,
        udharCustomersTable,
        udharAllocationsTable,
        expenseCategoriesTable,
        expensesTable,
        suppliersTable,
        supplierEntriesTable,
        supplierPaymentsTable,
        countersTable,
        auditLogTable
      ];
}

typedef $$ShopSettingsTableTableCreateCompanionBuilder
    = ShopSettingsTableCompanion Function({
  required String id,
  required String shopName,
  required String address,
  required String phones,
  required String capacityText,
  required String recognitionText,
  Value<String?> defaultSlipRates,
  Value<String?> upiId,
  Value<String?> upiQrImagePath,
  Value<String> language,
  Value<bool> lockEnabled,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});
typedef $$ShopSettingsTableTableUpdateCompanionBuilder
    = ShopSettingsTableCompanion Function({
  Value<String> id,
  Value<String> shopName,
  Value<String> address,
  Value<String> phones,
  Value<String> capacityText,
  Value<String> recognitionText,
  Value<String?> defaultSlipRates,
  Value<String?> upiId,
  Value<String?> upiQrImagePath,
  Value<String> language,
  Value<bool> lockEnabled,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});

class $$ShopSettingsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ShopSettingsTableTable,
    ShopSettingsTableData,
    $$ShopSettingsTableTableFilterComposer,
    $$ShopSettingsTableTableOrderingComposer,
    $$ShopSettingsTableTableCreateCompanionBuilder,
    $$ShopSettingsTableTableUpdateCompanionBuilder> {
  $$ShopSettingsTableTableTableManager(
      _$AppDatabase db, $ShopSettingsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ShopSettingsTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$ShopSettingsTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> shopName = const Value.absent(),
            Value<String> address = const Value.absent(),
            Value<String> phones = const Value.absent(),
            Value<String> capacityText = const Value.absent(),
            Value<String> recognitionText = const Value.absent(),
            Value<String?> defaultSlipRates = const Value.absent(),
            Value<String?> upiId = const Value.absent(),
            Value<String?> upiQrImagePath = const Value.absent(),
            Value<String> language = const Value.absent(),
            Value<bool> lockEnabled = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ShopSettingsTableCompanion(
            id: id,
            shopName: shopName,
            address: address,
            phones: phones,
            capacityText: capacityText,
            recognitionText: recognitionText,
            defaultSlipRates: defaultSlipRates,
            upiId: upiId,
            upiQrImagePath: upiQrImagePath,
            language: language,
            lockEnabled: lockEnabled,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String shopName,
            required String address,
            required String phones,
            required String capacityText,
            required String recognitionText,
            Value<String?> defaultSlipRates = const Value.absent(),
            Value<String?> upiId = const Value.absent(),
            Value<String?> upiQrImagePath = const Value.absent(),
            Value<String> language = const Value.absent(),
            Value<bool> lockEnabled = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ShopSettingsTableCompanion.insert(
            id: id,
            shopName: shopName,
            address: address,
            phones: phones,
            capacityText: capacityText,
            recognitionText: recognitionText,
            defaultSlipRates: defaultSlipRates,
            upiId: upiId,
            upiQrImagePath: upiQrImagePath,
            language: language,
            lockEnabled: lockEnabled,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
        ));
}

class $$ShopSettingsTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ShopSettingsTableTable> {
  $$ShopSettingsTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get shopName => $state.composableBuilder(
      column: $state.table.shopName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get address => $state.composableBuilder(
      column: $state.table.address,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get phones => $state.composableBuilder(
      column: $state.table.phones,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get capacityText => $state.composableBuilder(
      column: $state.table.capacityText,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get recognitionText => $state.composableBuilder(
      column: $state.table.recognitionText,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get defaultSlipRates => $state.composableBuilder(
      column: $state.table.defaultSlipRates,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get upiId => $state.composableBuilder(
      column: $state.table.upiId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get upiQrImagePath => $state.composableBuilder(
      column: $state.table.upiQrImagePath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get language => $state.composableBuilder(
      column: $state.table.language,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get lockEnabled => $state.composableBuilder(
      column: $state.table.lockEnabled,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ShopSettingsTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ShopSettingsTableTable> {
  $$ShopSettingsTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get shopName => $state.composableBuilder(
      column: $state.table.shopName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get address => $state.composableBuilder(
      column: $state.table.address,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get phones => $state.composableBuilder(
      column: $state.table.phones,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get capacityText => $state.composableBuilder(
      column: $state.table.capacityText,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get recognitionText => $state.composableBuilder(
      column: $state.table.recognitionText,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get defaultSlipRates => $state.composableBuilder(
      column: $state.table.defaultSlipRates,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get upiId => $state.composableBuilder(
      column: $state.table.upiId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get upiQrImagePath => $state.composableBuilder(
      column: $state.table.upiQrImagePath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get language => $state.composableBuilder(
      column: $state.table.language,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get lockEnabled => $state.composableBuilder(
      column: $state.table.lockEnabled,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$CustomersTableTableCreateCompanionBuilder = CustomersTableCompanion
    Function({
  required String id,
  required String name,
  Value<String?> phone,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});
typedef $$CustomersTableTableUpdateCompanionBuilder = CustomersTableCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String?> phone,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});

class $$CustomersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CustomersTableTable,
    CustomersTableData,
    $$CustomersTableTableFilterComposer,
    $$CustomersTableTableOrderingComposer,
    $$CustomersTableTableCreateCompanionBuilder,
    $$CustomersTableTableUpdateCompanionBuilder> {
  $$CustomersTableTableTableManager(
      _$AppDatabase db, $CustomersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CustomersTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CustomersTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CustomersTableCompanion(
            id: id,
            name: name,
            phone: phone,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> phone = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CustomersTableCompanion.insert(
            id: id,
            name: name,
            phone: phone,
            notes: notes,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
        ));
}

class $$CustomersTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CustomersTableTable> {
  $$CustomersTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get phone => $state.composableBuilder(
      column: $state.table.phone,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$CustomersTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CustomersTableTable> {
  $$CustomersTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get phone => $state.composableBuilder(
      column: $state.table.phone,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get notes => $state.composableBuilder(
      column: $state.table.notes,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$VehiclesTableTableCreateCompanionBuilder = VehiclesTableCompanion
    Function({
  required String id,
  required String number,
  Value<String?> lastCustomerId,
  Value<String?> lastMaterial,
  Value<int?> lastEmptyWeight,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});
typedef $$VehiclesTableTableUpdateCompanionBuilder = VehiclesTableCompanion
    Function({
  Value<String> id,
  Value<String> number,
  Value<String?> lastCustomerId,
  Value<String?> lastMaterial,
  Value<int?> lastEmptyWeight,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});

class $$VehiclesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VehiclesTableTable,
    VehiclesTableData,
    $$VehiclesTableTableFilterComposer,
    $$VehiclesTableTableOrderingComposer,
    $$VehiclesTableTableCreateCompanionBuilder,
    $$VehiclesTableTableUpdateCompanionBuilder> {
  $$VehiclesTableTableTableManager(_$AppDatabase db, $VehiclesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$VehiclesTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$VehiclesTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> number = const Value.absent(),
            Value<String?> lastCustomerId = const Value.absent(),
            Value<String?> lastMaterial = const Value.absent(),
            Value<int?> lastEmptyWeight = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VehiclesTableCompanion(
            id: id,
            number: number,
            lastCustomerId: lastCustomerId,
            lastMaterial: lastMaterial,
            lastEmptyWeight: lastEmptyWeight,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String number,
            Value<String?> lastCustomerId = const Value.absent(),
            Value<String?> lastMaterial = const Value.absent(),
            Value<int?> lastEmptyWeight = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              VehiclesTableCompanion.insert(
            id: id,
            number: number,
            lastCustomerId: lastCustomerId,
            lastMaterial: lastMaterial,
            lastEmptyWeight: lastEmptyWeight,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
        ));
}

class $$VehiclesTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $VehiclesTableTable> {
  $$VehiclesTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get number => $state.composableBuilder(
      column: $state.table.number,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get lastCustomerId => $state.composableBuilder(
      column: $state.table.lastCustomerId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get lastMaterial => $state.composableBuilder(
      column: $state.table.lastMaterial,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get lastEmptyWeight => $state.composableBuilder(
      column: $state.table.lastEmptyWeight,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$VehiclesTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $VehiclesTableTable> {
  $$VehiclesTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get number => $state.composableBuilder(
      column: $state.table.number,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get lastCustomerId => $state.composableBuilder(
      column: $state.table.lastCustomerId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get lastMaterial => $state.composableBuilder(
      column: $state.table.lastMaterial,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get lastEmptyWeight => $state.composableBuilder(
      column: $state.table.lastEmptyWeight,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SlipsTableTableCreateCompanionBuilder = SlipsTableCompanion Function({
  required String id,
  required int receiptNo,
  required DateTime date,
  Value<String?> customerId,
  Value<String?> customerName,
  Value<String?> vehicleNo,
  required int charge,
  required String status,
  Value<String?> paymentMode,
  Value<DateTime?> receivedAt,
  Value<String?> udharCustomerId,
  Value<String?> scanPhotoPath,
  Value<int> reprintCount,
  Value<String?> note,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});
typedef $$SlipsTableTableUpdateCompanionBuilder = SlipsTableCompanion Function({
  Value<String> id,
  Value<int> receiptNo,
  Value<DateTime> date,
  Value<String?> customerId,
  Value<String?> customerName,
  Value<String?> vehicleNo,
  Value<int> charge,
  Value<String> status,
  Value<String?> paymentMode,
  Value<DateTime?> receivedAt,
  Value<String?> udharCustomerId,
  Value<String?> scanPhotoPath,
  Value<int> reprintCount,
  Value<String?> note,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});

class $$SlipsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SlipsTableTable,
    SlipsTableData,
    $$SlipsTableTableFilterComposer,
    $$SlipsTableTableOrderingComposer,
    $$SlipsTableTableCreateCompanionBuilder,
    $$SlipsTableTableUpdateCompanionBuilder> {
  $$SlipsTableTableTableManager(_$AppDatabase db, $SlipsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SlipsTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SlipsTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> receiptNo = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String?> customerId = const Value.absent(),
            Value<String?> customerName = const Value.absent(),
            Value<String?> vehicleNo = const Value.absent(),
            Value<int> charge = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String?> paymentMode = const Value.absent(),
            Value<DateTime?> receivedAt = const Value.absent(),
            Value<String?> udharCustomerId = const Value.absent(),
            Value<String?> scanPhotoPath = const Value.absent(),
            Value<int> reprintCount = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SlipsTableCompanion(
            id: id,
            receiptNo: receiptNo,
            date: date,
            customerId: customerId,
            customerName: customerName,
            vehicleNo: vehicleNo,
            charge: charge,
            status: status,
            paymentMode: paymentMode,
            receivedAt: receivedAt,
            udharCustomerId: udharCustomerId,
            scanPhotoPath: scanPhotoPath,
            reprintCount: reprintCount,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int receiptNo,
            required DateTime date,
            Value<String?> customerId = const Value.absent(),
            Value<String?> customerName = const Value.absent(),
            Value<String?> vehicleNo = const Value.absent(),
            required int charge,
            required String status,
            Value<String?> paymentMode = const Value.absent(),
            Value<DateTime?> receivedAt = const Value.absent(),
            Value<String?> udharCustomerId = const Value.absent(),
            Value<String?> scanPhotoPath = const Value.absent(),
            Value<int> reprintCount = const Value.absent(),
            Value<String?> note = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SlipsTableCompanion.insert(
            id: id,
            receiptNo: receiptNo,
            date: date,
            customerId: customerId,
            customerName: customerName,
            vehicleNo: vehicleNo,
            charge: charge,
            status: status,
            paymentMode: paymentMode,
            receivedAt: receivedAt,
            udharCustomerId: udharCustomerId,
            scanPhotoPath: scanPhotoPath,
            reprintCount: reprintCount,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
        ));
}

class $$SlipsTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SlipsTableTable> {
  $$SlipsTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get receiptNo => $state.composableBuilder(
      column: $state.table.receiptNo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get customerId => $state.composableBuilder(
      column: $state.table.customerId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get customerName => $state.composableBuilder(
      column: $state.table.customerName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get vehicleNo => $state.composableBuilder(
      column: $state.table.vehicleNo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get charge => $state.composableBuilder(
      column: $state.table.charge,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get paymentMode => $state.composableBuilder(
      column: $state.table.paymentMode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get receivedAt => $state.composableBuilder(
      column: $state.table.receivedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get udharCustomerId => $state.composableBuilder(
      column: $state.table.udharCustomerId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get scanPhotoPath => $state.composableBuilder(
      column: $state.table.scanPhotoPath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get reprintCount => $state.composableBuilder(
      column: $state.table.reprintCount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SlipsTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SlipsTableTable> {
  $$SlipsTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get receiptNo => $state.composableBuilder(
      column: $state.table.receiptNo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get customerId => $state.composableBuilder(
      column: $state.table.customerId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get customerName => $state.composableBuilder(
      column: $state.table.customerName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get vehicleNo => $state.composableBuilder(
      column: $state.table.vehicleNo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get charge => $state.composableBuilder(
      column: $state.table.charge,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get paymentMode => $state.composableBuilder(
      column: $state.table.paymentMode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get receivedAt => $state.composableBuilder(
      column: $state.table.receivedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get udharCustomerId => $state.composableBuilder(
      column: $state.table.udharCustomerId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get scanPhotoPath => $state.composableBuilder(
      column: $state.table.scanPhotoPath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get reprintCount => $state.composableBuilder(
      column: $state.table.reprintCount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SlipRoundsTableTableCreateCompanionBuilder = SlipRoundsTableCompanion
    Function({
  required String id,
  required String slipId,
  required int roundNo,
  Value<String?> material,
  Value<String?> extra,
  required int grossKg,
  Value<int?> emptyTulaneKg,
  Value<int?> emptyDriverKg,
  required int netKg,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});
typedef $$SlipRoundsTableTableUpdateCompanionBuilder = SlipRoundsTableCompanion
    Function({
  Value<String> id,
  Value<String> slipId,
  Value<int> roundNo,
  Value<String?> material,
  Value<String?> extra,
  Value<int> grossKg,
  Value<int?> emptyTulaneKg,
  Value<int?> emptyDriverKg,
  Value<int> netKg,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});

class $$SlipRoundsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SlipRoundsTableTable,
    SlipRoundsTableData,
    $$SlipRoundsTableTableFilterComposer,
    $$SlipRoundsTableTableOrderingComposer,
    $$SlipRoundsTableTableCreateCompanionBuilder,
    $$SlipRoundsTableTableUpdateCompanionBuilder> {
  $$SlipRoundsTableTableTableManager(
      _$AppDatabase db, $SlipRoundsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SlipRoundsTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SlipRoundsTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> slipId = const Value.absent(),
            Value<int> roundNo = const Value.absent(),
            Value<String?> material = const Value.absent(),
            Value<String?> extra = const Value.absent(),
            Value<int> grossKg = const Value.absent(),
            Value<int?> emptyTulaneKg = const Value.absent(),
            Value<int?> emptyDriverKg = const Value.absent(),
            Value<int> netKg = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SlipRoundsTableCompanion(
            id: id,
            slipId: slipId,
            roundNo: roundNo,
            material: material,
            extra: extra,
            grossKg: grossKg,
            emptyTulaneKg: emptyTulaneKg,
            emptyDriverKg: emptyDriverKg,
            netKg: netKg,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String slipId,
            required int roundNo,
            Value<String?> material = const Value.absent(),
            Value<String?> extra = const Value.absent(),
            required int grossKg,
            Value<int?> emptyTulaneKg = const Value.absent(),
            Value<int?> emptyDriverKg = const Value.absent(),
            required int netKg,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SlipRoundsTableCompanion.insert(
            id: id,
            slipId: slipId,
            roundNo: roundNo,
            material: material,
            extra: extra,
            grossKg: grossKg,
            emptyTulaneKg: emptyTulaneKg,
            emptyDriverKg: emptyDriverKg,
            netKg: netKg,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
        ));
}

class $$SlipRoundsTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SlipRoundsTableTable> {
  $$SlipRoundsTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get slipId => $state.composableBuilder(
      column: $state.table.slipId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get roundNo => $state.composableBuilder(
      column: $state.table.roundNo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get material => $state.composableBuilder(
      column: $state.table.material,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get extra => $state.composableBuilder(
      column: $state.table.extra,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get grossKg => $state.composableBuilder(
      column: $state.table.grossKg,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get emptyTulaneKg => $state.composableBuilder(
      column: $state.table.emptyTulaneKg,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get emptyDriverKg => $state.composableBuilder(
      column: $state.table.emptyDriverKg,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get netKg => $state.composableBuilder(
      column: $state.table.netKg,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SlipRoundsTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SlipRoundsTableTable> {
  $$SlipRoundsTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get slipId => $state.composableBuilder(
      column: $state.table.slipId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get roundNo => $state.composableBuilder(
      column: $state.table.roundNo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get material => $state.composableBuilder(
      column: $state.table.material,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get extra => $state.composableBuilder(
      column: $state.table.extra,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get grossKg => $state.composableBuilder(
      column: $state.table.grossKg,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get emptyTulaneKg => $state.composableBuilder(
      column: $state.table.emptyTulaneKg,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get emptyDriverKg => $state.composableBuilder(
      column: $state.table.emptyDriverKg,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get netKg => $state.composableBuilder(
      column: $state.table.netKg,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$PaymentsTableTableCreateCompanionBuilder = PaymentsTableCompanion
    Function({
  required String id,
  Value<String?> slipId,
  Value<String?> udharCustomerId,
  required int amount,
  required String mode,
  required DateTime receivedAt,
  required String kind,
  Value<String?> receiptNo,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});
typedef $$PaymentsTableTableUpdateCompanionBuilder = PaymentsTableCompanion
    Function({
  Value<String> id,
  Value<String?> slipId,
  Value<String?> udharCustomerId,
  Value<int> amount,
  Value<String> mode,
  Value<DateTime> receivedAt,
  Value<String> kind,
  Value<String?> receiptNo,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});

class $$PaymentsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PaymentsTableTable,
    PaymentsTableData,
    $$PaymentsTableTableFilterComposer,
    $$PaymentsTableTableOrderingComposer,
    $$PaymentsTableTableCreateCompanionBuilder,
    $$PaymentsTableTableUpdateCompanionBuilder> {
  $$PaymentsTableTableTableManager(_$AppDatabase db, $PaymentsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PaymentsTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PaymentsTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> slipId = const Value.absent(),
            Value<String?> udharCustomerId = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<String> mode = const Value.absent(),
            Value<DateTime> receivedAt = const Value.absent(),
            Value<String> kind = const Value.absent(),
            Value<String?> receiptNo = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PaymentsTableCompanion(
            id: id,
            slipId: slipId,
            udharCustomerId: udharCustomerId,
            amount: amount,
            mode: mode,
            receivedAt: receivedAt,
            kind: kind,
            receiptNo: receiptNo,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> slipId = const Value.absent(),
            Value<String?> udharCustomerId = const Value.absent(),
            required int amount,
            required String mode,
            required DateTime receivedAt,
            required String kind,
            Value<String?> receiptNo = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PaymentsTableCompanion.insert(
            id: id,
            slipId: slipId,
            udharCustomerId: udharCustomerId,
            amount: amount,
            mode: mode,
            receivedAt: receivedAt,
            kind: kind,
            receiptNo: receiptNo,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
        ));
}

class $$PaymentsTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PaymentsTableTable> {
  $$PaymentsTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get slipId => $state.composableBuilder(
      column: $state.table.slipId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get udharCustomerId => $state.composableBuilder(
      column: $state.table.udharCustomerId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get mode => $state.composableBuilder(
      column: $state.table.mode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get receivedAt => $state.composableBuilder(
      column: $state.table.receivedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get kind => $state.composableBuilder(
      column: $state.table.kind,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get receiptNo => $state.composableBuilder(
      column: $state.table.receiptNo,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$PaymentsTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PaymentsTableTable> {
  $$PaymentsTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get slipId => $state.composableBuilder(
      column: $state.table.slipId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get udharCustomerId => $state.composableBuilder(
      column: $state.table.udharCustomerId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get mode => $state.composableBuilder(
      column: $state.table.mode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get receivedAt => $state.composableBuilder(
      column: $state.table.receivedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get kind => $state.composableBuilder(
      column: $state.table.kind,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get receiptNo => $state.composableBuilder(
      column: $state.table.receiptNo,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$UdharCustomersTableTableCreateCompanionBuilder
    = UdharCustomersTableCompanion Function({
  required String id,
  Value<String?> customerId,
  required String name,
  Value<String?> phone,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});
typedef $$UdharCustomersTableTableUpdateCompanionBuilder
    = UdharCustomersTableCompanion Function({
  Value<String> id,
  Value<String?> customerId,
  Value<String> name,
  Value<String?> phone,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});

class $$UdharCustomersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UdharCustomersTableTable,
    UdharCustomersTableData,
    $$UdharCustomersTableTableFilterComposer,
    $$UdharCustomersTableTableOrderingComposer,
    $$UdharCustomersTableTableCreateCompanionBuilder,
    $$UdharCustomersTableTableUpdateCompanionBuilder> {
  $$UdharCustomersTableTableTableManager(
      _$AppDatabase db, $UdharCustomersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$UdharCustomersTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$UdharCustomersTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> customerId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UdharCustomersTableCompanion(
            id: id,
            customerId: customerId,
            name: name,
            phone: phone,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> customerId = const Value.absent(),
            required String name,
            Value<String?> phone = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UdharCustomersTableCompanion.insert(
            id: id,
            customerId: customerId,
            name: name,
            phone: phone,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
        ));
}

class $$UdharCustomersTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $UdharCustomersTableTable> {
  $$UdharCustomersTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get customerId => $state.composableBuilder(
      column: $state.table.customerId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get phone => $state.composableBuilder(
      column: $state.table.phone,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$UdharCustomersTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $UdharCustomersTableTable> {
  $$UdharCustomersTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get customerId => $state.composableBuilder(
      column: $state.table.customerId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get phone => $state.composableBuilder(
      column: $state.table.phone,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$UdharAllocationsTableTableCreateCompanionBuilder
    = UdharAllocationsTableCompanion Function({
  required String id,
  required String paymentId,
  required String slipId,
  required int amountApplied,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});
typedef $$UdharAllocationsTableTableUpdateCompanionBuilder
    = UdharAllocationsTableCompanion Function({
  Value<String> id,
  Value<String> paymentId,
  Value<String> slipId,
  Value<int> amountApplied,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});

class $$UdharAllocationsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UdharAllocationsTableTable,
    UdharAllocationsTableData,
    $$UdharAllocationsTableTableFilterComposer,
    $$UdharAllocationsTableTableOrderingComposer,
    $$UdharAllocationsTableTableCreateCompanionBuilder,
    $$UdharAllocationsTableTableUpdateCompanionBuilder> {
  $$UdharAllocationsTableTableTableManager(
      _$AppDatabase db, $UdharAllocationsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$UdharAllocationsTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$UdharAllocationsTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> paymentId = const Value.absent(),
            Value<String> slipId = const Value.absent(),
            Value<int> amountApplied = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UdharAllocationsTableCompanion(
            id: id,
            paymentId: paymentId,
            slipId: slipId,
            amountApplied: amountApplied,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String paymentId,
            required String slipId,
            required int amountApplied,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UdharAllocationsTableCompanion.insert(
            id: id,
            paymentId: paymentId,
            slipId: slipId,
            amountApplied: amountApplied,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
        ));
}

class $$UdharAllocationsTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $UdharAllocationsTableTable> {
  $$UdharAllocationsTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get paymentId => $state.composableBuilder(
      column: $state.table.paymentId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get slipId => $state.composableBuilder(
      column: $state.table.slipId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get amountApplied => $state.composableBuilder(
      column: $state.table.amountApplied,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$UdharAllocationsTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $UdharAllocationsTableTable> {
  $$UdharAllocationsTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get paymentId => $state.composableBuilder(
      column: $state.table.paymentId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get slipId => $state.composableBuilder(
      column: $state.table.slipId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get amountApplied => $state.composableBuilder(
      column: $state.table.amountApplied,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ExpenseCategoriesTableTableCreateCompanionBuilder
    = ExpenseCategoriesTableCompanion Function({
  required String id,
  required String name,
  Value<String?> colorHex,
  Value<String?> iconName,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});
typedef $$ExpenseCategoriesTableTableUpdateCompanionBuilder
    = ExpenseCategoriesTableCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> colorHex,
  Value<String?> iconName,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});

class $$ExpenseCategoriesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExpenseCategoriesTableTable,
    ExpenseCategoriesTableData,
    $$ExpenseCategoriesTableTableFilterComposer,
    $$ExpenseCategoriesTableTableOrderingComposer,
    $$ExpenseCategoriesTableTableCreateCompanionBuilder,
    $$ExpenseCategoriesTableTableUpdateCompanionBuilder> {
  $$ExpenseCategoriesTableTableTableManager(
      _$AppDatabase db, $ExpenseCategoriesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$ExpenseCategoriesTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$ExpenseCategoriesTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> colorHex = const Value.absent(),
            Value<String?> iconName = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExpenseCategoriesTableCompanion(
            id: id,
            name: name,
            colorHex: colorHex,
            iconName: iconName,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> colorHex = const Value.absent(),
            Value<String?> iconName = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExpenseCategoriesTableCompanion.insert(
            id: id,
            name: name,
            colorHex: colorHex,
            iconName: iconName,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
        ));
}

class $$ExpenseCategoriesTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ExpenseCategoriesTableTable> {
  $$ExpenseCategoriesTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get colorHex => $state.composableBuilder(
      column: $state.table.colorHex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get iconName => $state.composableBuilder(
      column: $state.table.iconName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ExpenseCategoriesTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ExpenseCategoriesTableTable> {
  $$ExpenseCategoriesTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get colorHex => $state.composableBuilder(
      column: $state.table.colorHex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get iconName => $state.composableBuilder(
      column: $state.table.iconName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$ExpensesTableTableCreateCompanionBuilder = ExpensesTableCompanion
    Function({
  required String id,
  required String name,
  required int amount,
  required String mode,
  required DateTime date,
  Value<String?> note,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});
typedef $$ExpensesTableTableUpdateCompanionBuilder = ExpensesTableCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<int> amount,
  Value<String> mode,
  Value<DateTime> date,
  Value<String?> note,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});

class $$ExpensesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExpensesTableTable,
    ExpensesTableData,
    $$ExpensesTableTableFilterComposer,
    $$ExpensesTableTableOrderingComposer,
    $$ExpensesTableTableCreateCompanionBuilder,
    $$ExpensesTableTableUpdateCompanionBuilder> {
  $$ExpensesTableTableTableManager(_$AppDatabase db, $ExpensesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ExpensesTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ExpensesTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<String> mode = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExpensesTableCompanion(
            id: id,
            name: name,
            amount: amount,
            mode: mode,
            date: date,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required int amount,
            required String mode,
            required DateTime date,
            Value<String?> note = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExpensesTableCompanion.insert(
            id: id,
            name: name,
            amount: amount,
            mode: mode,
            date: date,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
        ));
}

class $$ExpensesTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ExpensesTableTable> {
  $$ExpensesTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get mode => $state.composableBuilder(
      column: $state.table.mode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$ExpensesTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ExpensesTableTable> {
  $$ExpensesTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get mode => $state.composableBuilder(
      column: $state.table.mode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SuppliersTableTableCreateCompanionBuilder = SuppliersTableCompanion
    Function({
  required String id,
  required String name,
  Value<String?> category,
  Value<int?> ratePerUnit,
  Value<String?> unitName,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});
typedef $$SuppliersTableTableUpdateCompanionBuilder = SuppliersTableCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String?> category,
  Value<int?> ratePerUnit,
  Value<String?> unitName,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});

class $$SuppliersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SuppliersTableTable,
    SuppliersTableData,
    $$SuppliersTableTableFilterComposer,
    $$SuppliersTableTableOrderingComposer,
    $$SuppliersTableTableCreateCompanionBuilder,
    $$SuppliersTableTableUpdateCompanionBuilder> {
  $$SuppliersTableTableTableManager(
      _$AppDatabase db, $SuppliersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SuppliersTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SuppliersTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<int?> ratePerUnit = const Value.absent(),
            Value<String?> unitName = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SuppliersTableCompanion(
            id: id,
            name: name,
            category: category,
            ratePerUnit: ratePerUnit,
            unitName: unitName,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> category = const Value.absent(),
            Value<int?> ratePerUnit = const Value.absent(),
            Value<String?> unitName = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SuppliersTableCompanion.insert(
            id: id,
            name: name,
            category: category,
            ratePerUnit: ratePerUnit,
            unitName: unitName,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
        ));
}

class $$SuppliersTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SuppliersTableTable> {
  $$SuppliersTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get ratePerUnit => $state.composableBuilder(
      column: $state.table.ratePerUnit,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get unitName => $state.composableBuilder(
      column: $state.table.unitName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SuppliersTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SuppliersTableTable> {
  $$SuppliersTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get category => $state.composableBuilder(
      column: $state.table.category,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get ratePerUnit => $state.composableBuilder(
      column: $state.table.ratePerUnit,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get unitName => $state.composableBuilder(
      column: $state.table.unitName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SupplierEntriesTableTableCreateCompanionBuilder
    = SupplierEntriesTableCompanion Function({
  required String id,
  required String supplierId,
  required DateTime date,
  Value<int?> count,
  required int amount,
  Value<String?> note,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});
typedef $$SupplierEntriesTableTableUpdateCompanionBuilder
    = SupplierEntriesTableCompanion Function({
  Value<String> id,
  Value<String> supplierId,
  Value<DateTime> date,
  Value<int?> count,
  Value<int> amount,
  Value<String?> note,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});

class $$SupplierEntriesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SupplierEntriesTableTable,
    SupplierEntriesTableData,
    $$SupplierEntriesTableTableFilterComposer,
    $$SupplierEntriesTableTableOrderingComposer,
    $$SupplierEntriesTableTableCreateCompanionBuilder,
    $$SupplierEntriesTableTableUpdateCompanionBuilder> {
  $$SupplierEntriesTableTableTableManager(
      _$AppDatabase db, $SupplierEntriesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$SupplierEntriesTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$SupplierEntriesTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> supplierId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int?> count = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SupplierEntriesTableCompanion(
            id: id,
            supplierId: supplierId,
            date: date,
            count: count,
            amount: amount,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String supplierId,
            required DateTime date,
            Value<int?> count = const Value.absent(),
            required int amount,
            Value<String?> note = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SupplierEntriesTableCompanion.insert(
            id: id,
            supplierId: supplierId,
            date: date,
            count: count,
            amount: amount,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
        ));
}

class $$SupplierEntriesTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SupplierEntriesTableTable> {
  $$SupplierEntriesTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get supplierId => $state.composableBuilder(
      column: $state.table.supplierId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get count => $state.composableBuilder(
      column: $state.table.count,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SupplierEntriesTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SupplierEntriesTableTable> {
  $$SupplierEntriesTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get supplierId => $state.composableBuilder(
      column: $state.table.supplierId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get count => $state.composableBuilder(
      column: $state.table.count,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get note => $state.composableBuilder(
      column: $state.table.note,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SupplierPaymentsTableTableCreateCompanionBuilder
    = SupplierPaymentsTableCompanion Function({
  required String id,
  required String supplierId,
  required int amount,
  required String mode,
  required DateTime date,
  Value<String?> expenseId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});
typedef $$SupplierPaymentsTableTableUpdateCompanionBuilder
    = SupplierPaymentsTableCompanion Function({
  Value<String> id,
  Value<String> supplierId,
  Value<int> amount,
  Value<String> mode,
  Value<DateTime> date,
  Value<String?> expenseId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<bool> synced,
  Value<int> rowid,
});

class $$SupplierPaymentsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SupplierPaymentsTableTable,
    SupplierPaymentsTableData,
    $$SupplierPaymentsTableTableFilterComposer,
    $$SupplierPaymentsTableTableOrderingComposer,
    $$SupplierPaymentsTableTableCreateCompanionBuilder,
    $$SupplierPaymentsTableTableUpdateCompanionBuilder> {
  $$SupplierPaymentsTableTableTableManager(
      _$AppDatabase db, $SupplierPaymentsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$SupplierPaymentsTableTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$SupplierPaymentsTableTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> supplierId = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<String> mode = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String?> expenseId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SupplierPaymentsTableCompanion(
            id: id,
            supplierId: supplierId,
            amount: amount,
            mode: mode,
            date: date,
            expenseId: expenseId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String supplierId,
            required int amount,
            required String mode,
            required DateTime date,
            Value<String?> expenseId = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SupplierPaymentsTableCompanion.insert(
            id: id,
            supplierId: supplierId,
            amount: amount,
            mode: mode,
            date: date,
            expenseId: expenseId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            synced: synced,
            rowid: rowid,
          ),
        ));
}

class $$SupplierPaymentsTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SupplierPaymentsTableTable> {
  $$SupplierPaymentsTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get supplierId => $state.composableBuilder(
      column: $state.table.supplierId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get mode => $state.composableBuilder(
      column: $state.table.mode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get expenseId => $state.composableBuilder(
      column: $state.table.expenseId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SupplierPaymentsTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SupplierPaymentsTableTable> {
  $$SupplierPaymentsTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get supplierId => $state.composableBuilder(
      column: $state.table.supplierId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get amount => $state.composableBuilder(
      column: $state.table.amount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get mode => $state.composableBuilder(
      column: $state.table.mode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get expenseId => $state.composableBuilder(
      column: $state.table.expenseId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get deletedAt => $state.composableBuilder(
      column: $state.table.deletedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get synced => $state.composableBuilder(
      column: $state.table.synced,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$CountersTableTableCreateCompanionBuilder = CountersTableCompanion
    Function({
  required String name,
  required int currentValue,
  Value<int> rowid,
});
typedef $$CountersTableTableUpdateCompanionBuilder = CountersTableCompanion
    Function({
  Value<String> name,
  Value<int> currentValue,
  Value<int> rowid,
});

class $$CountersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CountersTableTable,
    CountersTableData,
    $$CountersTableTableFilterComposer,
    $$CountersTableTableOrderingComposer,
    $$CountersTableTableCreateCompanionBuilder,
    $$CountersTableTableUpdateCompanionBuilder> {
  $$CountersTableTableTableManager(_$AppDatabase db, $CountersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CountersTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CountersTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> name = const Value.absent(),
            Value<int> currentValue = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CountersTableCompanion(
            name: name,
            currentValue: currentValue,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String name,
            required int currentValue,
            Value<int> rowid = const Value.absent(),
          }) =>
              CountersTableCompanion.insert(
            name: name,
            currentValue: currentValue,
            rowid: rowid,
          ),
        ));
}

class $$CountersTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $CountersTableTable> {
  $$CountersTableTableFilterComposer(super.$state);
  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get currentValue => $state.composableBuilder(
      column: $state.table.currentValue,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$CountersTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $CountersTableTable> {
  $$CountersTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get currentValue => $state.composableBuilder(
      column: $state.table.currentValue,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$AuditLogTableTableCreateCompanionBuilder = AuditLogTableCompanion
    Function({
  required String id,
  required String entityName,
  required String entityId,
  required String action,
  required String detailsJson,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$AuditLogTableTableUpdateCompanionBuilder = AuditLogTableCompanion
    Function({
  Value<String> id,
  Value<String> entityName,
  Value<String> entityId,
  Value<String> action,
  Value<String> detailsJson,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$AuditLogTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AuditLogTableTable,
    AuditLogTableData,
    $$AuditLogTableTableFilterComposer,
    $$AuditLogTableTableOrderingComposer,
    $$AuditLogTableTableCreateCompanionBuilder,
    $$AuditLogTableTableUpdateCompanionBuilder> {
  $$AuditLogTableTableTableManager(_$AppDatabase db, $AuditLogTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AuditLogTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AuditLogTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> entityName = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<String> action = const Value.absent(),
            Value<String> detailsJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AuditLogTableCompanion(
            id: id,
            entityName: entityName,
            entityId: entityId,
            action: action,
            detailsJson: detailsJson,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String entityName,
            required String entityId,
            required String action,
            required String detailsJson,
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              AuditLogTableCompanion.insert(
            id: id,
            entityName: entityName,
            entityId: entityId,
            action: action,
            detailsJson: detailsJson,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$AuditLogTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AuditLogTableTable> {
  $$AuditLogTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get entityName => $state.composableBuilder(
      column: $state.table.entityName,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get entityId => $state.composableBuilder(
      column: $state.table.entityId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get action => $state.composableBuilder(
      column: $state.table.action,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get detailsJson => $state.composableBuilder(
      column: $state.table.detailsJson,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$AuditLogTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AuditLogTableTable> {
  $$AuditLogTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get entityName => $state.composableBuilder(
      column: $state.table.entityName,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get entityId => $state.composableBuilder(
      column: $state.table.entityId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get action => $state.composableBuilder(
      column: $state.table.action,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get detailsJson => $state.composableBuilder(
      column: $state.table.detailsJson,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ShopSettingsTableTableTableManager get shopSettingsTable =>
      $$ShopSettingsTableTableTableManager(_db, _db.shopSettingsTable);
  $$CustomersTableTableTableManager get customersTable =>
      $$CustomersTableTableTableManager(_db, _db.customersTable);
  $$VehiclesTableTableTableManager get vehiclesTable =>
      $$VehiclesTableTableTableManager(_db, _db.vehiclesTable);
  $$SlipsTableTableTableManager get slipsTable =>
      $$SlipsTableTableTableManager(_db, _db.slipsTable);
  $$SlipRoundsTableTableTableManager get slipRoundsTable =>
      $$SlipRoundsTableTableTableManager(_db, _db.slipRoundsTable);
  $$PaymentsTableTableTableManager get paymentsTable =>
      $$PaymentsTableTableTableManager(_db, _db.paymentsTable);
  $$UdharCustomersTableTableTableManager get udharCustomersTable =>
      $$UdharCustomersTableTableTableManager(_db, _db.udharCustomersTable);
  $$UdharAllocationsTableTableTableManager get udharAllocationsTable =>
      $$UdharAllocationsTableTableTableManager(_db, _db.udharAllocationsTable);
  $$ExpenseCategoriesTableTableTableManager get expenseCategoriesTable =>
      $$ExpenseCategoriesTableTableTableManager(
          _db, _db.expenseCategoriesTable);
  $$ExpensesTableTableTableManager get expensesTable =>
      $$ExpensesTableTableTableManager(_db, _db.expensesTable);
  $$SuppliersTableTableTableManager get suppliersTable =>
      $$SuppliersTableTableTableManager(_db, _db.suppliersTable);
  $$SupplierEntriesTableTableTableManager get supplierEntriesTable =>
      $$SupplierEntriesTableTableTableManager(_db, _db.supplierEntriesTable);
  $$SupplierPaymentsTableTableTableManager get supplierPaymentsTable =>
      $$SupplierPaymentsTableTableTableManager(_db, _db.supplierPaymentsTable);
  $$CountersTableTableTableManager get countersTable =>
      $$CountersTableTableTableManager(_db, _db.countersTable);
  $$AuditLogTableTableTableManager get auditLogTable =>
      $$AuditLogTableTableTableManager(_db, _db.auditLogTable);
}
