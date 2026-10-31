import 'package:drift/drift.dart';

import 'vehicles_table.dart';
import 'fuel_entries_table.dart';

@DataClassName('MileageIntervalData')
class MileageIntervals extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId =>
      text().references(Vehicles, #id, onDelete: KeyAction.cascade)();

  @ReferenceName('startMileageIntervals')
  TextColumn get startFuelEntryId =>
      text().references(FuelEntries, #id, onDelete: KeyAction.cascade)();

  @ReferenceName('endMileageIntervals')
  TextColumn get endFuelEntryId =>
      text().references(FuelEntries, #id, onDelete: KeyAction.cascade)();

  RealColumn get startOdometerKm => real()();
  RealColumn get endOdometerKm => real()();
  RealColumn get distanceKm => real()();
  RealColumn get fuelConsumedLitres => real()();
  RealColumn get mileageKmPerLitre => real()();
  IntColumn get fuelCostMinorUnits => integer()();
  IntColumn get calculationVersion =>
      integer().withDefault(const Constant(1))();
  DateTimeColumn get calculatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
