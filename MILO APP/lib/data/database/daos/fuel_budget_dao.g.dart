// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fuel_budget_dao.dart';

// ignore_for_file: type=lint
mixin _$FuelBudgetDaoMixin on DatabaseAccessor<AppDatabase> {
  $VehiclesTable get vehicles => attachedDatabase.vehicles;
  $FuelBudgetsTable get fuelBudgets => attachedDatabase.fuelBudgets;
  FuelBudgetDaoManager get managers => FuelBudgetDaoManager(this);
}

class FuelBudgetDaoManager {
  final _$FuelBudgetDaoMixin _db;
  FuelBudgetDaoManager(this._db);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db.attachedDatabase, _db.vehicles);
  $$FuelBudgetsTableTableManager get fuelBudgets =>
      $$FuelBudgetsTableTableManager(_db.attachedDatabase, _db.fuelBudgets);
}
