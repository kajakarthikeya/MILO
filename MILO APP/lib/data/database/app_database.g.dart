// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfileData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('INR'),
  );
  static const VerificationMeta _distanceUnitMeta = const VerificationMeta(
    'distanceUnit',
  );
  @override
  late final GeneratedColumn<String> distanceUnit = GeneratedColumn<String>(
    'distance_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('km'),
  );
  static const VerificationMeta _themePreferenceMeta = const VerificationMeta(
    'themePreference',
  );
  @override
  late final GeneratedColumn<String> themePreference = GeneratedColumn<String>(
    'theme_preference',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _onboardingCompletedMeta =
      const VerificationMeta('onboardingCompleted');
  @override
  late final GeneratedColumn<bool> onboardingCompleted = GeneratedColumn<bool>(
    'onboarding_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    displayName,
    currencyCode,
    distanceUnit,
    themePreference,
    onboardingCompleted,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfileData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('distance_unit')) {
      context.handle(
        _distanceUnitMeta,
        distanceUnit.isAcceptableOrUnknown(
          data['distance_unit']!,
          _distanceUnitMeta,
        ),
      );
    }
    if (data.containsKey('theme_preference')) {
      context.handle(
        _themePreferenceMeta,
        themePreference.isAcceptableOrUnknown(
          data['theme_preference']!,
          _themePreferenceMeta,
        ),
      );
    }
    if (data.containsKey('onboarding_completed')) {
      context.handle(
        _onboardingCompletedMeta,
        onboardingCompleted.isAcceptableOrUnknown(
          data['onboarding_completed']!,
          _onboardingCompletedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfileData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfileData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      distanceUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}distance_unit'],
      )!,
      themePreference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_preference'],
      )!,
      onboardingCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_completed'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfileData extends DataClass implements Insertable<UserProfileData> {
  final String id;
  final String? displayName;
  final String currencyCode;
  final String distanceUnit;
  final String themePreference;
  final bool onboardingCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserProfileData({
    required this.id,
    this.displayName,
    required this.currencyCode,
    required this.distanceUnit,
    required this.themePreference,
    required this.onboardingCompleted,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    map['currency_code'] = Variable<String>(currencyCode);
    map['distance_unit'] = Variable<String>(distanceUnit);
    map['theme_preference'] = Variable<String>(themePreference);
    map['onboarding_completed'] = Variable<bool>(onboardingCompleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      currencyCode: Value(currencyCode),
      distanceUnit: Value(distanceUnit),
      themePreference: Value(themePreference),
      onboardingCompleted: Value(onboardingCompleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserProfileData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfileData(
      id: serializer.fromJson<String>(json['id']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      distanceUnit: serializer.fromJson<String>(json['distanceUnit']),
      themePreference: serializer.fromJson<String>(json['themePreference']),
      onboardingCompleted: serializer.fromJson<bool>(
        json['onboardingCompleted'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'displayName': serializer.toJson<String?>(displayName),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'distanceUnit': serializer.toJson<String>(distanceUnit),
      'themePreference': serializer.toJson<String>(themePreference),
      'onboardingCompleted': serializer.toJson<bool>(onboardingCompleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserProfileData copyWith({
    String? id,
    Value<String?> displayName = const Value.absent(),
    String? currencyCode,
    String? distanceUnit,
    String? themePreference,
    bool? onboardingCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserProfileData(
    id: id ?? this.id,
    displayName: displayName.present ? displayName.value : this.displayName,
    currencyCode: currencyCode ?? this.currencyCode,
    distanceUnit: distanceUnit ?? this.distanceUnit,
    themePreference: themePreference ?? this.themePreference,
    onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserProfileData copyWithCompanion(UserProfilesCompanion data) {
    return UserProfileData(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      distanceUnit: data.distanceUnit.present
          ? data.distanceUnit.value
          : this.distanceUnit,
      themePreference: data.themePreference.present
          ? data.themePreference.value
          : this.themePreference,
      onboardingCompleted: data.onboardingCompleted.present
          ? data.onboardingCompleted.value
          : this.onboardingCompleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileData(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('distanceUnit: $distanceUnit, ')
          ..write('themePreference: $themePreference, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    displayName,
    currencyCode,
    distanceUnit,
    themePreference,
    onboardingCompleted,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfileData &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.currencyCode == this.currencyCode &&
          other.distanceUnit == this.distanceUnit &&
          other.themePreference == this.themePreference &&
          other.onboardingCompleted == this.onboardingCompleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfileData> {
  final Value<String> id;
  final Value<String?> displayName;
  final Value<String> currencyCode;
  final Value<String> distanceUnit;
  final Value<String> themePreference;
  final Value<bool> onboardingCompleted;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.distanceUnit = const Value.absent(),
    this.themePreference = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    required String id,
    this.displayName = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.distanceUnit = const Value.absent(),
    this.themePreference = const Value.absent(),
    this.onboardingCompleted = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UserProfileData> custom({
    Expression<String>? id,
    Expression<String>? displayName,
    Expression<String>? currencyCode,
    Expression<String>? distanceUnit,
    Expression<String>? themePreference,
    Expression<bool>? onboardingCompleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (distanceUnit != null) 'distance_unit': distanceUnit,
      if (themePreference != null) 'theme_preference': themePreference,
      if (onboardingCompleted != null)
        'onboarding_completed': onboardingCompleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfilesCompanion copyWith({
    Value<String>? id,
    Value<String?>? displayName,
    Value<String>? currencyCode,
    Value<String>? distanceUnit,
    Value<String>? themePreference,
    Value<bool>? onboardingCompleted,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      currencyCode: currencyCode ?? this.currencyCode,
      distanceUnit: distanceUnit ?? this.distanceUnit,
      themePreference: themePreference ?? this.themePreference,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (distanceUnit.present) {
      map['distance_unit'] = Variable<String>(distanceUnit.value);
    }
    if (themePreference.present) {
      map['theme_preference'] = Variable<String>(themePreference.value);
    }
    if (onboardingCompleted.present) {
      map['onboarding_completed'] = Variable<bool>(onboardingCompleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('distanceUnit: $distanceUnit, ')
          ..write('themePreference: $themePreference, ')
          ..write('onboardingCompleted: $onboardingCompleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VehiclesTable extends Vehicles
    with TableInfo<$VehiclesTable, VehicleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nicknameMeta = const VerificationMeta(
    'nickname',
  );
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
    'nickname',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _makeMeta = const VerificationMeta('make');
  @override
  late final GeneratedColumn<String> make = GeneratedColumn<String>(
    'make',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleTypeMeta = const VerificationMeta(
    'vehicleType',
  );
  @override
  late final GeneratedColumn<String> vehicleType = GeneratedColumn<String>(
    'vehicle_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fuelTypeMeta = const VerificationMeta(
    'fuelType',
  );
  @override
  late final GeneratedColumn<String> fuelType = GeneratedColumn<String>(
    'fuel_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _registrationLabelMeta = const VerificationMeta(
    'registrationLabel',
  );
  @override
  late final GeneratedColumn<String> registrationLabel =
      GeneratedColumn<String>(
        'registration_label',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _initialOdometerKmMeta = const VerificationMeta(
    'initialOdometerKm',
  );
  @override
  late final GeneratedColumn<double> initialOdometerKm =
      GeneratedColumn<double>(
        'initial_odometer_km',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _expectedMileageKmPerLitreMeta =
      const VerificationMeta('expectedMileageKmPerLitre');
  @override
  late final GeneratedColumn<double> expectedMileageKmPerLitre =
      GeneratedColumn<double>(
        'expected_mileage_km_per_litre',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _tankCapacityLitresMeta =
      const VerificationMeta('tankCapacityLitres');
  @override
  late final GeneratedColumn<double> tankCapacityLitres =
      GeneratedColumn<double>(
        'tank_capacity_litres',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _purchaseDateMeta = const VerificationMeta(
    'purchaseDate',
  );
  @override
  late final GeneratedColumn<DateTime> purchaseDate = GeneratedColumn<DateTime>(
    'purchase_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nickname,
    make,
    model,
    vehicleType,
    fuelType,
    registrationLabel,
    initialOdometerKm,
    expectedMileageKmPerLitre,
    tankCapacityLitres,
    purchaseDate,
    notes,
    isArchived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicles';
  @override
  VerificationContext validateIntegrity(
    Insertable<VehicleData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nickname')) {
      context.handle(
        _nicknameMeta,
        nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta),
      );
    } else if (isInserting) {
      context.missing(_nicknameMeta);
    }
    if (data.containsKey('make')) {
      context.handle(
        _makeMeta,
        make.isAcceptableOrUnknown(data['make']!, _makeMeta),
      );
    } else if (isInserting) {
      context.missing(_makeMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('vehicle_type')) {
      context.handle(
        _vehicleTypeMeta,
        vehicleType.isAcceptableOrUnknown(
          data['vehicle_type']!,
          _vehicleTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_vehicleTypeMeta);
    }
    if (data.containsKey('fuel_type')) {
      context.handle(
        _fuelTypeMeta,
        fuelType.isAcceptableOrUnknown(data['fuel_type']!, _fuelTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_fuelTypeMeta);
    }
    if (data.containsKey('registration_label')) {
      context.handle(
        _registrationLabelMeta,
        registrationLabel.isAcceptableOrUnknown(
          data['registration_label']!,
          _registrationLabelMeta,
        ),
      );
    }
    if (data.containsKey('initial_odometer_km')) {
      context.handle(
        _initialOdometerKmMeta,
        initialOdometerKm.isAcceptableOrUnknown(
          data['initial_odometer_km']!,
          _initialOdometerKmMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_initialOdometerKmMeta);
    }
    if (data.containsKey('expected_mileage_km_per_litre')) {
      context.handle(
        _expectedMileageKmPerLitreMeta,
        expectedMileageKmPerLitre.isAcceptableOrUnknown(
          data['expected_mileage_km_per_litre']!,
          _expectedMileageKmPerLitreMeta,
        ),
      );
    }
    if (data.containsKey('tank_capacity_litres')) {
      context.handle(
        _tankCapacityLitresMeta,
        tankCapacityLitres.isAcceptableOrUnknown(
          data['tank_capacity_litres']!,
          _tankCapacityLitresMeta,
        ),
      );
    }
    if (data.containsKey('purchase_date')) {
      context.handle(
        _purchaseDateMeta,
        purchaseDate.isAcceptableOrUnknown(
          data['purchase_date']!,
          _purchaseDateMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VehicleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VehicleData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nickname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nickname'],
      )!,
      make: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}make'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      vehicleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_type'],
      )!,
      fuelType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fuel_type'],
      )!,
      registrationLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}registration_label'],
      ),
      initialOdometerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}initial_odometer_km'],
      )!,
      expectedMileageKmPerLitre: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}expected_mileage_km_per_litre'],
      ),
      tankCapacityLitres: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tank_capacity_litres'],
      ),
      purchaseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchase_date'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $VehiclesTable createAlias(String alias) {
    return $VehiclesTable(attachedDatabase, alias);
  }
}

class VehicleData extends DataClass implements Insertable<VehicleData> {
  final String id;
  final String nickname;
  final String make;
  final String model;
  final String vehicleType;
  final String fuelType;
  final String? registrationLabel;
  final double initialOdometerKm;
  final double? expectedMileageKmPerLitre;
  final double? tankCapacityLitres;
  final DateTime? purchaseDate;
  final String? notes;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const VehicleData({
    required this.id,
    required this.nickname,
    required this.make,
    required this.model,
    required this.vehicleType,
    required this.fuelType,
    this.registrationLabel,
    required this.initialOdometerKm,
    this.expectedMileageKmPerLitre,
    this.tankCapacityLitres,
    this.purchaseDate,
    this.notes,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nickname'] = Variable<String>(nickname);
    map['make'] = Variable<String>(make);
    map['model'] = Variable<String>(model);
    map['vehicle_type'] = Variable<String>(vehicleType);
    map['fuel_type'] = Variable<String>(fuelType);
    if (!nullToAbsent || registrationLabel != null) {
      map['registration_label'] = Variable<String>(registrationLabel);
    }
    map['initial_odometer_km'] = Variable<double>(initialOdometerKm);
    if (!nullToAbsent || expectedMileageKmPerLitre != null) {
      map['expected_mileage_km_per_litre'] = Variable<double>(
        expectedMileageKmPerLitre,
      );
    }
    if (!nullToAbsent || tankCapacityLitres != null) {
      map['tank_capacity_litres'] = Variable<double>(tankCapacityLitres);
    }
    if (!nullToAbsent || purchaseDate != null) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  VehiclesCompanion toCompanion(bool nullToAbsent) {
    return VehiclesCompanion(
      id: Value(id),
      nickname: Value(nickname),
      make: Value(make),
      model: Value(model),
      vehicleType: Value(vehicleType),
      fuelType: Value(fuelType),
      registrationLabel: registrationLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(registrationLabel),
      initialOdometerKm: Value(initialOdometerKm),
      expectedMileageKmPerLitre:
          expectedMileageKmPerLitre == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedMileageKmPerLitre),
      tankCapacityLitres: tankCapacityLitres == null && nullToAbsent
          ? const Value.absent()
          : Value(tankCapacityLitres),
      purchaseDate: purchaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory VehicleData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VehicleData(
      id: serializer.fromJson<String>(json['id']),
      nickname: serializer.fromJson<String>(json['nickname']),
      make: serializer.fromJson<String>(json['make']),
      model: serializer.fromJson<String>(json['model']),
      vehicleType: serializer.fromJson<String>(json['vehicleType']),
      fuelType: serializer.fromJson<String>(json['fuelType']),
      registrationLabel: serializer.fromJson<String?>(
        json['registrationLabel'],
      ),
      initialOdometerKm: serializer.fromJson<double>(json['initialOdometerKm']),
      expectedMileageKmPerLitre: serializer.fromJson<double?>(
        json['expectedMileageKmPerLitre'],
      ),
      tankCapacityLitres: serializer.fromJson<double?>(
        json['tankCapacityLitres'],
      ),
      purchaseDate: serializer.fromJson<DateTime?>(json['purchaseDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nickname': serializer.toJson<String>(nickname),
      'make': serializer.toJson<String>(make),
      'model': serializer.toJson<String>(model),
      'vehicleType': serializer.toJson<String>(vehicleType),
      'fuelType': serializer.toJson<String>(fuelType),
      'registrationLabel': serializer.toJson<String?>(registrationLabel),
      'initialOdometerKm': serializer.toJson<double>(initialOdometerKm),
      'expectedMileageKmPerLitre': serializer.toJson<double?>(
        expectedMileageKmPerLitre,
      ),
      'tankCapacityLitres': serializer.toJson<double?>(tankCapacityLitres),
      'purchaseDate': serializer.toJson<DateTime?>(purchaseDate),
      'notes': serializer.toJson<String?>(notes),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  VehicleData copyWith({
    String? id,
    String? nickname,
    String? make,
    String? model,
    String? vehicleType,
    String? fuelType,
    Value<String?> registrationLabel = const Value.absent(),
    double? initialOdometerKm,
    Value<double?> expectedMileageKmPerLitre = const Value.absent(),
    Value<double?> tankCapacityLitres = const Value.absent(),
    Value<DateTime?> purchaseDate = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => VehicleData(
    id: id ?? this.id,
    nickname: nickname ?? this.nickname,
    make: make ?? this.make,
    model: model ?? this.model,
    vehicleType: vehicleType ?? this.vehicleType,
    fuelType: fuelType ?? this.fuelType,
    registrationLabel: registrationLabel.present
        ? registrationLabel.value
        : this.registrationLabel,
    initialOdometerKm: initialOdometerKm ?? this.initialOdometerKm,
    expectedMileageKmPerLitre: expectedMileageKmPerLitre.present
        ? expectedMileageKmPerLitre.value
        : this.expectedMileageKmPerLitre,
    tankCapacityLitres: tankCapacityLitres.present
        ? tankCapacityLitres.value
        : this.tankCapacityLitres,
    purchaseDate: purchaseDate.present ? purchaseDate.value : this.purchaseDate,
    notes: notes.present ? notes.value : this.notes,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  VehicleData copyWithCompanion(VehiclesCompanion data) {
    return VehicleData(
      id: data.id.present ? data.id.value : this.id,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      make: data.make.present ? data.make.value : this.make,
      model: data.model.present ? data.model.value : this.model,
      vehicleType: data.vehicleType.present
          ? data.vehicleType.value
          : this.vehicleType,
      fuelType: data.fuelType.present ? data.fuelType.value : this.fuelType,
      registrationLabel: data.registrationLabel.present
          ? data.registrationLabel.value
          : this.registrationLabel,
      initialOdometerKm: data.initialOdometerKm.present
          ? data.initialOdometerKm.value
          : this.initialOdometerKm,
      expectedMileageKmPerLitre: data.expectedMileageKmPerLitre.present
          ? data.expectedMileageKmPerLitre.value
          : this.expectedMileageKmPerLitre,
      tankCapacityLitres: data.tankCapacityLitres.present
          ? data.tankCapacityLitres.value
          : this.tankCapacityLitres,
      purchaseDate: data.purchaseDate.present
          ? data.purchaseDate.value
          : this.purchaseDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VehicleData(')
          ..write('id: $id, ')
          ..write('nickname: $nickname, ')
          ..write('make: $make, ')
          ..write('model: $model, ')
          ..write('vehicleType: $vehicleType, ')
          ..write('fuelType: $fuelType, ')
          ..write('registrationLabel: $registrationLabel, ')
          ..write('initialOdometerKm: $initialOdometerKm, ')
          ..write('expectedMileageKmPerLitre: $expectedMileageKmPerLitre, ')
          ..write('tankCapacityLitres: $tankCapacityLitres, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('notes: $notes, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nickname,
    make,
    model,
    vehicleType,
    fuelType,
    registrationLabel,
    initialOdometerKm,
    expectedMileageKmPerLitre,
    tankCapacityLitres,
    purchaseDate,
    notes,
    isArchived,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VehicleData &&
          other.id == this.id &&
          other.nickname == this.nickname &&
          other.make == this.make &&
          other.model == this.model &&
          other.vehicleType == this.vehicleType &&
          other.fuelType == this.fuelType &&
          other.registrationLabel == this.registrationLabel &&
          other.initialOdometerKm == this.initialOdometerKm &&
          other.expectedMileageKmPerLitre == this.expectedMileageKmPerLitre &&
          other.tankCapacityLitres == this.tankCapacityLitres &&
          other.purchaseDate == this.purchaseDate &&
          other.notes == this.notes &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class VehiclesCompanion extends UpdateCompanion<VehicleData> {
  final Value<String> id;
  final Value<String> nickname;
  final Value<String> make;
  final Value<String> model;
  final Value<String> vehicleType;
  final Value<String> fuelType;
  final Value<String?> registrationLabel;
  final Value<double> initialOdometerKm;
  final Value<double?> expectedMileageKmPerLitre;
  final Value<double?> tankCapacityLitres;
  final Value<DateTime?> purchaseDate;
  final Value<String?> notes;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const VehiclesCompanion({
    this.id = const Value.absent(),
    this.nickname = const Value.absent(),
    this.make = const Value.absent(),
    this.model = const Value.absent(),
    this.vehicleType = const Value.absent(),
    this.fuelType = const Value.absent(),
    this.registrationLabel = const Value.absent(),
    this.initialOdometerKm = const Value.absent(),
    this.expectedMileageKmPerLitre = const Value.absent(),
    this.tankCapacityLitres = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VehiclesCompanion.insert({
    required String id,
    required String nickname,
    required String make,
    required String model,
    required String vehicleType,
    required String fuelType,
    this.registrationLabel = const Value.absent(),
    required double initialOdometerKm,
    this.expectedMileageKmPerLitre = const Value.absent(),
    this.tankCapacityLitres = const Value.absent(),
    this.purchaseDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.isArchived = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nickname = Value(nickname),
       make = Value(make),
       model = Value(model),
       vehicleType = Value(vehicleType),
       fuelType = Value(fuelType),
       initialOdometerKm = Value(initialOdometerKm),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<VehicleData> custom({
    Expression<String>? id,
    Expression<String>? nickname,
    Expression<String>? make,
    Expression<String>? model,
    Expression<String>? vehicleType,
    Expression<String>? fuelType,
    Expression<String>? registrationLabel,
    Expression<double>? initialOdometerKm,
    Expression<double>? expectedMileageKmPerLitre,
    Expression<double>? tankCapacityLitres,
    Expression<DateTime>? purchaseDate,
    Expression<String>? notes,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nickname != null) 'nickname': nickname,
      if (make != null) 'make': make,
      if (model != null) 'model': model,
      if (vehicleType != null) 'vehicle_type': vehicleType,
      if (fuelType != null) 'fuel_type': fuelType,
      if (registrationLabel != null) 'registration_label': registrationLabel,
      if (initialOdometerKm != null) 'initial_odometer_km': initialOdometerKm,
      if (expectedMileageKmPerLitre != null)
        'expected_mileage_km_per_litre': expectedMileageKmPerLitre,
      if (tankCapacityLitres != null)
        'tank_capacity_litres': tankCapacityLitres,
      if (purchaseDate != null) 'purchase_date': purchaseDate,
      if (notes != null) 'notes': notes,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VehiclesCompanion copyWith({
    Value<String>? id,
    Value<String>? nickname,
    Value<String>? make,
    Value<String>? model,
    Value<String>? vehicleType,
    Value<String>? fuelType,
    Value<String?>? registrationLabel,
    Value<double>? initialOdometerKm,
    Value<double?>? expectedMileageKmPerLitre,
    Value<double?>? tankCapacityLitres,
    Value<DateTime?>? purchaseDate,
    Value<String?>? notes,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return VehiclesCompanion(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      make: make ?? this.make,
      model: model ?? this.model,
      vehicleType: vehicleType ?? this.vehicleType,
      fuelType: fuelType ?? this.fuelType,
      registrationLabel: registrationLabel ?? this.registrationLabel,
      initialOdometerKm: initialOdometerKm ?? this.initialOdometerKm,
      expectedMileageKmPerLitre:
          expectedMileageKmPerLitre ?? this.expectedMileageKmPerLitre,
      tankCapacityLitres: tankCapacityLitres ?? this.tankCapacityLitres,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      notes: notes ?? this.notes,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (make.present) {
      map['make'] = Variable<String>(make.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (vehicleType.present) {
      map['vehicle_type'] = Variable<String>(vehicleType.value);
    }
    if (fuelType.present) {
      map['fuel_type'] = Variable<String>(fuelType.value);
    }
    if (registrationLabel.present) {
      map['registration_label'] = Variable<String>(registrationLabel.value);
    }
    if (initialOdometerKm.present) {
      map['initial_odometer_km'] = Variable<double>(initialOdometerKm.value);
    }
    if (expectedMileageKmPerLitre.present) {
      map['expected_mileage_km_per_litre'] = Variable<double>(
        expectedMileageKmPerLitre.value,
      );
    }
    if (tankCapacityLitres.present) {
      map['tank_capacity_litres'] = Variable<double>(tankCapacityLitres.value);
    }
    if (purchaseDate.present) {
      map['purchase_date'] = Variable<DateTime>(purchaseDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesCompanion(')
          ..write('id: $id, ')
          ..write('nickname: $nickname, ')
          ..write('make: $make, ')
          ..write('model: $model, ')
          ..write('vehicleType: $vehicleType, ')
          ..write('fuelType: $fuelType, ')
          ..write('registrationLabel: $registrationLabel, ')
          ..write('initialOdometerKm: $initialOdometerKm, ')
          ..write('expectedMileageKmPerLitre: $expectedMileageKmPerLitre, ')
          ..write('tankCapacityLitres: $tankCapacityLitres, ')
          ..write('purchaseDate: $purchaseDate, ')
          ..write('notes: $notes, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FuelEntriesTable extends FuelEntries
    with TableInfo<$FuelEntriesTable, FuelEntryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FuelEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerKmMeta = const VerificationMeta(
    'odometerKm',
  );
  @override
  late final GeneratedColumn<double> odometerKm = GeneratedColumn<double>(
    'odometer_km',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountPaidMinorUnitsMeta =
      const VerificationMeta('amountPaidMinorUnits');
  @override
  late final GeneratedColumn<int> amountPaidMinorUnits = GeneratedColumn<int>(
    'amount_paid_minor_units',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fuelQuantityMeta = const VerificationMeta(
    'fuelQuantity',
  );
  @override
  late final GeneratedColumn<double> fuelQuantity = GeneratedColumn<double>(
    'fuel_quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMinorUnitsPerLitreMeta =
      const VerificationMeta('unitPriceMinorUnitsPerLitre');
  @override
  late final GeneratedColumn<int> unitPriceMinorUnitsPerLitre =
      GeneratedColumn<int>(
        'unit_price_minor_units_per_litre',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _entryMethodMeta = const VerificationMeta(
    'entryMethod',
  );
  @override
  late final GeneratedColumn<String> entryMethod = GeneratedColumn<String>(
    'entry_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fillTypeMeta = const VerificationMeta(
    'fillType',
  );
  @override
  late final GeneratedColumn<String> fillType = GeneratedColumn<String>(
    'fill_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stationNameMeta = const VerificationMeta(
    'stationName',
  );
  @override
  late final GeneratedColumn<String> stationName = GeneratedColumn<String>(
    'station_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    timestamp,
    odometerKm,
    amountPaidMinorUnits,
    fuelQuantity,
    unitPriceMinorUnitsPerLitre,
    entryMethod,
    fillType,
    stationName,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fuel_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<FuelEntryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('odometer_km')) {
      context.handle(
        _odometerKmMeta,
        odometerKm.isAcceptableOrUnknown(data['odometer_km']!, _odometerKmMeta),
      );
    } else if (isInserting) {
      context.missing(_odometerKmMeta);
    }
    if (data.containsKey('amount_paid_minor_units')) {
      context.handle(
        _amountPaidMinorUnitsMeta,
        amountPaidMinorUnits.isAcceptableOrUnknown(
          data['amount_paid_minor_units']!,
          _amountPaidMinorUnitsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountPaidMinorUnitsMeta);
    }
    if (data.containsKey('fuel_quantity')) {
      context.handle(
        _fuelQuantityMeta,
        fuelQuantity.isAcceptableOrUnknown(
          data['fuel_quantity']!,
          _fuelQuantityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fuelQuantityMeta);
    }
    if (data.containsKey('unit_price_minor_units_per_litre')) {
      context.handle(
        _unitPriceMinorUnitsPerLitreMeta,
        unitPriceMinorUnitsPerLitre.isAcceptableOrUnknown(
          data['unit_price_minor_units_per_litre']!,
          _unitPriceMinorUnitsPerLitreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMinorUnitsPerLitreMeta);
    }
    if (data.containsKey('entry_method')) {
      context.handle(
        _entryMethodMeta,
        entryMethod.isAcceptableOrUnknown(
          data['entry_method']!,
          _entryMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_entryMethodMeta);
    }
    if (data.containsKey('fill_type')) {
      context.handle(
        _fillTypeMeta,
        fillType.isAcceptableOrUnknown(data['fill_type']!, _fillTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_fillTypeMeta);
    }
    if (data.containsKey('station_name')) {
      context.handle(
        _stationNameMeta,
        stationName.isAcceptableOrUnknown(
          data['station_name']!,
          _stationNameMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FuelEntryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FuelEntryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      odometerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}odometer_km'],
      )!,
      amountPaidMinorUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_paid_minor_units'],
      )!,
      fuelQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fuel_quantity'],
      )!,
      unitPriceMinorUnitsPerLitre: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_price_minor_units_per_litre'],
      )!,
      entryMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_method'],
      )!,
      fillType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fill_type'],
      )!,
      stationName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}station_name'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FuelEntriesTable createAlias(String alias) {
    return $FuelEntriesTable(attachedDatabase, alias);
  }
}

class FuelEntryData extends DataClass implements Insertable<FuelEntryData> {
  final String id;
  final String vehicleId;
  final DateTime timestamp;
  final double odometerKm;
  final int amountPaidMinorUnits;
  final double fuelQuantity;
  final int unitPriceMinorUnitsPerLitre;
  final String entryMethod;
  final String fillType;
  final String? stationName;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FuelEntryData({
    required this.id,
    required this.vehicleId,
    required this.timestamp,
    required this.odometerKm,
    required this.amountPaidMinorUnits,
    required this.fuelQuantity,
    required this.unitPriceMinorUnitsPerLitre,
    required this.entryMethod,
    required this.fillType,
    this.stationName,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['odometer_km'] = Variable<double>(odometerKm);
    map['amount_paid_minor_units'] = Variable<int>(amountPaidMinorUnits);
    map['fuel_quantity'] = Variable<double>(fuelQuantity);
    map['unit_price_minor_units_per_litre'] = Variable<int>(
      unitPriceMinorUnitsPerLitre,
    );
    map['entry_method'] = Variable<String>(entryMethod);
    map['fill_type'] = Variable<String>(fillType);
    if (!nullToAbsent || stationName != null) {
      map['station_name'] = Variable<String>(stationName);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FuelEntriesCompanion toCompanion(bool nullToAbsent) {
    return FuelEntriesCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      timestamp: Value(timestamp),
      odometerKm: Value(odometerKm),
      amountPaidMinorUnits: Value(amountPaidMinorUnits),
      fuelQuantity: Value(fuelQuantity),
      unitPriceMinorUnitsPerLitre: Value(unitPriceMinorUnitsPerLitre),
      entryMethod: Value(entryMethod),
      fillType: Value(fillType),
      stationName: stationName == null && nullToAbsent
          ? const Value.absent()
          : Value(stationName),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FuelEntryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FuelEntryData(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      odometerKm: serializer.fromJson<double>(json['odometerKm']),
      amountPaidMinorUnits: serializer.fromJson<int>(
        json['amountPaidMinorUnits'],
      ),
      fuelQuantity: serializer.fromJson<double>(json['fuelQuantity']),
      unitPriceMinorUnitsPerLitre: serializer.fromJson<int>(
        json['unitPriceMinorUnitsPerLitre'],
      ),
      entryMethod: serializer.fromJson<String>(json['entryMethod']),
      fillType: serializer.fromJson<String>(json['fillType']),
      stationName: serializer.fromJson<String?>(json['stationName']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'odometerKm': serializer.toJson<double>(odometerKm),
      'amountPaidMinorUnits': serializer.toJson<int>(amountPaidMinorUnits),
      'fuelQuantity': serializer.toJson<double>(fuelQuantity),
      'unitPriceMinorUnitsPerLitre': serializer.toJson<int>(
        unitPriceMinorUnitsPerLitre,
      ),
      'entryMethod': serializer.toJson<String>(entryMethod),
      'fillType': serializer.toJson<String>(fillType),
      'stationName': serializer.toJson<String?>(stationName),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FuelEntryData copyWith({
    String? id,
    String? vehicleId,
    DateTime? timestamp,
    double? odometerKm,
    int? amountPaidMinorUnits,
    double? fuelQuantity,
    int? unitPriceMinorUnitsPerLitre,
    String? entryMethod,
    String? fillType,
    Value<String?> stationName = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FuelEntryData(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    timestamp: timestamp ?? this.timestamp,
    odometerKm: odometerKm ?? this.odometerKm,
    amountPaidMinorUnits: amountPaidMinorUnits ?? this.amountPaidMinorUnits,
    fuelQuantity: fuelQuantity ?? this.fuelQuantity,
    unitPriceMinorUnitsPerLitre:
        unitPriceMinorUnitsPerLitre ?? this.unitPriceMinorUnitsPerLitre,
    entryMethod: entryMethod ?? this.entryMethod,
    fillType: fillType ?? this.fillType,
    stationName: stationName.present ? stationName.value : this.stationName,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FuelEntryData copyWithCompanion(FuelEntriesCompanion data) {
    return FuelEntryData(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      odometerKm: data.odometerKm.present
          ? data.odometerKm.value
          : this.odometerKm,
      amountPaidMinorUnits: data.amountPaidMinorUnits.present
          ? data.amountPaidMinorUnits.value
          : this.amountPaidMinorUnits,
      fuelQuantity: data.fuelQuantity.present
          ? data.fuelQuantity.value
          : this.fuelQuantity,
      unitPriceMinorUnitsPerLitre: data.unitPriceMinorUnitsPerLitre.present
          ? data.unitPriceMinorUnitsPerLitre.value
          : this.unitPriceMinorUnitsPerLitre,
      entryMethod: data.entryMethod.present
          ? data.entryMethod.value
          : this.entryMethod,
      fillType: data.fillType.present ? data.fillType.value : this.fillType,
      stationName: data.stationName.present
          ? data.stationName.value
          : this.stationName,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FuelEntryData(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('timestamp: $timestamp, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('amountPaidMinorUnits: $amountPaidMinorUnits, ')
          ..write('fuelQuantity: $fuelQuantity, ')
          ..write('unitPriceMinorUnitsPerLitre: $unitPriceMinorUnitsPerLitre, ')
          ..write('entryMethod: $entryMethod, ')
          ..write('fillType: $fillType, ')
          ..write('stationName: $stationName, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    timestamp,
    odometerKm,
    amountPaidMinorUnits,
    fuelQuantity,
    unitPriceMinorUnitsPerLitre,
    entryMethod,
    fillType,
    stationName,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FuelEntryData &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.timestamp == this.timestamp &&
          other.odometerKm == this.odometerKm &&
          other.amountPaidMinorUnits == this.amountPaidMinorUnits &&
          other.fuelQuantity == this.fuelQuantity &&
          other.unitPriceMinorUnitsPerLitre ==
              this.unitPriceMinorUnitsPerLitre &&
          other.entryMethod == this.entryMethod &&
          other.fillType == this.fillType &&
          other.stationName == this.stationName &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FuelEntriesCompanion extends UpdateCompanion<FuelEntryData> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<DateTime> timestamp;
  final Value<double> odometerKm;
  final Value<int> amountPaidMinorUnits;
  final Value<double> fuelQuantity;
  final Value<int> unitPriceMinorUnitsPerLitre;
  final Value<String> entryMethod;
  final Value<String> fillType;
  final Value<String?> stationName;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FuelEntriesCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.odometerKm = const Value.absent(),
    this.amountPaidMinorUnits = const Value.absent(),
    this.fuelQuantity = const Value.absent(),
    this.unitPriceMinorUnitsPerLitre = const Value.absent(),
    this.entryMethod = const Value.absent(),
    this.fillType = const Value.absent(),
    this.stationName = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FuelEntriesCompanion.insert({
    required String id,
    required String vehicleId,
    required DateTime timestamp,
    required double odometerKm,
    required int amountPaidMinorUnits,
    required double fuelQuantity,
    required int unitPriceMinorUnitsPerLitre,
    required String entryMethod,
    required String fillType,
    this.stationName = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehicleId = Value(vehicleId),
       timestamp = Value(timestamp),
       odometerKm = Value(odometerKm),
       amountPaidMinorUnits = Value(amountPaidMinorUnits),
       fuelQuantity = Value(fuelQuantity),
       unitPriceMinorUnitsPerLitre = Value(unitPriceMinorUnitsPerLitre),
       entryMethod = Value(entryMethod),
       fillType = Value(fillType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FuelEntryData> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<DateTime>? timestamp,
    Expression<double>? odometerKm,
    Expression<int>? amountPaidMinorUnits,
    Expression<double>? fuelQuantity,
    Expression<int>? unitPriceMinorUnitsPerLitre,
    Expression<String>? entryMethod,
    Expression<String>? fillType,
    Expression<String>? stationName,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (timestamp != null) 'timestamp': timestamp,
      if (odometerKm != null) 'odometer_km': odometerKm,
      if (amountPaidMinorUnits != null)
        'amount_paid_minor_units': amountPaidMinorUnits,
      if (fuelQuantity != null) 'fuel_quantity': fuelQuantity,
      if (unitPriceMinorUnitsPerLitre != null)
        'unit_price_minor_units_per_litre': unitPriceMinorUnitsPerLitre,
      if (entryMethod != null) 'entry_method': entryMethod,
      if (fillType != null) 'fill_type': fillType,
      if (stationName != null) 'station_name': stationName,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FuelEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? vehicleId,
    Value<DateTime>? timestamp,
    Value<double>? odometerKm,
    Value<int>? amountPaidMinorUnits,
    Value<double>? fuelQuantity,
    Value<int>? unitPriceMinorUnitsPerLitre,
    Value<String>? entryMethod,
    Value<String>? fillType,
    Value<String?>? stationName,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FuelEntriesCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      timestamp: timestamp ?? this.timestamp,
      odometerKm: odometerKm ?? this.odometerKm,
      amountPaidMinorUnits: amountPaidMinorUnits ?? this.amountPaidMinorUnits,
      fuelQuantity: fuelQuantity ?? this.fuelQuantity,
      unitPriceMinorUnitsPerLitre:
          unitPriceMinorUnitsPerLitre ?? this.unitPriceMinorUnitsPerLitre,
      entryMethod: entryMethod ?? this.entryMethod,
      fillType: fillType ?? this.fillType,
      stationName: stationName ?? this.stationName,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (odometerKm.present) {
      map['odometer_km'] = Variable<double>(odometerKm.value);
    }
    if (amountPaidMinorUnits.present) {
      map['amount_paid_minor_units'] = Variable<int>(
        amountPaidMinorUnits.value,
      );
    }
    if (fuelQuantity.present) {
      map['fuel_quantity'] = Variable<double>(fuelQuantity.value);
    }
    if (unitPriceMinorUnitsPerLitre.present) {
      map['unit_price_minor_units_per_litre'] = Variable<int>(
        unitPriceMinorUnitsPerLitre.value,
      );
    }
    if (entryMethod.present) {
      map['entry_method'] = Variable<String>(entryMethod.value);
    }
    if (fillType.present) {
      map['fill_type'] = Variable<String>(fillType.value);
    }
    if (stationName.present) {
      map['station_name'] = Variable<String>(stationName.value);
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FuelEntriesCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('timestamp: $timestamp, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('amountPaidMinorUnits: $amountPaidMinorUnits, ')
          ..write('fuelQuantity: $fuelQuantity, ')
          ..write('unitPriceMinorUnitsPerLitre: $unitPriceMinorUnitsPerLitre, ')
          ..write('entryMethod: $entryMethod, ')
          ..write('fillType: $fillType, ')
          ..write('stationName: $stationName, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MileageIntervalsTable extends MileageIntervals
    with TableInfo<$MileageIntervalsTable, MileageIntervalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MileageIntervalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _startFuelEntryIdMeta = const VerificationMeta(
    'startFuelEntryId',
  );
  @override
  late final GeneratedColumn<String> startFuelEntryId = GeneratedColumn<String>(
    'start_fuel_entry_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fuel_entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _endFuelEntryIdMeta = const VerificationMeta(
    'endFuelEntryId',
  );
  @override
  late final GeneratedColumn<String> endFuelEntryId = GeneratedColumn<String>(
    'end_fuel_entry_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES fuel_entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _startOdometerKmMeta = const VerificationMeta(
    'startOdometerKm',
  );
  @override
  late final GeneratedColumn<double> startOdometerKm = GeneratedColumn<double>(
    'start_odometer_km',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endOdometerKmMeta = const VerificationMeta(
    'endOdometerKm',
  );
  @override
  late final GeneratedColumn<double> endOdometerKm = GeneratedColumn<double>(
    'end_odometer_km',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _distanceKmMeta = const VerificationMeta(
    'distanceKm',
  );
  @override
  late final GeneratedColumn<double> distanceKm = GeneratedColumn<double>(
    'distance_km',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fuelConsumedLitresMeta =
      const VerificationMeta('fuelConsumedLitres');
  @override
  late final GeneratedColumn<double> fuelConsumedLitres =
      GeneratedColumn<double>(
        'fuel_consumed_litres',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _mileageKmPerLitreMeta = const VerificationMeta(
    'mileageKmPerLitre',
  );
  @override
  late final GeneratedColumn<double> mileageKmPerLitre =
      GeneratedColumn<double>(
        'mileage_km_per_litre',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _fuelCostMinorUnitsMeta =
      const VerificationMeta('fuelCostMinorUnits');
  @override
  late final GeneratedColumn<int> fuelCostMinorUnits = GeneratedColumn<int>(
    'fuel_cost_minor_units',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _calculationVersionMeta =
      const VerificationMeta('calculationVersion');
  @override
  late final GeneratedColumn<int> calculationVersion = GeneratedColumn<int>(
    'calculation_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _calculatedAtMeta = const VerificationMeta(
    'calculatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> calculatedAt = GeneratedColumn<DateTime>(
    'calculated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    startFuelEntryId,
    endFuelEntryId,
    startOdometerKm,
    endOdometerKm,
    distanceKm,
    fuelConsumedLitres,
    mileageKmPerLitre,
    fuelCostMinorUnits,
    calculationVersion,
    calculatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mileage_intervals';
  @override
  VerificationContext validateIntegrity(
    Insertable<MileageIntervalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('start_fuel_entry_id')) {
      context.handle(
        _startFuelEntryIdMeta,
        startFuelEntryId.isAcceptableOrUnknown(
          data['start_fuel_entry_id']!,
          _startFuelEntryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startFuelEntryIdMeta);
    }
    if (data.containsKey('end_fuel_entry_id')) {
      context.handle(
        _endFuelEntryIdMeta,
        endFuelEntryId.isAcceptableOrUnknown(
          data['end_fuel_entry_id']!,
          _endFuelEntryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_endFuelEntryIdMeta);
    }
    if (data.containsKey('start_odometer_km')) {
      context.handle(
        _startOdometerKmMeta,
        startOdometerKm.isAcceptableOrUnknown(
          data['start_odometer_km']!,
          _startOdometerKmMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startOdometerKmMeta);
    }
    if (data.containsKey('end_odometer_km')) {
      context.handle(
        _endOdometerKmMeta,
        endOdometerKm.isAcceptableOrUnknown(
          data['end_odometer_km']!,
          _endOdometerKmMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_endOdometerKmMeta);
    }
    if (data.containsKey('distance_km')) {
      context.handle(
        _distanceKmMeta,
        distanceKm.isAcceptableOrUnknown(data['distance_km']!, _distanceKmMeta),
      );
    } else if (isInserting) {
      context.missing(_distanceKmMeta);
    }
    if (data.containsKey('fuel_consumed_litres')) {
      context.handle(
        _fuelConsumedLitresMeta,
        fuelConsumedLitres.isAcceptableOrUnknown(
          data['fuel_consumed_litres']!,
          _fuelConsumedLitresMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fuelConsumedLitresMeta);
    }
    if (data.containsKey('mileage_km_per_litre')) {
      context.handle(
        _mileageKmPerLitreMeta,
        mileageKmPerLitre.isAcceptableOrUnknown(
          data['mileage_km_per_litre']!,
          _mileageKmPerLitreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mileageKmPerLitreMeta);
    }
    if (data.containsKey('fuel_cost_minor_units')) {
      context.handle(
        _fuelCostMinorUnitsMeta,
        fuelCostMinorUnits.isAcceptableOrUnknown(
          data['fuel_cost_minor_units']!,
          _fuelCostMinorUnitsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fuelCostMinorUnitsMeta);
    }
    if (data.containsKey('calculation_version')) {
      context.handle(
        _calculationVersionMeta,
        calculationVersion.isAcceptableOrUnknown(
          data['calculation_version']!,
          _calculationVersionMeta,
        ),
      );
    }
    if (data.containsKey('calculated_at')) {
      context.handle(
        _calculatedAtMeta,
        calculatedAt.isAcceptableOrUnknown(
          data['calculated_at']!,
          _calculatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_calculatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MileageIntervalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MileageIntervalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      startFuelEntryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_fuel_entry_id'],
      )!,
      endFuelEntryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_fuel_entry_id'],
      )!,
      startOdometerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}start_odometer_km'],
      )!,
      endOdometerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}end_odometer_km'],
      )!,
      distanceKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance_km'],
      )!,
      fuelConsumedLitres: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fuel_consumed_litres'],
      )!,
      mileageKmPerLitre: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mileage_km_per_litre'],
      )!,
      fuelCostMinorUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fuel_cost_minor_units'],
      )!,
      calculationVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calculation_version'],
      )!,
      calculatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}calculated_at'],
      )!,
    );
  }

  @override
  $MileageIntervalsTable createAlias(String alias) {
    return $MileageIntervalsTable(attachedDatabase, alias);
  }
}

class MileageIntervalData extends DataClass
    implements Insertable<MileageIntervalData> {
  final String id;
  final String vehicleId;
  final String startFuelEntryId;
  final String endFuelEntryId;
  final double startOdometerKm;
  final double endOdometerKm;
  final double distanceKm;
  final double fuelConsumedLitres;
  final double mileageKmPerLitre;
  final int fuelCostMinorUnits;
  final int calculationVersion;
  final DateTime calculatedAt;
  const MileageIntervalData({
    required this.id,
    required this.vehicleId,
    required this.startFuelEntryId,
    required this.endFuelEntryId,
    required this.startOdometerKm,
    required this.endOdometerKm,
    required this.distanceKm,
    required this.fuelConsumedLitres,
    required this.mileageKmPerLitre,
    required this.fuelCostMinorUnits,
    required this.calculationVersion,
    required this.calculatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['start_fuel_entry_id'] = Variable<String>(startFuelEntryId);
    map['end_fuel_entry_id'] = Variable<String>(endFuelEntryId);
    map['start_odometer_km'] = Variable<double>(startOdometerKm);
    map['end_odometer_km'] = Variable<double>(endOdometerKm);
    map['distance_km'] = Variable<double>(distanceKm);
    map['fuel_consumed_litres'] = Variable<double>(fuelConsumedLitres);
    map['mileage_km_per_litre'] = Variable<double>(mileageKmPerLitre);
    map['fuel_cost_minor_units'] = Variable<int>(fuelCostMinorUnits);
    map['calculation_version'] = Variable<int>(calculationVersion);
    map['calculated_at'] = Variable<DateTime>(calculatedAt);
    return map;
  }

  MileageIntervalsCompanion toCompanion(bool nullToAbsent) {
    return MileageIntervalsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      startFuelEntryId: Value(startFuelEntryId),
      endFuelEntryId: Value(endFuelEntryId),
      startOdometerKm: Value(startOdometerKm),
      endOdometerKm: Value(endOdometerKm),
      distanceKm: Value(distanceKm),
      fuelConsumedLitres: Value(fuelConsumedLitres),
      mileageKmPerLitre: Value(mileageKmPerLitre),
      fuelCostMinorUnits: Value(fuelCostMinorUnits),
      calculationVersion: Value(calculationVersion),
      calculatedAt: Value(calculatedAt),
    );
  }

  factory MileageIntervalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MileageIntervalData(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      startFuelEntryId: serializer.fromJson<String>(json['startFuelEntryId']),
      endFuelEntryId: serializer.fromJson<String>(json['endFuelEntryId']),
      startOdometerKm: serializer.fromJson<double>(json['startOdometerKm']),
      endOdometerKm: serializer.fromJson<double>(json['endOdometerKm']),
      distanceKm: serializer.fromJson<double>(json['distanceKm']),
      fuelConsumedLitres: serializer.fromJson<double>(
        json['fuelConsumedLitres'],
      ),
      mileageKmPerLitre: serializer.fromJson<double>(json['mileageKmPerLitre']),
      fuelCostMinorUnits: serializer.fromJson<int>(json['fuelCostMinorUnits']),
      calculationVersion: serializer.fromJson<int>(json['calculationVersion']),
      calculatedAt: serializer.fromJson<DateTime>(json['calculatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'startFuelEntryId': serializer.toJson<String>(startFuelEntryId),
      'endFuelEntryId': serializer.toJson<String>(endFuelEntryId),
      'startOdometerKm': serializer.toJson<double>(startOdometerKm),
      'endOdometerKm': serializer.toJson<double>(endOdometerKm),
      'distanceKm': serializer.toJson<double>(distanceKm),
      'fuelConsumedLitres': serializer.toJson<double>(fuelConsumedLitres),
      'mileageKmPerLitre': serializer.toJson<double>(mileageKmPerLitre),
      'fuelCostMinorUnits': serializer.toJson<int>(fuelCostMinorUnits),
      'calculationVersion': serializer.toJson<int>(calculationVersion),
      'calculatedAt': serializer.toJson<DateTime>(calculatedAt),
    };
  }

  MileageIntervalData copyWith({
    String? id,
    String? vehicleId,
    String? startFuelEntryId,
    String? endFuelEntryId,
    double? startOdometerKm,
    double? endOdometerKm,
    double? distanceKm,
    double? fuelConsumedLitres,
    double? mileageKmPerLitre,
    int? fuelCostMinorUnits,
    int? calculationVersion,
    DateTime? calculatedAt,
  }) => MileageIntervalData(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    startFuelEntryId: startFuelEntryId ?? this.startFuelEntryId,
    endFuelEntryId: endFuelEntryId ?? this.endFuelEntryId,
    startOdometerKm: startOdometerKm ?? this.startOdometerKm,
    endOdometerKm: endOdometerKm ?? this.endOdometerKm,
    distanceKm: distanceKm ?? this.distanceKm,
    fuelConsumedLitres: fuelConsumedLitres ?? this.fuelConsumedLitres,
    mileageKmPerLitre: mileageKmPerLitre ?? this.mileageKmPerLitre,
    fuelCostMinorUnits: fuelCostMinorUnits ?? this.fuelCostMinorUnits,
    calculationVersion: calculationVersion ?? this.calculationVersion,
    calculatedAt: calculatedAt ?? this.calculatedAt,
  );
  MileageIntervalData copyWithCompanion(MileageIntervalsCompanion data) {
    return MileageIntervalData(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      startFuelEntryId: data.startFuelEntryId.present
          ? data.startFuelEntryId.value
          : this.startFuelEntryId,
      endFuelEntryId: data.endFuelEntryId.present
          ? data.endFuelEntryId.value
          : this.endFuelEntryId,
      startOdometerKm: data.startOdometerKm.present
          ? data.startOdometerKm.value
          : this.startOdometerKm,
      endOdometerKm: data.endOdometerKm.present
          ? data.endOdometerKm.value
          : this.endOdometerKm,
      distanceKm: data.distanceKm.present
          ? data.distanceKm.value
          : this.distanceKm,
      fuelConsumedLitres: data.fuelConsumedLitres.present
          ? data.fuelConsumedLitres.value
          : this.fuelConsumedLitres,
      mileageKmPerLitre: data.mileageKmPerLitre.present
          ? data.mileageKmPerLitre.value
          : this.mileageKmPerLitre,
      fuelCostMinorUnits: data.fuelCostMinorUnits.present
          ? data.fuelCostMinorUnits.value
          : this.fuelCostMinorUnits,
      calculationVersion: data.calculationVersion.present
          ? data.calculationVersion.value
          : this.calculationVersion,
      calculatedAt: data.calculatedAt.present
          ? data.calculatedAt.value
          : this.calculatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MileageIntervalData(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('startFuelEntryId: $startFuelEntryId, ')
          ..write('endFuelEntryId: $endFuelEntryId, ')
          ..write('startOdometerKm: $startOdometerKm, ')
          ..write('endOdometerKm: $endOdometerKm, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('fuelConsumedLitres: $fuelConsumedLitres, ')
          ..write('mileageKmPerLitre: $mileageKmPerLitre, ')
          ..write('fuelCostMinorUnits: $fuelCostMinorUnits, ')
          ..write('calculationVersion: $calculationVersion, ')
          ..write('calculatedAt: $calculatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    startFuelEntryId,
    endFuelEntryId,
    startOdometerKm,
    endOdometerKm,
    distanceKm,
    fuelConsumedLitres,
    mileageKmPerLitre,
    fuelCostMinorUnits,
    calculationVersion,
    calculatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MileageIntervalData &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.startFuelEntryId == this.startFuelEntryId &&
          other.endFuelEntryId == this.endFuelEntryId &&
          other.startOdometerKm == this.startOdometerKm &&
          other.endOdometerKm == this.endOdometerKm &&
          other.distanceKm == this.distanceKm &&
          other.fuelConsumedLitres == this.fuelConsumedLitres &&
          other.mileageKmPerLitre == this.mileageKmPerLitre &&
          other.fuelCostMinorUnits == this.fuelCostMinorUnits &&
          other.calculationVersion == this.calculationVersion &&
          other.calculatedAt == this.calculatedAt);
}

class MileageIntervalsCompanion extends UpdateCompanion<MileageIntervalData> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<String> startFuelEntryId;
  final Value<String> endFuelEntryId;
  final Value<double> startOdometerKm;
  final Value<double> endOdometerKm;
  final Value<double> distanceKm;
  final Value<double> fuelConsumedLitres;
  final Value<double> mileageKmPerLitre;
  final Value<int> fuelCostMinorUnits;
  final Value<int> calculationVersion;
  final Value<DateTime> calculatedAt;
  final Value<int> rowid;
  const MileageIntervalsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.startFuelEntryId = const Value.absent(),
    this.endFuelEntryId = const Value.absent(),
    this.startOdometerKm = const Value.absent(),
    this.endOdometerKm = const Value.absent(),
    this.distanceKm = const Value.absent(),
    this.fuelConsumedLitres = const Value.absent(),
    this.mileageKmPerLitre = const Value.absent(),
    this.fuelCostMinorUnits = const Value.absent(),
    this.calculationVersion = const Value.absent(),
    this.calculatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MileageIntervalsCompanion.insert({
    required String id,
    required String vehicleId,
    required String startFuelEntryId,
    required String endFuelEntryId,
    required double startOdometerKm,
    required double endOdometerKm,
    required double distanceKm,
    required double fuelConsumedLitres,
    required double mileageKmPerLitre,
    required int fuelCostMinorUnits,
    this.calculationVersion = const Value.absent(),
    required DateTime calculatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehicleId = Value(vehicleId),
       startFuelEntryId = Value(startFuelEntryId),
       endFuelEntryId = Value(endFuelEntryId),
       startOdometerKm = Value(startOdometerKm),
       endOdometerKm = Value(endOdometerKm),
       distanceKm = Value(distanceKm),
       fuelConsumedLitres = Value(fuelConsumedLitres),
       mileageKmPerLitre = Value(mileageKmPerLitre),
       fuelCostMinorUnits = Value(fuelCostMinorUnits),
       calculatedAt = Value(calculatedAt);
  static Insertable<MileageIntervalData> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<String>? startFuelEntryId,
    Expression<String>? endFuelEntryId,
    Expression<double>? startOdometerKm,
    Expression<double>? endOdometerKm,
    Expression<double>? distanceKm,
    Expression<double>? fuelConsumedLitres,
    Expression<double>? mileageKmPerLitre,
    Expression<int>? fuelCostMinorUnits,
    Expression<int>? calculationVersion,
    Expression<DateTime>? calculatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (startFuelEntryId != null) 'start_fuel_entry_id': startFuelEntryId,
      if (endFuelEntryId != null) 'end_fuel_entry_id': endFuelEntryId,
      if (startOdometerKm != null) 'start_odometer_km': startOdometerKm,
      if (endOdometerKm != null) 'end_odometer_km': endOdometerKm,
      if (distanceKm != null) 'distance_km': distanceKm,
      if (fuelConsumedLitres != null)
        'fuel_consumed_litres': fuelConsumedLitres,
      if (mileageKmPerLitre != null) 'mileage_km_per_litre': mileageKmPerLitre,
      if (fuelCostMinorUnits != null)
        'fuel_cost_minor_units': fuelCostMinorUnits,
      if (calculationVersion != null) 'calculation_version': calculationVersion,
      if (calculatedAt != null) 'calculated_at': calculatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MileageIntervalsCompanion copyWith({
    Value<String>? id,
    Value<String>? vehicleId,
    Value<String>? startFuelEntryId,
    Value<String>? endFuelEntryId,
    Value<double>? startOdometerKm,
    Value<double>? endOdometerKm,
    Value<double>? distanceKm,
    Value<double>? fuelConsumedLitres,
    Value<double>? mileageKmPerLitre,
    Value<int>? fuelCostMinorUnits,
    Value<int>? calculationVersion,
    Value<DateTime>? calculatedAt,
    Value<int>? rowid,
  }) {
    return MileageIntervalsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      startFuelEntryId: startFuelEntryId ?? this.startFuelEntryId,
      endFuelEntryId: endFuelEntryId ?? this.endFuelEntryId,
      startOdometerKm: startOdometerKm ?? this.startOdometerKm,
      endOdometerKm: endOdometerKm ?? this.endOdometerKm,
      distanceKm: distanceKm ?? this.distanceKm,
      fuelConsumedLitres: fuelConsumedLitres ?? this.fuelConsumedLitres,
      mileageKmPerLitre: mileageKmPerLitre ?? this.mileageKmPerLitre,
      fuelCostMinorUnits: fuelCostMinorUnits ?? this.fuelCostMinorUnits,
      calculationVersion: calculationVersion ?? this.calculationVersion,
      calculatedAt: calculatedAt ?? this.calculatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (startFuelEntryId.present) {
      map['start_fuel_entry_id'] = Variable<String>(startFuelEntryId.value);
    }
    if (endFuelEntryId.present) {
      map['end_fuel_entry_id'] = Variable<String>(endFuelEntryId.value);
    }
    if (startOdometerKm.present) {
      map['start_odometer_km'] = Variable<double>(startOdometerKm.value);
    }
    if (endOdometerKm.present) {
      map['end_odometer_km'] = Variable<double>(endOdometerKm.value);
    }
    if (distanceKm.present) {
      map['distance_km'] = Variable<double>(distanceKm.value);
    }
    if (fuelConsumedLitres.present) {
      map['fuel_consumed_litres'] = Variable<double>(fuelConsumedLitres.value);
    }
    if (mileageKmPerLitre.present) {
      map['mileage_km_per_litre'] = Variable<double>(mileageKmPerLitre.value);
    }
    if (fuelCostMinorUnits.present) {
      map['fuel_cost_minor_units'] = Variable<int>(fuelCostMinorUnits.value);
    }
    if (calculationVersion.present) {
      map['calculation_version'] = Variable<int>(calculationVersion.value);
    }
    if (calculatedAt.present) {
      map['calculated_at'] = Variable<DateTime>(calculatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MileageIntervalsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('startFuelEntryId: $startFuelEntryId, ')
          ..write('endFuelEntryId: $endFuelEntryId, ')
          ..write('startOdometerKm: $startOdometerKm, ')
          ..write('endOdometerKm: $endOdometerKm, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('fuelConsumedLitres: $fuelConsumedLitres, ')
          ..write('mileageKmPerLitre: $mileageKmPerLitre, ')
          ..write('fuelCostMinorUnits: $fuelCostMinorUnits, ')
          ..write('calculationVersion: $calculationVersion, ')
          ..write('calculatedAt: $calculatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MaintenanceRecordsTable extends MaintenanceRecords
    with TableInfo<$MaintenanceRecordsTable, MaintenanceRecordData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaintenanceRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMinorUnitsMeta = const VerificationMeta(
    'amountMinorUnits',
  );
  @override
  late final GeneratedColumn<int> amountMinorUnits = GeneratedColumn<int>(
    'amount_minor_units',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceDateMeta = const VerificationMeta(
    'serviceDate',
  );
  @override
  late final GeneratedColumn<DateTime> serviceDate = GeneratedColumn<DateTime>(
    'service_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometerKmMeta = const VerificationMeta(
    'odometerKm',
  );
  @override
  late final GeneratedColumn<double> odometerKm = GeneratedColumn<double>(
    'odometer_km',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextServiceDateMeta = const VerificationMeta(
    'nextServiceDate',
  );
  @override
  late final GeneratedColumn<DateTime> nextServiceDate =
      GeneratedColumn<DateTime>(
        'next_service_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nextServiceOdometerKmMeta =
      const VerificationMeta('nextServiceOdometerKm');
  @override
  late final GeneratedColumn<double> nextServiceOdometerKm =
      GeneratedColumn<double>(
        'next_service_odometer_km',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    category,
    description,
    amountMinorUnits,
    serviceDate,
    odometerKm,
    nextServiceDate,
    nextServiceOdometerKm,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenance_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<MaintenanceRecordData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('amount_minor_units')) {
      context.handle(
        _amountMinorUnitsMeta,
        amountMinorUnits.isAcceptableOrUnknown(
          data['amount_minor_units']!,
          _amountMinorUnitsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorUnitsMeta);
    }
    if (data.containsKey('service_date')) {
      context.handle(
        _serviceDateMeta,
        serviceDate.isAcceptableOrUnknown(
          data['service_date']!,
          _serviceDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serviceDateMeta);
    }
    if (data.containsKey('odometer_km')) {
      context.handle(
        _odometerKmMeta,
        odometerKm.isAcceptableOrUnknown(data['odometer_km']!, _odometerKmMeta),
      );
    } else if (isInserting) {
      context.missing(_odometerKmMeta);
    }
    if (data.containsKey('next_service_date')) {
      context.handle(
        _nextServiceDateMeta,
        nextServiceDate.isAcceptableOrUnknown(
          data['next_service_date']!,
          _nextServiceDateMeta,
        ),
      );
    }
    if (data.containsKey('next_service_odometer_km')) {
      context.handle(
        _nextServiceOdometerKmMeta,
        nextServiceOdometerKm.isAcceptableOrUnknown(
          data['next_service_odometer_km']!,
          _nextServiceOdometerKmMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaintenanceRecordData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaintenanceRecordData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      amountMinorUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor_units'],
      )!,
      serviceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}service_date'],
      )!,
      odometerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}odometer_km'],
      )!,
      nextServiceDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_service_date'],
      ),
      nextServiceOdometerKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}next_service_odometer_km'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MaintenanceRecordsTable createAlias(String alias) {
    return $MaintenanceRecordsTable(attachedDatabase, alias);
  }
}

class MaintenanceRecordData extends DataClass
    implements Insertable<MaintenanceRecordData> {
  final String id;
  final String vehicleId;
  final String category;
  final String description;
  final int amountMinorUnits;
  final DateTime serviceDate;
  final double odometerKm;
  final DateTime? nextServiceDate;
  final double? nextServiceOdometerKm;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MaintenanceRecordData({
    required this.id,
    required this.vehicleId,
    required this.category,
    required this.description,
    required this.amountMinorUnits,
    required this.serviceDate,
    required this.odometerKm,
    this.nextServiceDate,
    this.nextServiceOdometerKm,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    map['category'] = Variable<String>(category);
    map['description'] = Variable<String>(description);
    map['amount_minor_units'] = Variable<int>(amountMinorUnits);
    map['service_date'] = Variable<DateTime>(serviceDate);
    map['odometer_km'] = Variable<double>(odometerKm);
    if (!nullToAbsent || nextServiceDate != null) {
      map['next_service_date'] = Variable<DateTime>(nextServiceDate);
    }
    if (!nullToAbsent || nextServiceOdometerKm != null) {
      map['next_service_odometer_km'] = Variable<double>(nextServiceOdometerKm);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MaintenanceRecordsCompanion toCompanion(bool nullToAbsent) {
    return MaintenanceRecordsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      category: Value(category),
      description: Value(description),
      amountMinorUnits: Value(amountMinorUnits),
      serviceDate: Value(serviceDate),
      odometerKm: Value(odometerKm),
      nextServiceDate: nextServiceDate == null && nullToAbsent
          ? const Value.absent()
          : Value(nextServiceDate),
      nextServiceOdometerKm: nextServiceOdometerKm == null && nullToAbsent
          ? const Value.absent()
          : Value(nextServiceOdometerKm),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MaintenanceRecordData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaintenanceRecordData(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      category: serializer.fromJson<String>(json['category']),
      description: serializer.fromJson<String>(json['description']),
      amountMinorUnits: serializer.fromJson<int>(json['amountMinorUnits']),
      serviceDate: serializer.fromJson<DateTime>(json['serviceDate']),
      odometerKm: serializer.fromJson<double>(json['odometerKm']),
      nextServiceDate: serializer.fromJson<DateTime?>(json['nextServiceDate']),
      nextServiceOdometerKm: serializer.fromJson<double?>(
        json['nextServiceOdometerKm'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'category': serializer.toJson<String>(category),
      'description': serializer.toJson<String>(description),
      'amountMinorUnits': serializer.toJson<int>(amountMinorUnits),
      'serviceDate': serializer.toJson<DateTime>(serviceDate),
      'odometerKm': serializer.toJson<double>(odometerKm),
      'nextServiceDate': serializer.toJson<DateTime?>(nextServiceDate),
      'nextServiceOdometerKm': serializer.toJson<double?>(
        nextServiceOdometerKm,
      ),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MaintenanceRecordData copyWith({
    String? id,
    String? vehicleId,
    String? category,
    String? description,
    int? amountMinorUnits,
    DateTime? serviceDate,
    double? odometerKm,
    Value<DateTime?> nextServiceDate = const Value.absent(),
    Value<double?> nextServiceOdometerKm = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MaintenanceRecordData(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    category: category ?? this.category,
    description: description ?? this.description,
    amountMinorUnits: amountMinorUnits ?? this.amountMinorUnits,
    serviceDate: serviceDate ?? this.serviceDate,
    odometerKm: odometerKm ?? this.odometerKm,
    nextServiceDate: nextServiceDate.present
        ? nextServiceDate.value
        : this.nextServiceDate,
    nextServiceOdometerKm: nextServiceOdometerKm.present
        ? nextServiceOdometerKm.value
        : this.nextServiceOdometerKm,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MaintenanceRecordData copyWithCompanion(MaintenanceRecordsCompanion data) {
    return MaintenanceRecordData(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      category: data.category.present ? data.category.value : this.category,
      description: data.description.present
          ? data.description.value
          : this.description,
      amountMinorUnits: data.amountMinorUnits.present
          ? data.amountMinorUnits.value
          : this.amountMinorUnits,
      serviceDate: data.serviceDate.present
          ? data.serviceDate.value
          : this.serviceDate,
      odometerKm: data.odometerKm.present
          ? data.odometerKm.value
          : this.odometerKm,
      nextServiceDate: data.nextServiceDate.present
          ? data.nextServiceDate.value
          : this.nextServiceDate,
      nextServiceOdometerKm: data.nextServiceOdometerKm.present
          ? data.nextServiceOdometerKm.value
          : this.nextServiceOdometerKm,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceRecordData(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('amountMinorUnits: $amountMinorUnits, ')
          ..write('serviceDate: $serviceDate, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('nextServiceDate: $nextServiceDate, ')
          ..write('nextServiceOdometerKm: $nextServiceOdometerKm, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    category,
    description,
    amountMinorUnits,
    serviceDate,
    odometerKm,
    nextServiceDate,
    nextServiceOdometerKm,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaintenanceRecordData &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.category == this.category &&
          other.description == this.description &&
          other.amountMinorUnits == this.amountMinorUnits &&
          other.serviceDate == this.serviceDate &&
          other.odometerKm == this.odometerKm &&
          other.nextServiceDate == this.nextServiceDate &&
          other.nextServiceOdometerKm == this.nextServiceOdometerKm &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MaintenanceRecordsCompanion
    extends UpdateCompanion<MaintenanceRecordData> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<String> category;
  final Value<String> description;
  final Value<int> amountMinorUnits;
  final Value<DateTime> serviceDate;
  final Value<double> odometerKm;
  final Value<DateTime?> nextServiceDate;
  final Value<double?> nextServiceOdometerKm;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MaintenanceRecordsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.amountMinorUnits = const Value.absent(),
    this.serviceDate = const Value.absent(),
    this.odometerKm = const Value.absent(),
    this.nextServiceDate = const Value.absent(),
    this.nextServiceOdometerKm = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MaintenanceRecordsCompanion.insert({
    required String id,
    required String vehicleId,
    required String category,
    required String description,
    required int amountMinorUnits,
    required DateTime serviceDate,
    required double odometerKm,
    this.nextServiceDate = const Value.absent(),
    this.nextServiceOdometerKm = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehicleId = Value(vehicleId),
       category = Value(category),
       description = Value(description),
       amountMinorUnits = Value(amountMinorUnits),
       serviceDate = Value(serviceDate),
       odometerKm = Value(odometerKm),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MaintenanceRecordData> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<String>? category,
    Expression<String>? description,
    Expression<int>? amountMinorUnits,
    Expression<DateTime>? serviceDate,
    Expression<double>? odometerKm,
    Expression<DateTime>? nextServiceDate,
    Expression<double>? nextServiceOdometerKm,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (amountMinorUnits != null) 'amount_minor_units': amountMinorUnits,
      if (serviceDate != null) 'service_date': serviceDate,
      if (odometerKm != null) 'odometer_km': odometerKm,
      if (nextServiceDate != null) 'next_service_date': nextServiceDate,
      if (nextServiceOdometerKm != null)
        'next_service_odometer_km': nextServiceOdometerKm,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MaintenanceRecordsCompanion copyWith({
    Value<String>? id,
    Value<String>? vehicleId,
    Value<String>? category,
    Value<String>? description,
    Value<int>? amountMinorUnits,
    Value<DateTime>? serviceDate,
    Value<double>? odometerKm,
    Value<DateTime?>? nextServiceDate,
    Value<double?>? nextServiceOdometerKm,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MaintenanceRecordsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      category: category ?? this.category,
      description: description ?? this.description,
      amountMinorUnits: amountMinorUnits ?? this.amountMinorUnits,
      serviceDate: serviceDate ?? this.serviceDate,
      odometerKm: odometerKm ?? this.odometerKm,
      nextServiceDate: nextServiceDate ?? this.nextServiceDate,
      nextServiceOdometerKm:
          nextServiceOdometerKm ?? this.nextServiceOdometerKm,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amountMinorUnits.present) {
      map['amount_minor_units'] = Variable<int>(amountMinorUnits.value);
    }
    if (serviceDate.present) {
      map['service_date'] = Variable<DateTime>(serviceDate.value);
    }
    if (odometerKm.present) {
      map['odometer_km'] = Variable<double>(odometerKm.value);
    }
    if (nextServiceDate.present) {
      map['next_service_date'] = Variable<DateTime>(nextServiceDate.value);
    }
    if (nextServiceOdometerKm.present) {
      map['next_service_odometer_km'] = Variable<double>(
        nextServiceOdometerKm.value,
      );
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceRecordsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('amountMinorUnits: $amountMinorUnits, ')
          ..write('serviceDate: $serviceDate, ')
          ..write('odometerKm: $odometerKm, ')
          ..write('nextServiceDate: $nextServiceDate, ')
          ..write('nextServiceOdometerKm: $nextServiceOdometerKm, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FuelBudgetsTable extends FuelBudgets
    with TableInfo<$FuelBudgetsTable, FuelBudgetData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FuelBudgetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _monthlyLimitMinorUnitsMeta =
      const VerificationMeta('monthlyLimitMinorUnits');
  @override
  late final GeneratedColumn<int> monthlyLimitMinorUnits = GeneratedColumn<int>(
    'monthly_limit_minor_units',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _warningThresholdPercentMeta =
      const VerificationMeta('warningThresholdPercent');
  @override
  late final GeneratedColumn<int> warningThresholdPercent =
      GeneratedColumn<int>(
        'warning_threshold_percent',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(80),
      );
  static const VerificationMeta _periodMeta = const VerificationMeta('period');
  @override
  late final GeneratedColumn<String> period = GeneratedColumn<String>(
    'period',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('monthly'),
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    monthlyLimitMinorUnits,
    warningThresholdPercent,
    period,
    isEnabled,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fuel_budgets';
  @override
  VerificationContext validateIntegrity(
    Insertable<FuelBudgetData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    }
    if (data.containsKey('monthly_limit_minor_units')) {
      context.handle(
        _monthlyLimitMinorUnitsMeta,
        monthlyLimitMinorUnits.isAcceptableOrUnknown(
          data['monthly_limit_minor_units']!,
          _monthlyLimitMinorUnitsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_monthlyLimitMinorUnitsMeta);
    }
    if (data.containsKey('warning_threshold_percent')) {
      context.handle(
        _warningThresholdPercentMeta,
        warningThresholdPercent.isAcceptableOrUnknown(
          data['warning_threshold_percent']!,
          _warningThresholdPercentMeta,
        ),
      );
    }
    if (data.containsKey('period')) {
      context.handle(
        _periodMeta,
        period.isAcceptableOrUnknown(data['period']!, _periodMeta),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FuelBudgetData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FuelBudgetData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      ),
      monthlyLimitMinorUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monthly_limit_minor_units'],
      )!,
      warningThresholdPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}warning_threshold_percent'],
      )!,
      period: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}period'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FuelBudgetsTable createAlias(String alias) {
    return $FuelBudgetsTable(attachedDatabase, alias);
  }
}

class FuelBudgetData extends DataClass implements Insertable<FuelBudgetData> {
  final String id;
  final String? vehicleId;
  final int monthlyLimitMinorUnits;
  final int warningThresholdPercent;
  final String period;
  final bool isEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FuelBudgetData({
    required this.id,
    this.vehicleId,
    required this.monthlyLimitMinorUnits,
    required this.warningThresholdPercent,
    required this.period,
    required this.isEnabled,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || vehicleId != null) {
      map['vehicle_id'] = Variable<String>(vehicleId);
    }
    map['monthly_limit_minor_units'] = Variable<int>(monthlyLimitMinorUnits);
    map['warning_threshold_percent'] = Variable<int>(warningThresholdPercent);
    map['period'] = Variable<String>(period);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FuelBudgetsCompanion toCompanion(bool nullToAbsent) {
    return FuelBudgetsCompanion(
      id: Value(id),
      vehicleId: vehicleId == null && nullToAbsent
          ? const Value.absent()
          : Value(vehicleId),
      monthlyLimitMinorUnits: Value(monthlyLimitMinorUnits),
      warningThresholdPercent: Value(warningThresholdPercent),
      period: Value(period),
      isEnabled: Value(isEnabled),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FuelBudgetData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FuelBudgetData(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String?>(json['vehicleId']),
      monthlyLimitMinorUnits: serializer.fromJson<int>(
        json['monthlyLimitMinorUnits'],
      ),
      warningThresholdPercent: serializer.fromJson<int>(
        json['warningThresholdPercent'],
      ),
      period: serializer.fromJson<String>(json['period']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String?>(vehicleId),
      'monthlyLimitMinorUnits': serializer.toJson<int>(monthlyLimitMinorUnits),
      'warningThresholdPercent': serializer.toJson<int>(
        warningThresholdPercent,
      ),
      'period': serializer.toJson<String>(period),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FuelBudgetData copyWith({
    String? id,
    Value<String?> vehicleId = const Value.absent(),
    int? monthlyLimitMinorUnits,
    int? warningThresholdPercent,
    String? period,
    bool? isEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FuelBudgetData(
    id: id ?? this.id,
    vehicleId: vehicleId.present ? vehicleId.value : this.vehicleId,
    monthlyLimitMinorUnits:
        monthlyLimitMinorUnits ?? this.monthlyLimitMinorUnits,
    warningThresholdPercent:
        warningThresholdPercent ?? this.warningThresholdPercent,
    period: period ?? this.period,
    isEnabled: isEnabled ?? this.isEnabled,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FuelBudgetData copyWithCompanion(FuelBudgetsCompanion data) {
    return FuelBudgetData(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      monthlyLimitMinorUnits: data.monthlyLimitMinorUnits.present
          ? data.monthlyLimitMinorUnits.value
          : this.monthlyLimitMinorUnits,
      warningThresholdPercent: data.warningThresholdPercent.present
          ? data.warningThresholdPercent.value
          : this.warningThresholdPercent,
      period: data.period.present ? data.period.value : this.period,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FuelBudgetData(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('monthlyLimitMinorUnits: $monthlyLimitMinorUnits, ')
          ..write('warningThresholdPercent: $warningThresholdPercent, ')
          ..write('period: $period, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    monthlyLimitMinorUnits,
    warningThresholdPercent,
    period,
    isEnabled,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FuelBudgetData &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.monthlyLimitMinorUnits == this.monthlyLimitMinorUnits &&
          other.warningThresholdPercent == this.warningThresholdPercent &&
          other.period == this.period &&
          other.isEnabled == this.isEnabled &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FuelBudgetsCompanion extends UpdateCompanion<FuelBudgetData> {
  final Value<String> id;
  final Value<String?> vehicleId;
  final Value<int> monthlyLimitMinorUnits;
  final Value<int> warningThresholdPercent;
  final Value<String> period;
  final Value<bool> isEnabled;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FuelBudgetsCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.monthlyLimitMinorUnits = const Value.absent(),
    this.warningThresholdPercent = const Value.absent(),
    this.period = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FuelBudgetsCompanion.insert({
    required String id,
    this.vehicleId = const Value.absent(),
    required int monthlyLimitMinorUnits,
    this.warningThresholdPercent = const Value.absent(),
    this.period = const Value.absent(),
    this.isEnabled = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       monthlyLimitMinorUnits = Value(monthlyLimitMinorUnits),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FuelBudgetData> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<int>? monthlyLimitMinorUnits,
    Expression<int>? warningThresholdPercent,
    Expression<String>? period,
    Expression<bool>? isEnabled,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (monthlyLimitMinorUnits != null)
        'monthly_limit_minor_units': monthlyLimitMinorUnits,
      if (warningThresholdPercent != null)
        'warning_threshold_percent': warningThresholdPercent,
      if (period != null) 'period': period,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FuelBudgetsCompanion copyWith({
    Value<String>? id,
    Value<String?>? vehicleId,
    Value<int>? monthlyLimitMinorUnits,
    Value<int>? warningThresholdPercent,
    Value<String>? period,
    Value<bool>? isEnabled,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FuelBudgetsCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      monthlyLimitMinorUnits:
          monthlyLimitMinorUnits ?? this.monthlyLimitMinorUnits,
      warningThresholdPercent:
          warningThresholdPercent ?? this.warningThresholdPercent,
      period: period ?? this.period,
      isEnabled: isEnabled ?? this.isEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (monthlyLimitMinorUnits.present) {
      map['monthly_limit_minor_units'] = Variable<int>(
        monthlyLimitMinorUnits.value,
      );
    }
    if (warningThresholdPercent.present) {
      map['warning_threshold_percent'] = Variable<int>(
        warningThresholdPercent.value,
      );
    }
    if (period.present) {
      map['period'] = Variable<String>(period.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FuelBudgetsCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('monthlyLimitMinorUnits: $monthlyLimitMinorUnits, ')
          ..write('warningThresholdPercent: $warningThresholdPercent, ')
          ..write('period: $period, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, ReminderData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehicleIdMeta = const VerificationMeta(
    'vehicleId',
  );
  @override
  late final GeneratedColumn<String> vehicleId = GeneratedColumn<String>(
    'vehicle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _maintenanceRecordIdMeta =
      const VerificationMeta('maintenanceRecordId');
  @override
  late final GeneratedColumn<String> maintenanceRecordId =
      GeneratedColumn<String>(
        'maintenance_record_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES maintenance_records (id) ON DELETE SET NULL',
        ),
      );
  static const VerificationMeta _reminderTypeMeta = const VerificationMeta(
    'reminderType',
  );
  @override
  late final GeneratedColumn<String> reminderType = GeneratedColumn<String>(
    'reminder_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduledDateMeta = const VerificationMeta(
    'scheduledDate',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledDate =
      GeneratedColumn<DateTime>(
        'scheduled_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _odometerThresholdKmMeta =
      const VerificationMeta('odometerThresholdKm');
  @override
  late final GeneratedColumn<double> odometerThresholdKm =
      GeneratedColumn<double>(
        'odometer_threshold_km',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _lastTriggeredAtMeta = const VerificationMeta(
    'lastTriggeredAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastTriggeredAt =
      GeneratedColumn<DateTime>(
        'last_triggered_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehicleId,
    maintenanceRecordId,
    reminderType,
    scheduledDate,
    odometerThresholdKm,
    isEnabled,
    lastTriggeredAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReminderData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(
        _vehicleIdMeta,
        vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('maintenance_record_id')) {
      context.handle(
        _maintenanceRecordIdMeta,
        maintenanceRecordId.isAcceptableOrUnknown(
          data['maintenance_record_id']!,
          _maintenanceRecordIdMeta,
        ),
      );
    }
    if (data.containsKey('reminder_type')) {
      context.handle(
        _reminderTypeMeta,
        reminderType.isAcceptableOrUnknown(
          data['reminder_type']!,
          _reminderTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reminderTypeMeta);
    }
    if (data.containsKey('scheduled_date')) {
      context.handle(
        _scheduledDateMeta,
        scheduledDate.isAcceptableOrUnknown(
          data['scheduled_date']!,
          _scheduledDateMeta,
        ),
      );
    }
    if (data.containsKey('odometer_threshold_km')) {
      context.handle(
        _odometerThresholdKmMeta,
        odometerThresholdKm.isAcceptableOrUnknown(
          data['odometer_threshold_km']!,
          _odometerThresholdKmMeta,
        ),
      );
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('last_triggered_at')) {
      context.handle(
        _lastTriggeredAtMeta,
        lastTriggeredAt.isAcceptableOrUnknown(
          data['last_triggered_at']!,
          _lastTriggeredAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReminderData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehicleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicle_id'],
      )!,
      maintenanceRecordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}maintenance_record_id'],
      ),
      reminderType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminder_type'],
      )!,
      scheduledDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_date'],
      ),
      odometerThresholdKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}odometer_threshold_km'],
      ),
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      lastTriggeredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_triggered_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }
}

class ReminderData extends DataClass implements Insertable<ReminderData> {
  final String id;
  final String vehicleId;
  final String? maintenanceRecordId;
  final String reminderType;
  final DateTime? scheduledDate;
  final double? odometerThresholdKm;
  final bool isEnabled;
  final DateTime? lastTriggeredAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ReminderData({
    required this.id,
    required this.vehicleId,
    this.maintenanceRecordId,
    required this.reminderType,
    this.scheduledDate,
    this.odometerThresholdKm,
    required this.isEnabled,
    this.lastTriggeredAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicle_id'] = Variable<String>(vehicleId);
    if (!nullToAbsent || maintenanceRecordId != null) {
      map['maintenance_record_id'] = Variable<String>(maintenanceRecordId);
    }
    map['reminder_type'] = Variable<String>(reminderType);
    if (!nullToAbsent || scheduledDate != null) {
      map['scheduled_date'] = Variable<DateTime>(scheduledDate);
    }
    if (!nullToAbsent || odometerThresholdKm != null) {
      map['odometer_threshold_km'] = Variable<double>(odometerThresholdKm);
    }
    map['is_enabled'] = Variable<bool>(isEnabled);
    if (!nullToAbsent || lastTriggeredAt != null) {
      map['last_triggered_at'] = Variable<DateTime>(lastTriggeredAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      maintenanceRecordId: maintenanceRecordId == null && nullToAbsent
          ? const Value.absent()
          : Value(maintenanceRecordId),
      reminderType: Value(reminderType),
      scheduledDate: scheduledDate == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledDate),
      odometerThresholdKm: odometerThresholdKm == null && nullToAbsent
          ? const Value.absent()
          : Value(odometerThresholdKm),
      isEnabled: Value(isEnabled),
      lastTriggeredAt: lastTriggeredAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastTriggeredAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ReminderData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderData(
      id: serializer.fromJson<String>(json['id']),
      vehicleId: serializer.fromJson<String>(json['vehicleId']),
      maintenanceRecordId: serializer.fromJson<String?>(
        json['maintenanceRecordId'],
      ),
      reminderType: serializer.fromJson<String>(json['reminderType']),
      scheduledDate: serializer.fromJson<DateTime?>(json['scheduledDate']),
      odometerThresholdKm: serializer.fromJson<double?>(
        json['odometerThresholdKm'],
      ),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      lastTriggeredAt: serializer.fromJson<DateTime?>(json['lastTriggeredAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehicleId': serializer.toJson<String>(vehicleId),
      'maintenanceRecordId': serializer.toJson<String?>(maintenanceRecordId),
      'reminderType': serializer.toJson<String>(reminderType),
      'scheduledDate': serializer.toJson<DateTime?>(scheduledDate),
      'odometerThresholdKm': serializer.toJson<double?>(odometerThresholdKm),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'lastTriggeredAt': serializer.toJson<DateTime?>(lastTriggeredAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ReminderData copyWith({
    String? id,
    String? vehicleId,
    Value<String?> maintenanceRecordId = const Value.absent(),
    String? reminderType,
    Value<DateTime?> scheduledDate = const Value.absent(),
    Value<double?> odometerThresholdKm = const Value.absent(),
    bool? isEnabled,
    Value<DateTime?> lastTriggeredAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ReminderData(
    id: id ?? this.id,
    vehicleId: vehicleId ?? this.vehicleId,
    maintenanceRecordId: maintenanceRecordId.present
        ? maintenanceRecordId.value
        : this.maintenanceRecordId,
    reminderType: reminderType ?? this.reminderType,
    scheduledDate: scheduledDate.present
        ? scheduledDate.value
        : this.scheduledDate,
    odometerThresholdKm: odometerThresholdKm.present
        ? odometerThresholdKm.value
        : this.odometerThresholdKm,
    isEnabled: isEnabled ?? this.isEnabled,
    lastTriggeredAt: lastTriggeredAt.present
        ? lastTriggeredAt.value
        : this.lastTriggeredAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ReminderData copyWithCompanion(RemindersCompanion data) {
    return ReminderData(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      maintenanceRecordId: data.maintenanceRecordId.present
          ? data.maintenanceRecordId.value
          : this.maintenanceRecordId,
      reminderType: data.reminderType.present
          ? data.reminderType.value
          : this.reminderType,
      scheduledDate: data.scheduledDate.present
          ? data.scheduledDate.value
          : this.scheduledDate,
      odometerThresholdKm: data.odometerThresholdKm.present
          ? data.odometerThresholdKm.value
          : this.odometerThresholdKm,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      lastTriggeredAt: data.lastTriggeredAt.present
          ? data.lastTriggeredAt.value
          : this.lastTriggeredAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderData(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('maintenanceRecordId: $maintenanceRecordId, ')
          ..write('reminderType: $reminderType, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('odometerThresholdKm: $odometerThresholdKm, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('lastTriggeredAt: $lastTriggeredAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehicleId,
    maintenanceRecordId,
    reminderType,
    scheduledDate,
    odometerThresholdKm,
    isEnabled,
    lastTriggeredAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderData &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.maintenanceRecordId == this.maintenanceRecordId &&
          other.reminderType == this.reminderType &&
          other.scheduledDate == this.scheduledDate &&
          other.odometerThresholdKm == this.odometerThresholdKm &&
          other.isEnabled == this.isEnabled &&
          other.lastTriggeredAt == this.lastTriggeredAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RemindersCompanion extends UpdateCompanion<ReminderData> {
  final Value<String> id;
  final Value<String> vehicleId;
  final Value<String?> maintenanceRecordId;
  final Value<String> reminderType;
  final Value<DateTime?> scheduledDate;
  final Value<double?> odometerThresholdKm;
  final Value<bool> isEnabled;
  final Value<DateTime?> lastTriggeredAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.maintenanceRecordId = const Value.absent(),
    this.reminderType = const Value.absent(),
    this.scheduledDate = const Value.absent(),
    this.odometerThresholdKm = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.lastTriggeredAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemindersCompanion.insert({
    required String id,
    required String vehicleId,
    this.maintenanceRecordId = const Value.absent(),
    required String reminderType,
    this.scheduledDate = const Value.absent(),
    this.odometerThresholdKm = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.lastTriggeredAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehicleId = Value(vehicleId),
       reminderType = Value(reminderType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ReminderData> custom({
    Expression<String>? id,
    Expression<String>? vehicleId,
    Expression<String>? maintenanceRecordId,
    Expression<String>? reminderType,
    Expression<DateTime>? scheduledDate,
    Expression<double>? odometerThresholdKm,
    Expression<bool>? isEnabled,
    Expression<DateTime>? lastTriggeredAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (maintenanceRecordId != null)
        'maintenance_record_id': maintenanceRecordId,
      if (reminderType != null) 'reminder_type': reminderType,
      if (scheduledDate != null) 'scheduled_date': scheduledDate,
      if (odometerThresholdKm != null)
        'odometer_threshold_km': odometerThresholdKm,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (lastTriggeredAt != null) 'last_triggered_at': lastTriggeredAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemindersCompanion copyWith({
    Value<String>? id,
    Value<String>? vehicleId,
    Value<String?>? maintenanceRecordId,
    Value<String>? reminderType,
    Value<DateTime?>? scheduledDate,
    Value<double?>? odometerThresholdKm,
    Value<bool>? isEnabled,
    Value<DateTime?>? lastTriggeredAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return RemindersCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      maintenanceRecordId: maintenanceRecordId ?? this.maintenanceRecordId,
      reminderType: reminderType ?? this.reminderType,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      odometerThresholdKm: odometerThresholdKm ?? this.odometerThresholdKm,
      isEnabled: isEnabled ?? this.isEnabled,
      lastTriggeredAt: lastTriggeredAt ?? this.lastTriggeredAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<String>(vehicleId.value);
    }
    if (maintenanceRecordId.present) {
      map['maintenance_record_id'] = Variable<String>(
        maintenanceRecordId.value,
      );
    }
    if (reminderType.present) {
      map['reminder_type'] = Variable<String>(reminderType.value);
    }
    if (scheduledDate.present) {
      map['scheduled_date'] = Variable<DateTime>(scheduledDate.value);
    }
    if (odometerThresholdKm.present) {
      map['odometer_threshold_km'] = Variable<double>(
        odometerThresholdKm.value,
      );
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (lastTriggeredAt.present) {
      map['last_triggered_at'] = Variable<DateTime>(lastTriggeredAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('maintenanceRecordId: $maintenanceRecordId, ')
          ..write('reminderType: $reminderType, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('odometerThresholdKm: $odometerThresholdKm, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('lastTriggeredAt: $lastTriggeredAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BackupMetadatasTable extends BackupMetadatas
    with TableInfo<$BackupMetadatasTable, BackupMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackupMetadatasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _providerMeta = const VerificationMeta(
    'provider',
  );
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
    'provider',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastBackupAtMeta = const VerificationMeta(
    'lastBackupAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastBackupAt = GeneratedColumn<DateTime>(
    'last_backup_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSuccessfulSyncAtMeta =
      const VerificationMeta('lastSuccessfulSyncAt');
  @override
  late final GeneratedColumn<DateTime> lastSuccessfulSyncAt =
      GeneratedColumn<DateTime>(
        'last_successful_sync_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('idle'),
  );
  static const VerificationMeta _schemaVersionMeta = const VerificationMeta(
    'schemaVersion',
  );
  @override
  late final GeneratedColumn<int> schemaVersion = GeneratedColumn<int>(
    'schema_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    provider,
    lastBackupAt,
    lastSuccessfulSyncAt,
    syncStatus,
    schemaVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'backup_metadatas';
  @override
  VerificationContext validateIntegrity(
    Insertable<BackupMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('provider')) {
      context.handle(
        _providerMeta,
        provider.isAcceptableOrUnknown(data['provider']!, _providerMeta),
      );
    } else if (isInserting) {
      context.missing(_providerMeta);
    }
    if (data.containsKey('last_backup_at')) {
      context.handle(
        _lastBackupAtMeta,
        lastBackupAt.isAcceptableOrUnknown(
          data['last_backup_at']!,
          _lastBackupAtMeta,
        ),
      );
    }
    if (data.containsKey('last_successful_sync_at')) {
      context.handle(
        _lastSuccessfulSyncAtMeta,
        lastSuccessfulSyncAt.isAcceptableOrUnknown(
          data['last_successful_sync_at']!,
          _lastSuccessfulSyncAtMeta,
        ),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('schema_version')) {
      context.handle(
        _schemaVersionMeta,
        schemaVersion.isAcceptableOrUnknown(
          data['schema_version']!,
          _schemaVersionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BackupMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BackupMetadataData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      provider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider'],
      )!,
      lastBackupAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_backup_at'],
      ),
      lastSuccessfulSyncAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_successful_sync_at'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      schemaVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}schema_version'],
      )!,
    );
  }

  @override
  $BackupMetadatasTable createAlias(String alias) {
    return $BackupMetadatasTable(attachedDatabase, alias);
  }
}

class BackupMetadataData extends DataClass
    implements Insertable<BackupMetadataData> {
  final String id;
  final String provider;
  final DateTime? lastBackupAt;
  final DateTime? lastSuccessfulSyncAt;
  final String syncStatus;
  final int schemaVersion;
  const BackupMetadataData({
    required this.id,
    required this.provider,
    this.lastBackupAt,
    this.lastSuccessfulSyncAt,
    required this.syncStatus,
    required this.schemaVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['provider'] = Variable<String>(provider);
    if (!nullToAbsent || lastBackupAt != null) {
      map['last_backup_at'] = Variable<DateTime>(lastBackupAt);
    }
    if (!nullToAbsent || lastSuccessfulSyncAt != null) {
      map['last_successful_sync_at'] = Variable<DateTime>(lastSuccessfulSyncAt);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    map['schema_version'] = Variable<int>(schemaVersion);
    return map;
  }

  BackupMetadatasCompanion toCompanion(bool nullToAbsent) {
    return BackupMetadatasCompanion(
      id: Value(id),
      provider: Value(provider),
      lastBackupAt: lastBackupAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastBackupAt),
      lastSuccessfulSyncAt: lastSuccessfulSyncAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSuccessfulSyncAt),
      syncStatus: Value(syncStatus),
      schemaVersion: Value(schemaVersion),
    );
  }

  factory BackupMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BackupMetadataData(
      id: serializer.fromJson<String>(json['id']),
      provider: serializer.fromJson<String>(json['provider']),
      lastBackupAt: serializer.fromJson<DateTime?>(json['lastBackupAt']),
      lastSuccessfulSyncAt: serializer.fromJson<DateTime?>(
        json['lastSuccessfulSyncAt'],
      ),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      schemaVersion: serializer.fromJson<int>(json['schemaVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'provider': serializer.toJson<String>(provider),
      'lastBackupAt': serializer.toJson<DateTime?>(lastBackupAt),
      'lastSuccessfulSyncAt': serializer.toJson<DateTime?>(
        lastSuccessfulSyncAt,
      ),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'schemaVersion': serializer.toJson<int>(schemaVersion),
    };
  }

  BackupMetadataData copyWith({
    String? id,
    String? provider,
    Value<DateTime?> lastBackupAt = const Value.absent(),
    Value<DateTime?> lastSuccessfulSyncAt = const Value.absent(),
    String? syncStatus,
    int? schemaVersion,
  }) => BackupMetadataData(
    id: id ?? this.id,
    provider: provider ?? this.provider,
    lastBackupAt: lastBackupAt.present ? lastBackupAt.value : this.lastBackupAt,
    lastSuccessfulSyncAt: lastSuccessfulSyncAt.present
        ? lastSuccessfulSyncAt.value
        : this.lastSuccessfulSyncAt,
    syncStatus: syncStatus ?? this.syncStatus,
    schemaVersion: schemaVersion ?? this.schemaVersion,
  );
  BackupMetadataData copyWithCompanion(BackupMetadatasCompanion data) {
    return BackupMetadataData(
      id: data.id.present ? data.id.value : this.id,
      provider: data.provider.present ? data.provider.value : this.provider,
      lastBackupAt: data.lastBackupAt.present
          ? data.lastBackupAt.value
          : this.lastBackupAt,
      lastSuccessfulSyncAt: data.lastSuccessfulSyncAt.present
          ? data.lastSuccessfulSyncAt.value
          : this.lastSuccessfulSyncAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      schemaVersion: data.schemaVersion.present
          ? data.schemaVersion.value
          : this.schemaVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BackupMetadataData(')
          ..write('id: $id, ')
          ..write('provider: $provider, ')
          ..write('lastBackupAt: $lastBackupAt, ')
          ..write('lastSuccessfulSyncAt: $lastSuccessfulSyncAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('schemaVersion: $schemaVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    provider,
    lastBackupAt,
    lastSuccessfulSyncAt,
    syncStatus,
    schemaVersion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BackupMetadataData &&
          other.id == this.id &&
          other.provider == this.provider &&
          other.lastBackupAt == this.lastBackupAt &&
          other.lastSuccessfulSyncAt == this.lastSuccessfulSyncAt &&
          other.syncStatus == this.syncStatus &&
          other.schemaVersion == this.schemaVersion);
}

class BackupMetadatasCompanion extends UpdateCompanion<BackupMetadataData> {
  final Value<String> id;
  final Value<String> provider;
  final Value<DateTime?> lastBackupAt;
  final Value<DateTime?> lastSuccessfulSyncAt;
  final Value<String> syncStatus;
  final Value<int> schemaVersion;
  final Value<int> rowid;
  const BackupMetadatasCompanion({
    this.id = const Value.absent(),
    this.provider = const Value.absent(),
    this.lastBackupAt = const Value.absent(),
    this.lastSuccessfulSyncAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.schemaVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BackupMetadatasCompanion.insert({
    required String id,
    required String provider,
    this.lastBackupAt = const Value.absent(),
    this.lastSuccessfulSyncAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.schemaVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       provider = Value(provider);
  static Insertable<BackupMetadataData> custom({
    Expression<String>? id,
    Expression<String>? provider,
    Expression<DateTime>? lastBackupAt,
    Expression<DateTime>? lastSuccessfulSyncAt,
    Expression<String>? syncStatus,
    Expression<int>? schemaVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (provider != null) 'provider': provider,
      if (lastBackupAt != null) 'last_backup_at': lastBackupAt,
      if (lastSuccessfulSyncAt != null)
        'last_successful_sync_at': lastSuccessfulSyncAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (schemaVersion != null) 'schema_version': schemaVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BackupMetadatasCompanion copyWith({
    Value<String>? id,
    Value<String>? provider,
    Value<DateTime?>? lastBackupAt,
    Value<DateTime?>? lastSuccessfulSyncAt,
    Value<String>? syncStatus,
    Value<int>? schemaVersion,
    Value<int>? rowid,
  }) {
    return BackupMetadatasCompanion(
      id: id ?? this.id,
      provider: provider ?? this.provider,
      lastBackupAt: lastBackupAt ?? this.lastBackupAt,
      lastSuccessfulSyncAt: lastSuccessfulSyncAt ?? this.lastSuccessfulSyncAt,
      syncStatus: syncStatus ?? this.syncStatus,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (lastBackupAt.present) {
      map['last_backup_at'] = Variable<DateTime>(lastBackupAt.value);
    }
    if (lastSuccessfulSyncAt.present) {
      map['last_successful_sync_at'] = Variable<DateTime>(
        lastSuccessfulSyncAt.value,
      );
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (schemaVersion.present) {
      map['schema_version'] = Variable<int>(schemaVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackupMetadatasCompanion(')
          ..write('id: $id, ')
          ..write('provider: $provider, ')
          ..write('lastBackupAt: $lastBackupAt, ')
          ..write('lastSuccessfulSyncAt: $lastSuccessfulSyncAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('schemaVersion: $schemaVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $VehiclesTable vehicles = $VehiclesTable(this);
  late final $FuelEntriesTable fuelEntries = $FuelEntriesTable(this);
  late final $MileageIntervalsTable mileageIntervals = $MileageIntervalsTable(
    this,
  );
  late final $MaintenanceRecordsTable maintenanceRecords =
      $MaintenanceRecordsTable(this);
  late final $FuelBudgetsTable fuelBudgets = $FuelBudgetsTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $BackupMetadatasTable backupMetadatas = $BackupMetadatasTable(
    this,
  );
  late final VehicleDao vehicleDao = VehicleDao(this as AppDatabase);
  late final FuelEntryDao fuelEntryDao = FuelEntryDao(this as AppDatabase);
  late final MileageIntervalDao mileageIntervalDao = MileageIntervalDao(
    this as AppDatabase,
  );
  late final MaintenanceDao maintenanceDao = MaintenanceDao(
    this as AppDatabase,
  );
  late final FuelBudgetDao fuelBudgetDao = FuelBudgetDao(this as AppDatabase);
  late final UserProfileDao userProfileDao = UserProfileDao(
    this as AppDatabase,
  );
  late final ReminderDao reminderDao = ReminderDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userProfiles,
    vehicles,
    fuelEntries,
    mileageIntervals,
    maintenanceRecords,
    fuelBudgets,
    reminders,
    backupMetadatas,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fuel_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('mileage_intervals', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'fuel_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('mileage_intervals', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'fuel_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('mileage_intervals', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('maintenance_records', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('fuel_budgets', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reminders', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'maintenance_records',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reminders', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$UserProfilesTableCreateCompanionBuilder =
    UserProfilesCompanion Function({
      required String id,
      Value<String?> displayName,
      Value<String> currencyCode,
      Value<String> distanceUnit,
      Value<String> themePreference,
      Value<bool> onboardingCompleted,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<String> id,
      Value<String?> displayName,
      Value<String> currencyCode,
      Value<String> distanceUnit,
      Value<String> themePreference,
      Value<bool> onboardingCompleted,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get distanceUnit => $composableBuilder(
    column: $table.distanceUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themePreference => $composableBuilder(
    column: $table.themePreference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get distanceUnit => $composableBuilder(
    column: $table.distanceUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themePreference => $composableBuilder(
    column: $table.themePreference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get distanceUnit => $composableBuilder(
    column: $table.distanceUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themePreference => $composableBuilder(
    column: $table.themePreference,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onboardingCompleted => $composableBuilder(
    column: $table.onboardingCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTable,
          UserProfileData,
          $$UserProfilesTableFilterComposer,
          $$UserProfilesTableOrderingComposer,
          $$UserProfilesTableAnnotationComposer,
          $$UserProfilesTableCreateCompanionBuilder,
          $$UserProfilesTableUpdateCompanionBuilder,
          (
            UserProfileData,
            BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfileData>,
          ),
          UserProfileData,
          PrefetchHooks Function()
        > {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String> distanceUnit = const Value.absent(),
                Value<String> themePreference = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProfilesCompanion(
                id: id,
                displayName: displayName,
                currencyCode: currencyCode,
                distanceUnit: distanceUnit,
                themePreference: themePreference,
                onboardingCompleted: onboardingCompleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> displayName = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String> distanceUnit = const Value.absent(),
                Value<String> themePreference = const Value.absent(),
                Value<bool> onboardingCompleted = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => UserProfilesCompanion.insert(
                id: id,
                displayName: displayName,
                currencyCode: currencyCode,
                distanceUnit: distanceUnit,
                themePreference: themePreference,
                onboardingCompleted: onboardingCompleted,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserProfilesTable, UserProfileData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $UserProfilesTable,
                    UserProfileData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTable,
      UserProfileData,
      $$UserProfilesTableFilterComposer,
      $$UserProfilesTableOrderingComposer,
      $$UserProfilesTableAnnotationComposer,
      $$UserProfilesTableCreateCompanionBuilder,
      $$UserProfilesTableUpdateCompanionBuilder,
      (
        UserProfileData,
        BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfileData>,
      ),
      UserProfileData,
      PrefetchHooks Function()
    >;
typedef $$VehiclesTableCreateCompanionBuilder = VehiclesCompanion Function({
  required String id,
  required String nickname,
  required String make,
  required String model,
  required String vehicleType,
  required String fuelType,
  Value<String?> registrationLabel,
  required double initialOdometerKm,
  Value<double?> expectedMileageKmPerLitre,
  Value<double?> tankCapacityLitres,
  Value<DateTime?> purchaseDate,
  Value<String?> notes,
  Value<bool> isArchived,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$VehiclesTableUpdateCompanionBuilder = VehiclesCompanion Function({
  Value<String> id,
  Value<String> nickname,
  Value<String> make,
  Value<String> model,
  Value<String> vehicleType,
  Value<String> fuelType,
  Value<String?> registrationLabel,
  Value<double> initialOdometerKm,
  Value<double?> expectedMileageKmPerLitre,
  Value<double?> tankCapacityLitres,
  Value<DateTime?> purchaseDate,
  Value<String?> notes,
  Value<bool> isArchived,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$VehiclesTableReferences
    extends BaseReferences<_$AppDatabase, $VehiclesTable, VehicleData> {
  $$VehiclesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FuelEntriesTable, List<FuelEntryData>>
  _fuelEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fuelEntries,
    aliasName: 'vehicles__id__fuel_entries__vehicle_id',
  );

  $$FuelEntriesTableProcessedTableManager get fuelEntriesRefs {
    final manager = $$FuelEntriesTableTableManager(
      $_db,
      $_db.fuelEntries,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_fuelEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MileageIntervalsTable, List<MileageIntervalData>>
  _mileageIntervalsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mileageIntervals,
    aliasName: 'vehicles__id__mileage_intervals__vehicle_id',
  );

  $$MileageIntervalsTableProcessedTableManager get mileageIntervalsRefs {
    final manager = $$MileageIntervalsTableTableManager(
      $_db,
      $_db.mileageIntervals,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _mileageIntervalsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $MaintenanceRecordsTable,
    List<MaintenanceRecordData>
  >
  _maintenanceRecordsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.maintenanceRecords,
        aliasName: 'vehicles__id__maintenance_records__vehicle_id',
      );

  $$MaintenanceRecordsTableProcessedTableManager get maintenanceRecordsRefs {
    final manager = $$MaintenanceRecordsTableTableManager(
      $_db,
      $_db.maintenanceRecords,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _maintenanceRecordsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FuelBudgetsTable, List<FuelBudgetData>>
  _fuelBudgetsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.fuelBudgets,
    aliasName: 'vehicles__id__fuel_budgets__vehicle_id',
  );

  $$FuelBudgetsTableProcessedTableManager get fuelBudgetsRefs {
    final manager = $$FuelBudgetsTableTableManager(
      $_db,
      $_db.fuelBudgets,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_fuelBudgetsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RemindersTable, List<ReminderData>>
  _remindersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reminders,
    aliasName: 'vehicles__id__reminders__vehicle_id',
  );

  $$RemindersTableProcessedTableManager get remindersRefs {
    final manager = $$RemindersTableTableManager(
      $_db,
      $_db.reminders,
    ).filter((f) => f.vehicleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_remindersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VehiclesTableFilterComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get make => $composableBuilder(
    column: $table.make,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vehicleType => $composableBuilder(
    column: $table.vehicleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get registrationLabel => $composableBuilder(
    column: $table.registrationLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get initialOdometerKm => $composableBuilder(
    column: $table.initialOdometerKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get expectedMileageKmPerLitre => $composableBuilder(
    column: $table.expectedMileageKmPerLitre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tankCapacityLitres => $composableBuilder(
    column: $table.tankCapacityLitres,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> fuelEntriesRefs(
    Expression<bool> Function($$FuelEntriesTableFilterComposer f) f,
  ) {
    final $$FuelEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fuelEntries,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelEntriesTableFilterComposer(
            $db: $db,
            $table: $db.fuelEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mileageIntervalsRefs(
    Expression<bool> Function($$MileageIntervalsTableFilterComposer f) f,
  ) {
    final $$MileageIntervalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mileageIntervals,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MileageIntervalsTableFilterComposer(
            $db: $db,
            $table: $db.mileageIntervals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> maintenanceRecordsRefs(
    Expression<bool> Function($$MaintenanceRecordsTableFilterComposer f) f,
  ) {
    final $$MaintenanceRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenanceRecords,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceRecordsTableFilterComposer(
            $db: $db,
            $table: $db.maintenanceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> fuelBudgetsRefs(
    Expression<bool> Function($$FuelBudgetsTableFilterComposer f) f,
  ) {
    final $$FuelBudgetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fuelBudgets,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelBudgetsTableFilterComposer(
            $db: $db,
            $table: $db.fuelBudgets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> remindersRefs(
    Expression<bool> Function($$RemindersTableFilterComposer f) f,
  ) {
    final $$RemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableFilterComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiclesTableOrderingComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get make => $composableBuilder(
    column: $table.make,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vehicleType => $composableBuilder(
    column: $table.vehicleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fuelType => $composableBuilder(
    column: $table.fuelType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get registrationLabel => $composableBuilder(
    column: $table.registrationLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get initialOdometerKm => $composableBuilder(
    column: $table.initialOdometerKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get expectedMileageKmPerLitre => $composableBuilder(
    column: $table.expectedMileageKmPerLitre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tankCapacityLitres => $composableBuilder(
    column: $table.tankCapacityLitres,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VehiclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<String> get make =>
      $composableBuilder(column: $table.make, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get vehicleType => $composableBuilder(
    column: $table.vehicleType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fuelType =>
      $composableBuilder(column: $table.fuelType, builder: (column) => column);

  GeneratedColumn<String> get registrationLabel => $composableBuilder(
    column: $table.registrationLabel,
    builder: (column) => column,
  );

  GeneratedColumn<double> get initialOdometerKm => $composableBuilder(
    column: $table.initialOdometerKm,
    builder: (column) => column,
  );

  GeneratedColumn<double> get expectedMileageKmPerLitre => $composableBuilder(
    column: $table.expectedMileageKmPerLitre,
    builder: (column) => column,
  );

  GeneratedColumn<double> get tankCapacityLitres => $composableBuilder(
    column: $table.tankCapacityLitres,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get purchaseDate => $composableBuilder(
    column: $table.purchaseDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> fuelEntriesRefs<T extends Object>(
    Expression<T> Function($$FuelEntriesTableAnnotationComposer a) f,
  ) {
    final $$FuelEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fuelEntries,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.fuelEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mileageIntervalsRefs<T extends Object>(
    Expression<T> Function($$MileageIntervalsTableAnnotationComposer a) f,
  ) {
    final $$MileageIntervalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mileageIntervals,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MileageIntervalsTableAnnotationComposer(
            $db: $db,
            $table: $db.mileageIntervals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> maintenanceRecordsRefs<T extends Object>(
    Expression<T> Function($$MaintenanceRecordsTableAnnotationComposer a) f,
  ) {
    final $$MaintenanceRecordsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.maintenanceRecords,
          getReferencedColumn: (t) => t.vehicleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MaintenanceRecordsTableAnnotationComposer(
                $db: $db,
                $table: $db.maintenanceRecords,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> fuelBudgetsRefs<T extends Object>(
    Expression<T> Function($$FuelBudgetsTableAnnotationComposer a) f,
  ) {
    final $$FuelBudgetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.fuelBudgets,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelBudgetsTableAnnotationComposer(
            $db: $db,
            $table: $db.fuelBudgets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> remindersRefs<T extends Object>(
    Expression<T> Function($$RemindersTableAnnotationComposer a) f,
  ) {
    final $$RemindersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.vehicleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableAnnotationComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiclesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VehiclesTable,
          VehicleData,
          $$VehiclesTableFilterComposer,
          $$VehiclesTableOrderingComposer,
          $$VehiclesTableAnnotationComposer,
          $$VehiclesTableCreateCompanionBuilder,
          $$VehiclesTableUpdateCompanionBuilder,
          (VehicleData, $$VehiclesTableReferences),
          VehicleData,
          PrefetchHooks Function({
            bool fuelEntriesRefs,
            bool mileageIntervalsRefs,
            bool maintenanceRecordsRefs,
            bool fuelBudgetsRefs,
            bool remindersRefs,
          })
        > {
  $$VehiclesTableTableManager(_$AppDatabase db, $VehiclesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehiclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehiclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehiclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nickname = const Value.absent(),
                Value<String> make = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<String> vehicleType = const Value.absent(),
                Value<String> fuelType = const Value.absent(),
                Value<String?> registrationLabel = const Value.absent(),
                Value<double> initialOdometerKm = const Value.absent(),
                Value<double?> expectedMileageKmPerLitre = const Value.absent(),
                Value<double?> tankCapacityLitres = const Value.absent(),
                Value<DateTime?> purchaseDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehiclesCompanion(
                id: id,
                nickname: nickname,
                make: make,
                model: model,
                vehicleType: vehicleType,
                fuelType: fuelType,
                registrationLabel: registrationLabel,
                initialOdometerKm: initialOdometerKm,
                expectedMileageKmPerLitre: expectedMileageKmPerLitre,
                tankCapacityLitres: tankCapacityLitres,
                purchaseDate: purchaseDate,
                notes: notes,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nickname,
                required String make,
                required String model,
                required String vehicleType,
                required String fuelType,
                Value<String?> registrationLabel = const Value.absent(),
                required double initialOdometerKm,
                Value<double?> expectedMileageKmPerLitre = const Value.absent(),
                Value<double?> tankCapacityLitres = const Value.absent(),
                Value<DateTime?> purchaseDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => VehiclesCompanion.insert(
                id: id,
                nickname: nickname,
                make: make,
                model: model,
                vehicleType: vehicleType,
                fuelType: fuelType,
                registrationLabel: registrationLabel,
                initialOdometerKm: initialOdometerKm,
                expectedMileageKmPerLitre: expectedMileageKmPerLitre,
                tankCapacityLitres: tankCapacityLitres,
                purchaseDate: purchaseDate,
                notes: notes,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VehiclesTable, VehicleData>(table),
                  $$VehiclesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                fuelEntriesRefs = false,
                mileageIntervalsRefs = false,
                maintenanceRecordsRefs = false,
                fuelBudgetsRefs = false,
                remindersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (fuelEntriesRefs) db.fuelEntries,
                    if (mileageIntervalsRefs) db.mileageIntervals,
                    if (maintenanceRecordsRefs) db.maintenanceRecords,
                    if (fuelBudgetsRefs) db.fuelBudgets,
                    if (remindersRefs) db.reminders,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (fuelEntriesRefs)
                        await $_getPrefetchedDataByColumns<
                          VehicleData,
                          $VehiclesTable,
                          FuelEntryData,
                          $FuelEntriesTable
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._fuelEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).fuelEntriesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'vehicle_id',
                          typedResults: items,
                        ),
                      if (mileageIntervalsRefs)
                        await $_getPrefetchedDataByColumns<
                          VehicleData,
                          $VehiclesTable,
                          MileageIntervalData,
                          $MileageIntervalsTable
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._mileageIntervalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).mileageIntervalsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'vehicle_id',
                          typedResults: items,
                        ),
                      if (maintenanceRecordsRefs)
                        await $_getPrefetchedDataByColumns<
                          VehicleData,
                          $VehiclesTable,
                          MaintenanceRecordData,
                          $MaintenanceRecordsTable
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._maintenanceRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).maintenanceRecordsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'vehicle_id',
                          typedResults: items,
                        ),
                      if (fuelBudgetsRefs)
                        await $_getPrefetchedDataByColumns<
                          VehicleData,
                          $VehiclesTable,
                          FuelBudgetData,
                          $FuelBudgetsTable
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._fuelBudgetsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).fuelBudgetsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'vehicle_id',
                          typedResults: items,
                        ),
                      if (remindersRefs)
                        await $_getPrefetchedDataByColumns<
                          VehicleData,
                          $VehiclesTable,
                          ReminderData,
                          $RemindersTable
                        >(
                          currentTable: table,
                          referencedTable: $$VehiclesTableReferences
                              ._remindersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiclesTableReferences(
                                db,
                                table,
                                p0,
                              ).remindersRefs,
                          currentColumn: 'id',
                          referencedColumn: 'vehicle_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$VehiclesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VehiclesTable,
      VehicleData,
      $$VehiclesTableFilterComposer,
      $$VehiclesTableOrderingComposer,
      $$VehiclesTableAnnotationComposer,
      $$VehiclesTableCreateCompanionBuilder,
      $$VehiclesTableUpdateCompanionBuilder,
      (VehicleData, $$VehiclesTableReferences),
      VehicleData,
      PrefetchHooks Function({
        bool fuelEntriesRefs,
        bool mileageIntervalsRefs,
        bool maintenanceRecordsRefs,
        bool fuelBudgetsRefs,
        bool remindersRefs,
      })
    >;
typedef $$FuelEntriesTableCreateCompanionBuilder =
    FuelEntriesCompanion Function({
      required String id,
      required String vehicleId,
      required DateTime timestamp,
      required double odometerKm,
      required int amountPaidMinorUnits,
      required double fuelQuantity,
      required int unitPriceMinorUnitsPerLitre,
      required String entryMethod,
      required String fillType,
      Value<String?> stationName,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$FuelEntriesTableUpdateCompanionBuilder =
    FuelEntriesCompanion Function({
      Value<String> id,
      Value<String> vehicleId,
      Value<DateTime> timestamp,
      Value<double> odometerKm,
      Value<int> amountPaidMinorUnits,
      Value<double> fuelQuantity,
      Value<int> unitPriceMinorUnitsPerLitre,
      Value<String> entryMethod,
      Value<String> fillType,
      Value<String?> stationName,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$FuelEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $FuelEntriesTable, FuelEntryData> {
  $$FuelEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('fuel_entries__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MileageIntervalsTable, List<MileageIntervalData>>
  _startMileageIntervalsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.mileageIntervals,
        aliasName: 'fuel_entries__id__mileage_intervals__start_fuel_entry_id',
      );

  $$MileageIntervalsTableProcessedTableManager get startMileageIntervals {
    final manager =
        $$MileageIntervalsTableTableManager($_db, $_db.mileageIntervals).filter(
          (f) => f.startFuelEntryId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _startMileageIntervalsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MileageIntervalsTable, List<MileageIntervalData>>
  _endMileageIntervalsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.mileageIntervals,
    aliasName: 'fuel_entries__id__mileage_intervals__end_fuel_entry_id',
  );

  $$MileageIntervalsTableProcessedTableManager get endMileageIntervals {
    final manager = $$MileageIntervalsTableTableManager(
      $_db,
      $_db.mileageIntervals,
    ).filter((f) => f.endFuelEntryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _endMileageIntervalsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$FuelEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $FuelEntriesTable> {
  $$FuelEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountPaidMinorUnits => $composableBuilder(
    column: $table.amountPaidMinorUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fuelQuantity => $composableBuilder(
    column: $table.fuelQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitPriceMinorUnitsPerLitre => $composableBuilder(
    column: $table.unitPriceMinorUnitsPerLitre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entryMethod => $composableBuilder(
    column: $table.entryMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fillType => $composableBuilder(
    column: $table.fillType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stationName => $composableBuilder(
    column: $table.stationName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> startMileageIntervals(
    Expression<bool> Function($$MileageIntervalsTableFilterComposer f) f,
  ) {
    final $$MileageIntervalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mileageIntervals,
      getReferencedColumn: (t) => t.startFuelEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MileageIntervalsTableFilterComposer(
            $db: $db,
            $table: $db.mileageIntervals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> endMileageIntervals(
    Expression<bool> Function($$MileageIntervalsTableFilterComposer f) f,
  ) {
    final $$MileageIntervalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mileageIntervals,
      getReferencedColumn: (t) => t.endFuelEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MileageIntervalsTableFilterComposer(
            $db: $db,
            $table: $db.mileageIntervals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FuelEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $FuelEntriesTable> {
  $$FuelEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountPaidMinorUnits => $composableBuilder(
    column: $table.amountPaidMinorUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fuelQuantity => $composableBuilder(
    column: $table.fuelQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitPriceMinorUnitsPerLitre => $composableBuilder(
    column: $table.unitPriceMinorUnitsPerLitre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entryMethod => $composableBuilder(
    column: $table.entryMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fillType => $composableBuilder(
    column: $table.fillType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stationName => $composableBuilder(
    column: $table.stationName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FuelEntriesTable> {
  $$FuelEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountPaidMinorUnits => $composableBuilder(
    column: $table.amountPaidMinorUnits,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fuelQuantity => $composableBuilder(
    column: $table.fuelQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unitPriceMinorUnitsPerLitre => $composableBuilder(
    column: $table.unitPriceMinorUnitsPerLitre,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entryMethod => $composableBuilder(
    column: $table.entryMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fillType =>
      $composableBuilder(column: $table.fillType, builder: (column) => column);

  GeneratedColumn<String> get stationName => $composableBuilder(
    column: $table.stationName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> startMileageIntervals<T extends Object>(
    Expression<T> Function($$MileageIntervalsTableAnnotationComposer a) f,
  ) {
    final $$MileageIntervalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mileageIntervals,
      getReferencedColumn: (t) => t.startFuelEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MileageIntervalsTableAnnotationComposer(
            $db: $db,
            $table: $db.mileageIntervals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> endMileageIntervals<T extends Object>(
    Expression<T> Function($$MileageIntervalsTableAnnotationComposer a) f,
  ) {
    final $$MileageIntervalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mileageIntervals,
      getReferencedColumn: (t) => t.endFuelEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MileageIntervalsTableAnnotationComposer(
            $db: $db,
            $table: $db.mileageIntervals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$FuelEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FuelEntriesTable,
          FuelEntryData,
          $$FuelEntriesTableFilterComposer,
          $$FuelEntriesTableOrderingComposer,
          $$FuelEntriesTableAnnotationComposer,
          $$FuelEntriesTableCreateCompanionBuilder,
          $$FuelEntriesTableUpdateCompanionBuilder,
          (FuelEntryData, $$FuelEntriesTableReferences),
          FuelEntryData,
          PrefetchHooks Function({
            bool vehicleId,
            bool startMileageIntervals,
            bool endMileageIntervals,
          })
        > {
  $$FuelEntriesTableTableManager(_$AppDatabase db, $FuelEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FuelEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FuelEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FuelEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<double> odometerKm = const Value.absent(),
                Value<int> amountPaidMinorUnits = const Value.absent(),
                Value<double> fuelQuantity = const Value.absent(),
                Value<int> unitPriceMinorUnitsPerLitre = const Value.absent(),
                Value<String> entryMethod = const Value.absent(),
                Value<String> fillType = const Value.absent(),
                Value<String?> stationName = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FuelEntriesCompanion(
                id: id,
                vehicleId: vehicleId,
                timestamp: timestamp,
                odometerKm: odometerKm,
                amountPaidMinorUnits: amountPaidMinorUnits,
                fuelQuantity: fuelQuantity,
                unitPriceMinorUnitsPerLitre: unitPriceMinorUnitsPerLitre,
                entryMethod: entryMethod,
                fillType: fillType,
                stationName: stationName,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehicleId,
                required DateTime timestamp,
                required double odometerKm,
                required int amountPaidMinorUnits,
                required double fuelQuantity,
                required int unitPriceMinorUnitsPerLitre,
                required String entryMethod,
                required String fillType,
                Value<String?> stationName = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FuelEntriesCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                timestamp: timestamp,
                odometerKm: odometerKm,
                amountPaidMinorUnits: amountPaidMinorUnits,
                fuelQuantity: fuelQuantity,
                unitPriceMinorUnitsPerLitre: unitPriceMinorUnitsPerLitre,
                entryMethod: entryMethod,
                fillType: fillType,
                stationName: stationName,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FuelEntriesTable, FuelEntryData>(table),
                  $$FuelEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                vehicleId = false,
                startMileageIntervals = false,
                endMileageIntervals = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (startMileageIntervals) db.mileageIntervals,
                    if (endMileageIntervals) db.mileageIntervals,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (vehicleId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.vehicleId,
                            referencedTable: $$FuelEntriesTableReferences
                                ._vehicleIdTable(db),
                            referencedColumn: $$FuelEntriesTableReferences
                                ._vehicleIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (startMileageIntervals)
                        await $_getPrefetchedDataByColumns<
                          FuelEntryData,
                          $FuelEntriesTable,
                          MileageIntervalData,
                          $MileageIntervalsTable
                        >(
                          currentTable: table,
                          referencedTable: $$FuelEntriesTableReferences
                              ._startMileageIntervalsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FuelEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).startMileageIntervals,
                          currentColumn: 'id',
                          referencedColumn: 'start_fuel_entry_id',
                          typedResults: items,
                        ),
                      if (endMileageIntervals)
                        await $_getPrefetchedDataByColumns<
                          FuelEntryData,
                          $FuelEntriesTable,
                          MileageIntervalData,
                          $MileageIntervalsTable
                        >(
                          currentTable: table,
                          referencedTable: $$FuelEntriesTableReferences
                              ._endMileageIntervalsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$FuelEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).endMileageIntervals,
                          currentColumn: 'id',
                          referencedColumn: 'end_fuel_entry_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$FuelEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FuelEntriesTable,
      FuelEntryData,
      $$FuelEntriesTableFilterComposer,
      $$FuelEntriesTableOrderingComposer,
      $$FuelEntriesTableAnnotationComposer,
      $$FuelEntriesTableCreateCompanionBuilder,
      $$FuelEntriesTableUpdateCompanionBuilder,
      (FuelEntryData, $$FuelEntriesTableReferences),
      FuelEntryData,
      PrefetchHooks Function({
        bool vehicleId,
        bool startMileageIntervals,
        bool endMileageIntervals,
      })
    >;
typedef $$MileageIntervalsTableCreateCompanionBuilder =
    MileageIntervalsCompanion Function({
      required String id,
      required String vehicleId,
      required String startFuelEntryId,
      required String endFuelEntryId,
      required double startOdometerKm,
      required double endOdometerKm,
      required double distanceKm,
      required double fuelConsumedLitres,
      required double mileageKmPerLitre,
      required int fuelCostMinorUnits,
      Value<int> calculationVersion,
      required DateTime calculatedAt,
      Value<int> rowid,
    });
typedef $$MileageIntervalsTableUpdateCompanionBuilder =
    MileageIntervalsCompanion Function({
      Value<String> id,
      Value<String> vehicleId,
      Value<String> startFuelEntryId,
      Value<String> endFuelEntryId,
      Value<double> startOdometerKm,
      Value<double> endOdometerKm,
      Value<double> distanceKm,
      Value<double> fuelConsumedLitres,
      Value<double> mileageKmPerLitre,
      Value<int> fuelCostMinorUnits,
      Value<int> calculationVersion,
      Value<DateTime> calculatedAt,
      Value<int> rowid,
    });

final class $$MileageIntervalsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MileageIntervalsTable,
          MileageIntervalData
        > {
  $$MileageIntervalsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('mileage_intervals__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FuelEntriesTable _startFuelEntryIdTable(_$AppDatabase db) => db
      .fuelEntries
      .createAlias('mileage_intervals__start_fuel_entry_id__fuel_entries__id');

  $$FuelEntriesTableProcessedTableManager get startFuelEntryId {
    final $_column = $_itemColumn<String>('start_fuel_entry_id')!;

    final manager = $$FuelEntriesTableTableManager(
      $_db,
      $_db.fuelEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_startFuelEntryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $FuelEntriesTable _endFuelEntryIdTable(_$AppDatabase db) => db
      .fuelEntries
      .createAlias('mileage_intervals__end_fuel_entry_id__fuel_entries__id');

  $$FuelEntriesTableProcessedTableManager get endFuelEntryId {
    final $_column = $_itemColumn<String>('end_fuel_entry_id')!;

    final manager = $$FuelEntriesTableTableManager(
      $_db,
      $_db.fuelEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_endFuelEntryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MileageIntervalsTableFilterComposer
    extends Composer<_$AppDatabase, $MileageIntervalsTable> {
  $$MileageIntervalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get startOdometerKm => $composableBuilder(
    column: $table.startOdometerKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get endOdometerKm => $composableBuilder(
    column: $table.endOdometerKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fuelConsumedLitres => $composableBuilder(
    column: $table.fuelConsumedLitres,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mileageKmPerLitre => $composableBuilder(
    column: $table.mileageKmPerLitre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fuelCostMinorUnits => $composableBuilder(
    column: $table.fuelCostMinorUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get calculationVersion => $composableBuilder(
    column: $table.calculationVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get calculatedAt => $composableBuilder(
    column: $table.calculatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FuelEntriesTableFilterComposer get startFuelEntryId {
    final $$FuelEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.startFuelEntryId,
      referencedTable: $db.fuelEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelEntriesTableFilterComposer(
            $db: $db,
            $table: $db.fuelEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FuelEntriesTableFilterComposer get endFuelEntryId {
    final $$FuelEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.endFuelEntryId,
      referencedTable: $db.fuelEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelEntriesTableFilterComposer(
            $db: $db,
            $table: $db.fuelEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MileageIntervalsTableOrderingComposer
    extends Composer<_$AppDatabase, $MileageIntervalsTable> {
  $$MileageIntervalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get startOdometerKm => $composableBuilder(
    column: $table.startOdometerKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get endOdometerKm => $composableBuilder(
    column: $table.endOdometerKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fuelConsumedLitres => $composableBuilder(
    column: $table.fuelConsumedLitres,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mileageKmPerLitre => $composableBuilder(
    column: $table.mileageKmPerLitre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fuelCostMinorUnits => $composableBuilder(
    column: $table.fuelCostMinorUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get calculationVersion => $composableBuilder(
    column: $table.calculationVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get calculatedAt => $composableBuilder(
    column: $table.calculatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FuelEntriesTableOrderingComposer get startFuelEntryId {
    final $$FuelEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.startFuelEntryId,
      referencedTable: $db.fuelEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.fuelEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FuelEntriesTableOrderingComposer get endFuelEntryId {
    final $$FuelEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.endFuelEntryId,
      referencedTable: $db.fuelEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.fuelEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MileageIntervalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MileageIntervalsTable> {
  $$MileageIntervalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get startOdometerKm => $composableBuilder(
    column: $table.startOdometerKm,
    builder: (column) => column,
  );

  GeneratedColumn<double> get endOdometerKm => $composableBuilder(
    column: $table.endOdometerKm,
    builder: (column) => column,
  );

  GeneratedColumn<double> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fuelConsumedLitres => $composableBuilder(
    column: $table.fuelConsumedLitres,
    builder: (column) => column,
  );

  GeneratedColumn<double> get mileageKmPerLitre => $composableBuilder(
    column: $table.mileageKmPerLitre,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fuelCostMinorUnits => $composableBuilder(
    column: $table.fuelCostMinorUnits,
    builder: (column) => column,
  );

  GeneratedColumn<int> get calculationVersion => $composableBuilder(
    column: $table.calculationVersion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get calculatedAt => $composableBuilder(
    column: $table.calculatedAt,
    builder: (column) => column,
  );

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FuelEntriesTableAnnotationComposer get startFuelEntryId {
    final $$FuelEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.startFuelEntryId,
      referencedTable: $db.fuelEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.fuelEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$FuelEntriesTableAnnotationComposer get endFuelEntryId {
    final $$FuelEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.endFuelEntryId,
      referencedTable: $db.fuelEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FuelEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.fuelEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MileageIntervalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MileageIntervalsTable,
          MileageIntervalData,
          $$MileageIntervalsTableFilterComposer,
          $$MileageIntervalsTableOrderingComposer,
          $$MileageIntervalsTableAnnotationComposer,
          $$MileageIntervalsTableCreateCompanionBuilder,
          $$MileageIntervalsTableUpdateCompanionBuilder,
          (MileageIntervalData, $$MileageIntervalsTableReferences),
          MileageIntervalData,
          PrefetchHooks Function({
            bool vehicleId,
            bool startFuelEntryId,
            bool endFuelEntryId,
          })
        > {
  $$MileageIntervalsTableTableManager(
    _$AppDatabase db,
    $MileageIntervalsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MileageIntervalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MileageIntervalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MileageIntervalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<String> startFuelEntryId = const Value.absent(),
                Value<String> endFuelEntryId = const Value.absent(),
                Value<double> startOdometerKm = const Value.absent(),
                Value<double> endOdometerKm = const Value.absent(),
                Value<double> distanceKm = const Value.absent(),
                Value<double> fuelConsumedLitres = const Value.absent(),
                Value<double> mileageKmPerLitre = const Value.absent(),
                Value<int> fuelCostMinorUnits = const Value.absent(),
                Value<int> calculationVersion = const Value.absent(),
                Value<DateTime> calculatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MileageIntervalsCompanion(
                id: id,
                vehicleId: vehicleId,
                startFuelEntryId: startFuelEntryId,
                endFuelEntryId: endFuelEntryId,
                startOdometerKm: startOdometerKm,
                endOdometerKm: endOdometerKm,
                distanceKm: distanceKm,
                fuelConsumedLitres: fuelConsumedLitres,
                mileageKmPerLitre: mileageKmPerLitre,
                fuelCostMinorUnits: fuelCostMinorUnits,
                calculationVersion: calculationVersion,
                calculatedAt: calculatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehicleId,
                required String startFuelEntryId,
                required String endFuelEntryId,
                required double startOdometerKm,
                required double endOdometerKm,
                required double distanceKm,
                required double fuelConsumedLitres,
                required double mileageKmPerLitre,
                required int fuelCostMinorUnits,
                Value<int> calculationVersion = const Value.absent(),
                required DateTime calculatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MileageIntervalsCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                startFuelEntryId: startFuelEntryId,
                endFuelEntryId: endFuelEntryId,
                startOdometerKm: startOdometerKm,
                endOdometerKm: endOdometerKm,
                distanceKm: distanceKm,
                fuelConsumedLitres: fuelConsumedLitres,
                mileageKmPerLitre: mileageKmPerLitre,
                fuelCostMinorUnits: fuelCostMinorUnits,
                calculationVersion: calculationVersion,
                calculatedAt: calculatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MileageIntervalsTable, MileageIntervalData>(
                    table,
                  ),
                  $$MileageIntervalsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                vehicleId = false,
                startFuelEntryId = false,
                endFuelEntryId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (vehicleId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.vehicleId,
                            referencedTable: $$MileageIntervalsTableReferences
                                ._vehicleIdTable(db),
                            referencedColumn: $$MileageIntervalsTableReferences
                                ._vehicleIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (startFuelEntryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.startFuelEntryId,
                            referencedTable: $$MileageIntervalsTableReferences
                                ._startFuelEntryIdTable(db),
                            referencedColumn: $$MileageIntervalsTableReferences
                                ._startFuelEntryIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (endFuelEntryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.endFuelEntryId,
                            referencedTable: $$MileageIntervalsTableReferences
                                ._endFuelEntryIdTable(db),
                            referencedColumn: $$MileageIntervalsTableReferences
                                ._endFuelEntryIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$MileageIntervalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MileageIntervalsTable,
      MileageIntervalData,
      $$MileageIntervalsTableFilterComposer,
      $$MileageIntervalsTableOrderingComposer,
      $$MileageIntervalsTableAnnotationComposer,
      $$MileageIntervalsTableCreateCompanionBuilder,
      $$MileageIntervalsTableUpdateCompanionBuilder,
      (MileageIntervalData, $$MileageIntervalsTableReferences),
      MileageIntervalData,
      PrefetchHooks Function({
        bool vehicleId,
        bool startFuelEntryId,
        bool endFuelEntryId,
      })
    >;
typedef $$MaintenanceRecordsTableCreateCompanionBuilder =
    MaintenanceRecordsCompanion Function({
      required String id,
      required String vehicleId,
      required String category,
      required String description,
      required int amountMinorUnits,
      required DateTime serviceDate,
      required double odometerKm,
      Value<DateTime?> nextServiceDate,
      Value<double?> nextServiceOdometerKm,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$MaintenanceRecordsTableUpdateCompanionBuilder =
    MaintenanceRecordsCompanion Function({
      Value<String> id,
      Value<String> vehicleId,
      Value<String> category,
      Value<String> description,
      Value<int> amountMinorUnits,
      Value<DateTime> serviceDate,
      Value<double> odometerKm,
      Value<DateTime?> nextServiceDate,
      Value<double?> nextServiceOdometerKm,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$MaintenanceRecordsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MaintenanceRecordsTable,
          MaintenanceRecordData
        > {
  $$MaintenanceRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('maintenance_records__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RemindersTable, List<ReminderData>>
  _remindersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reminders,
    aliasName: 'maintenance_records__id__reminders__maintenance_record_id',
  );

  $$RemindersTableProcessedTableManager get remindersRefs {
    final manager = $$RemindersTableTableManager($_db, $_db.reminders).filter(
      (f) => f.maintenanceRecordId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_remindersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MaintenanceRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $MaintenanceRecordsTable> {
  $$MaintenanceRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinorUnits => $composableBuilder(
    column: $table.amountMinorUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get serviceDate => $composableBuilder(
    column: $table.serviceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextServiceDate => $composableBuilder(
    column: $table.nextServiceDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get nextServiceOdometerKm => $composableBuilder(
    column: $table.nextServiceOdometerKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> remindersRefs(
    Expression<bool> Function($$RemindersTableFilterComposer f) f,
  ) {
    final $$RemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.maintenanceRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableFilterComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MaintenanceRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $MaintenanceRecordsTable> {
  $$MaintenanceRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinorUnits => $composableBuilder(
    column: $table.amountMinorUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get serviceDate => $composableBuilder(
    column: $table.serviceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextServiceDate => $composableBuilder(
    column: $table.nextServiceDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get nextServiceOdometerKm => $composableBuilder(
    column: $table.nextServiceOdometerKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaintenanceRecordsTable> {
  $$MaintenanceRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountMinorUnits => $composableBuilder(
    column: $table.amountMinorUnits,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get serviceDate => $composableBuilder(
    column: $table.serviceDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get odometerKm => $composableBuilder(
    column: $table.odometerKm,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextServiceDate => $composableBuilder(
    column: $table.nextServiceDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get nextServiceOdometerKm => $composableBuilder(
    column: $table.nextServiceOdometerKm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> remindersRefs<T extends Object>(
    Expression<T> Function($$RemindersTableAnnotationComposer a) f,
  ) {
    final $$RemindersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.maintenanceRecordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableAnnotationComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MaintenanceRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaintenanceRecordsTable,
          MaintenanceRecordData,
          $$MaintenanceRecordsTableFilterComposer,
          $$MaintenanceRecordsTableOrderingComposer,
          $$MaintenanceRecordsTableAnnotationComposer,
          $$MaintenanceRecordsTableCreateCompanionBuilder,
          $$MaintenanceRecordsTableUpdateCompanionBuilder,
          (MaintenanceRecordData, $$MaintenanceRecordsTableReferences),
          MaintenanceRecordData,
          PrefetchHooks Function({bool vehicleId, bool remindersRefs})
        > {
  $$MaintenanceRecordsTableTableManager(
    _$AppDatabase db,
    $MaintenanceRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenanceRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaintenanceRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MaintenanceRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> amountMinorUnits = const Value.absent(),
                Value<DateTime> serviceDate = const Value.absent(),
                Value<double> odometerKm = const Value.absent(),
                Value<DateTime?> nextServiceDate = const Value.absent(),
                Value<double?> nextServiceOdometerKm = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MaintenanceRecordsCompanion(
                id: id,
                vehicleId: vehicleId,
                category: category,
                description: description,
                amountMinorUnits: amountMinorUnits,
                serviceDate: serviceDate,
                odometerKm: odometerKm,
                nextServiceDate: nextServiceDate,
                nextServiceOdometerKm: nextServiceOdometerKm,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehicleId,
                required String category,
                required String description,
                required int amountMinorUnits,
                required DateTime serviceDate,
                required double odometerKm,
                Value<DateTime?> nextServiceDate = const Value.absent(),
                Value<double?> nextServiceOdometerKm = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MaintenanceRecordsCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                category: category,
                description: description,
                amountMinorUnits: amountMinorUnits,
                serviceDate: serviceDate,
                odometerKm: odometerKm,
                nextServiceDate: nextServiceDate,
                nextServiceOdometerKm: nextServiceOdometerKm,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MaintenanceRecordsTable, MaintenanceRecordData>(
                    table,
                  ),
                  $$MaintenanceRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false, remindersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (remindersRefs) db.reminders],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.vehicleId,
                        referencedTable: $$MaintenanceRecordsTableReferences
                            ._vehicleIdTable(db),
                        referencedColumn: $$MaintenanceRecordsTableReferences
                            ._vehicleIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (remindersRefs)
                    await $_getPrefetchedDataByColumns<
                      MaintenanceRecordData,
                      $MaintenanceRecordsTable,
                      ReminderData,
                      $RemindersTable
                    >(
                      currentTable: table,
                      referencedTable: $$MaintenanceRecordsTableReferences
                          ._remindersRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MaintenanceRecordsTableReferences(
                            db,
                            table,
                            p0,
                          ).remindersRefs,
                      currentColumn: 'id',
                      referencedColumn: 'maintenance_record_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MaintenanceRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaintenanceRecordsTable,
      MaintenanceRecordData,
      $$MaintenanceRecordsTableFilterComposer,
      $$MaintenanceRecordsTableOrderingComposer,
      $$MaintenanceRecordsTableAnnotationComposer,
      $$MaintenanceRecordsTableCreateCompanionBuilder,
      $$MaintenanceRecordsTableUpdateCompanionBuilder,
      (MaintenanceRecordData, $$MaintenanceRecordsTableReferences),
      MaintenanceRecordData,
      PrefetchHooks Function({bool vehicleId, bool remindersRefs})
    >;
typedef $$FuelBudgetsTableCreateCompanionBuilder =
    FuelBudgetsCompanion Function({
      required String id,
      Value<String?> vehicleId,
      required int monthlyLimitMinorUnits,
      Value<int> warningThresholdPercent,
      Value<String> period,
      Value<bool> isEnabled,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$FuelBudgetsTableUpdateCompanionBuilder =
    FuelBudgetsCompanion Function({
      Value<String> id,
      Value<String?> vehicleId,
      Value<int> monthlyLimitMinorUnits,
      Value<int> warningThresholdPercent,
      Value<String> period,
      Value<bool> isEnabled,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$FuelBudgetsTableReferences
    extends BaseReferences<_$AppDatabase, $FuelBudgetsTable, FuelBudgetData> {
  $$FuelBudgetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('fuel_budgets__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager? get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id');
    if ($_column == null) return null;
    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FuelBudgetsTableFilterComposer
    extends Composer<_$AppDatabase, $FuelBudgetsTable> {
  $$FuelBudgetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get monthlyLimitMinorUnits => $composableBuilder(
    column: $table.monthlyLimitMinorUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get warningThresholdPercent => $composableBuilder(
    column: $table.warningThresholdPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelBudgetsTableOrderingComposer
    extends Composer<_$AppDatabase, $FuelBudgetsTable> {
  $$FuelBudgetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monthlyLimitMinorUnits => $composableBuilder(
    column: $table.monthlyLimitMinorUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get warningThresholdPercent => $composableBuilder(
    column: $table.warningThresholdPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get period => $composableBuilder(
    column: $table.period,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelBudgetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FuelBudgetsTable> {
  $$FuelBudgetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get monthlyLimitMinorUnits => $composableBuilder(
    column: $table.monthlyLimitMinorUnits,
    builder: (column) => column,
  );

  GeneratedColumn<int> get warningThresholdPercent => $composableBuilder(
    column: $table.warningThresholdPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get period =>
      $composableBuilder(column: $table.period, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FuelBudgetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FuelBudgetsTable,
          FuelBudgetData,
          $$FuelBudgetsTableFilterComposer,
          $$FuelBudgetsTableOrderingComposer,
          $$FuelBudgetsTableAnnotationComposer,
          $$FuelBudgetsTableCreateCompanionBuilder,
          $$FuelBudgetsTableUpdateCompanionBuilder,
          (FuelBudgetData, $$FuelBudgetsTableReferences),
          FuelBudgetData,
          PrefetchHooks Function({bool vehicleId})
        > {
  $$FuelBudgetsTableTableManager(_$AppDatabase db, $FuelBudgetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FuelBudgetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FuelBudgetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FuelBudgetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> vehicleId = const Value.absent(),
                Value<int> monthlyLimitMinorUnits = const Value.absent(),
                Value<int> warningThresholdPercent = const Value.absent(),
                Value<String> period = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FuelBudgetsCompanion(
                id: id,
                vehicleId: vehicleId,
                monthlyLimitMinorUnits: monthlyLimitMinorUnits,
                warningThresholdPercent: warningThresholdPercent,
                period: period,
                isEnabled: isEnabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> vehicleId = const Value.absent(),
                required int monthlyLimitMinorUnits,
                Value<int> warningThresholdPercent = const Value.absent(),
                Value<String> period = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => FuelBudgetsCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                monthlyLimitMinorUnits: monthlyLimitMinorUnits,
                warningThresholdPercent: warningThresholdPercent,
                period: period,
                isEnabled: isEnabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FuelBudgetsTable, FuelBudgetData>(table),
                  $$FuelBudgetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehicleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehicleId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.vehicleId,
                        referencedTable: $$FuelBudgetsTableReferences
                            ._vehicleIdTable(db),
                        referencedColumn: $$FuelBudgetsTableReferences
                            ._vehicleIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FuelBudgetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FuelBudgetsTable,
      FuelBudgetData,
      $$FuelBudgetsTableFilterComposer,
      $$FuelBudgetsTableOrderingComposer,
      $$FuelBudgetsTableAnnotationComposer,
      $$FuelBudgetsTableCreateCompanionBuilder,
      $$FuelBudgetsTableUpdateCompanionBuilder,
      (FuelBudgetData, $$FuelBudgetsTableReferences),
      FuelBudgetData,
      PrefetchHooks Function({bool vehicleId})
    >;
typedef $$RemindersTableCreateCompanionBuilder = RemindersCompanion Function({
  required String id,
  required String vehicleId,
  Value<String?> maintenanceRecordId,
  required String reminderType,
  Value<DateTime?> scheduledDate,
  Value<double?> odometerThresholdKm,
  Value<bool> isEnabled,
  Value<DateTime?> lastTriggeredAt,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$RemindersTableUpdateCompanionBuilder = RemindersCompanion Function({
  Value<String> id,
  Value<String> vehicleId,
  Value<String?> maintenanceRecordId,
  Value<String> reminderType,
  Value<DateTime?> scheduledDate,
  Value<double?> odometerThresholdKm,
  Value<bool> isEnabled,
  Value<DateTime?> lastTriggeredAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$RemindersTableReferences
    extends BaseReferences<_$AppDatabase, $RemindersTable, ReminderData> {
  $$RemindersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiclesTable _vehicleIdTable(_$AppDatabase db) =>
      db.vehicles.createAlias('reminders__vehicle_id__vehicles__id');

  $$VehiclesTableProcessedTableManager get vehicleId {
    final $_column = $_itemColumn<String>('vehicle_id')!;

    final manager = $$VehiclesTableTableManager(
      $_db,
      $_db.vehicles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehicleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MaintenanceRecordsTable _maintenanceRecordIdTable(_$AppDatabase db) =>
      db.maintenanceRecords.createAlias(
        'reminders__maintenance_record_id__maintenance_records__id',
      );

  $$MaintenanceRecordsTableProcessedTableManager? get maintenanceRecordId {
    final $_column = $_itemColumn<String>('maintenance_record_id');
    if ($_column == null) return null;
    final manager = $$MaintenanceRecordsTableTableManager(
      $_db,
      $_db.maintenanceRecords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_maintenanceRecordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reminderType => $composableBuilder(
    column: $table.reminderType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get odometerThresholdKm => $composableBuilder(
    column: $table.odometerThresholdKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastTriggeredAt => $composableBuilder(
    column: $table.lastTriggeredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiclesTableFilterComposer get vehicleId {
    final $$VehiclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableFilterComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MaintenanceRecordsTableFilterComposer get maintenanceRecordId {
    final $$MaintenanceRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.maintenanceRecordId,
      referencedTable: $db.maintenanceRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceRecordsTableFilterComposer(
            $db: $db,
            $table: $db.maintenanceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderType => $composableBuilder(
    column: $table.reminderType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get odometerThresholdKm => $composableBuilder(
    column: $table.odometerThresholdKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastTriggeredAt => $composableBuilder(
    column: $table.lastTriggeredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiclesTableOrderingComposer get vehicleId {
    final $$VehiclesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MaintenanceRecordsTableOrderingComposer get maintenanceRecordId {
    final $$MaintenanceRecordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.maintenanceRecordId,
      referencedTable: $db.maintenanceRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceRecordsTableOrderingComposer(
            $db: $db,
            $table: $db.maintenanceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reminderType => $composableBuilder(
    column: $table.reminderType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get scheduledDate => $composableBuilder(
    column: $table.scheduledDate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get odometerThresholdKm => $composableBuilder(
    column: $table.odometerThresholdKm,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<DateTime> get lastTriggeredAt => $composableBuilder(
    column: $table.lastTriggeredAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$VehiclesTableAnnotationComposer get vehicleId {
    final $$VehiclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehicleId,
      referencedTable: $db.vehicles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiclesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MaintenanceRecordsTableAnnotationComposer get maintenanceRecordId {
    final $$MaintenanceRecordsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.maintenanceRecordId,
          referencedTable: $db.maintenanceRecords,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MaintenanceRecordsTableAnnotationComposer(
                $db: $db,
                $table: $db.maintenanceRecords,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$RemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTable,
          ReminderData,
          $$RemindersTableFilterComposer,
          $$RemindersTableOrderingComposer,
          $$RemindersTableAnnotationComposer,
          $$RemindersTableCreateCompanionBuilder,
          $$RemindersTableUpdateCompanionBuilder,
          (ReminderData, $$RemindersTableReferences),
          ReminderData,
          PrefetchHooks Function({bool vehicleId, bool maintenanceRecordId})
        > {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehicleId = const Value.absent(),
                Value<String?> maintenanceRecordId = const Value.absent(),
                Value<String> reminderType = const Value.absent(),
                Value<DateTime?> scheduledDate = const Value.absent(),
                Value<double?> odometerThresholdKm = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<DateTime?> lastTriggeredAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion(
                id: id,
                vehicleId: vehicleId,
                maintenanceRecordId: maintenanceRecordId,
                reminderType: reminderType,
                scheduledDate: scheduledDate,
                odometerThresholdKm: odometerThresholdKm,
                isEnabled: isEnabled,
                lastTriggeredAt: lastTriggeredAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehicleId,
                Value<String?> maintenanceRecordId = const Value.absent(),
                required String reminderType,
                Value<DateTime?> scheduledDate = const Value.absent(),
                Value<double?> odometerThresholdKm = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<DateTime?> lastTriggeredAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion.insert(
                id: id,
                vehicleId: vehicleId,
                maintenanceRecordId: maintenanceRecordId,
                reminderType: reminderType,
                scheduledDate: scheduledDate,
                odometerThresholdKm: odometerThresholdKm,
                isEnabled: isEnabled,
                lastTriggeredAt: lastTriggeredAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RemindersTable, ReminderData>(table),
                  $$RemindersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({vehicleId = false, maintenanceRecordId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (vehicleId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.vehicleId,
                            referencedTable: $$RemindersTableReferences
                                ._vehicleIdTable(db),
                            referencedColumn: $$RemindersTableReferences
                                ._vehicleIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (maintenanceRecordId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.maintenanceRecordId,
                            referencedTable: $$RemindersTableReferences
                                ._maintenanceRecordIdTable(db),
                            referencedColumn: $$RemindersTableReferences
                                ._maintenanceRecordIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$RemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTable,
      ReminderData,
      $$RemindersTableFilterComposer,
      $$RemindersTableOrderingComposer,
      $$RemindersTableAnnotationComposer,
      $$RemindersTableCreateCompanionBuilder,
      $$RemindersTableUpdateCompanionBuilder,
      (ReminderData, $$RemindersTableReferences),
      ReminderData,
      PrefetchHooks Function({bool vehicleId, bool maintenanceRecordId})
    >;
typedef $$BackupMetadatasTableCreateCompanionBuilder =
    BackupMetadatasCompanion Function({
      required String id,
      required String provider,
      Value<DateTime?> lastBackupAt,
      Value<DateTime?> lastSuccessfulSyncAt,
      Value<String> syncStatus,
      Value<int> schemaVersion,
      Value<int> rowid,
    });
typedef $$BackupMetadatasTableUpdateCompanionBuilder =
    BackupMetadatasCompanion Function({
      Value<String> id,
      Value<String> provider,
      Value<DateTime?> lastBackupAt,
      Value<DateTime?> lastSuccessfulSyncAt,
      Value<String> syncStatus,
      Value<int> schemaVersion,
      Value<int> rowid,
    });

class $$BackupMetadatasTableFilterComposer
    extends Composer<_$AppDatabase, $BackupMetadatasTable> {
  $$BackupMetadatasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSuccessfulSyncAt => $composableBuilder(
    column: $table.lastSuccessfulSyncAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BackupMetadatasTableOrderingComposer
    extends Composer<_$AppDatabase, $BackupMetadatasTable> {
  $$BackupMetadatasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSuccessfulSyncAt => $composableBuilder(
    column: $table.lastSuccessfulSyncAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BackupMetadatasTableAnnotationComposer
    extends Composer<_$AppDatabase, $BackupMetadatasTable> {
  $$BackupMetadatasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSuccessfulSyncAt => $composableBuilder(
    column: $table.lastSuccessfulSyncAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get schemaVersion => $composableBuilder(
    column: $table.schemaVersion,
    builder: (column) => column,
  );
}

class $$BackupMetadatasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BackupMetadatasTable,
          BackupMetadataData,
          $$BackupMetadatasTableFilterComposer,
          $$BackupMetadatasTableOrderingComposer,
          $$BackupMetadatasTableAnnotationComposer,
          $$BackupMetadatasTableCreateCompanionBuilder,
          $$BackupMetadatasTableUpdateCompanionBuilder,
          (
            BackupMetadataData,
            BaseReferences<
              _$AppDatabase,
              $BackupMetadatasTable,
              BackupMetadataData
            >,
          ),
          BackupMetadataData,
          PrefetchHooks Function()
        > {
  $$BackupMetadatasTableTableManager(
    _$AppDatabase db,
    $BackupMetadatasTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BackupMetadatasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BackupMetadatasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BackupMetadatasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> provider = const Value.absent(),
                Value<DateTime?> lastBackupAt = const Value.absent(),
                Value<DateTime?> lastSuccessfulSyncAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> schemaVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BackupMetadatasCompanion(
                id: id,
                provider: provider,
                lastBackupAt: lastBackupAt,
                lastSuccessfulSyncAt: lastSuccessfulSyncAt,
                syncStatus: syncStatus,
                schemaVersion: schemaVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String provider,
                Value<DateTime?> lastBackupAt = const Value.absent(),
                Value<DateTime?> lastSuccessfulSyncAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> schemaVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BackupMetadatasCompanion.insert(
                id: id,
                provider: provider,
                lastBackupAt: lastBackupAt,
                lastSuccessfulSyncAt: lastSuccessfulSyncAt,
                syncStatus: syncStatus,
                schemaVersion: schemaVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BackupMetadatasTable, BackupMetadataData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $BackupMetadatasTable,
                    BackupMetadataData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BackupMetadatasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BackupMetadatasTable,
      BackupMetadataData,
      $$BackupMetadatasTableFilterComposer,
      $$BackupMetadatasTableOrderingComposer,
      $$BackupMetadatasTableAnnotationComposer,
      $$BackupMetadatasTableCreateCompanionBuilder,
      $$BackupMetadatasTableUpdateCompanionBuilder,
      (
        BackupMetadataData,
        BaseReferences<
          _$AppDatabase,
          $BackupMetadatasTable,
          BackupMetadataData
        >,
      ),
      BackupMetadataData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db, _db.vehicles);
  $$FuelEntriesTableTableManager get fuelEntries =>
      $$FuelEntriesTableTableManager(_db, _db.fuelEntries);
  $$MileageIntervalsTableTableManager get mileageIntervals =>
      $$MileageIntervalsTableTableManager(_db, _db.mileageIntervals);
  $$MaintenanceRecordsTableTableManager get maintenanceRecords =>
      $$MaintenanceRecordsTableTableManager(_db, _db.maintenanceRecords);
  $$FuelBudgetsTableTableManager get fuelBudgets =>
      $$FuelBudgetsTableTableManager(_db, _db.fuelBudgets);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$BackupMetadatasTableTableManager get backupMetadatas =>
      $$BackupMetadatasTableTableManager(_db, _db.backupMetadatas);
}
