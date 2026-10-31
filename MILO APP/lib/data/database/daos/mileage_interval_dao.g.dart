// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mileage_interval_dao.dart';

// ignore_for_file: type=lint
mixin _$MileageIntervalDaoMixin on DatabaseAccessor<AppDatabase> {
  $VehiclesTable get vehicles => attachedDatabase.vehicles;
  $FuelEntriesTable get fuelEntries => attachedDatabase.fuelEntries;
  $MileageIntervalsTable get mileageIntervals =>
      attachedDatabase.mileageIntervals;
  MileageIntervalDaoManager get managers => MileageIntervalDaoManager(this);
}

class MileageIntervalDaoManager {
  final _$MileageIntervalDaoMixin _db;
  MileageIntervalDaoManager(this._db);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db.attachedDatabase, _db.vehicles);
  $$FuelEntriesTableTableManager get fuelEntries =>
      $$FuelEntriesTableTableManager(_db.attachedDatabase, _db.fuelEntries);
  $$MileageIntervalsTableTableManager get mileageIntervals =>
      $$MileageIntervalsTableTableManager(
        _db.attachedDatabase,
        _db.mileageIntervals,
      );
}
