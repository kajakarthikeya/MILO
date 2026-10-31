import 'package:drift/drift.dart';

import 'vehicles_table.dart';

@DataClassName('FuelBudgetData')
class FuelBudgets extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId => text().nullable().references(
    Vehicles,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get monthlyLimitMinorUnits => integer()();
  IntColumn get warningThresholdPercent =>
      integer().withDefault(const Constant(80))();
  TextColumn get period => text().withDefault(const Constant('monthly'))();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
