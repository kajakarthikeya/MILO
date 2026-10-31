// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_entry_dao.dart';

// ignore_for_file: type=lint
mixin _$FuelEntryDaoMixin on DatabaseAccessor<AppDatabase> {
  $VehiclesTable get vehicles => attachedDatabase.vehicles;
  $FuelEntriesTable get fuelEntries => attachedDatabase.fuelEntries;
  FuelEntryDaoManager get managers => FuelEntryDaoManager(this);
}

class FuelEntryDaoManager {
  final _$FuelEntryDaoMixin _db;
  FuelEntryDaoManager(this._db);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db.attachedDatabase, _db.vehicles);
  $$FuelEntriesTableTableManager get fuelEntries =>
      $$FuelEntriesTableTableManager(_db.attachedDatabase, _db.fuelEntries);
}
