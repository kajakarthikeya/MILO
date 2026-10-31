import 'package:drift/drift.dart';

import 'vehicles_table.dart';

@DataClassName('FuelEntryData')
class FuelEntries extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId =>
      text().references(Vehicles, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get timestamp => dateTime()();
  RealColumn get odometerKm => real()();
  IntColumn get amountPaidMinorUnits =>
      integer()(); // e.g., paise (1 INR = 100 paise)
  RealColumn get fuelQuantity => real()(); // Litres
  IntColumn get unitPriceMinorUnitsPerLitre =>
      integer()(); // Price in paise per litre
  TextColumn get entryMethod => text()(); // 'byMoney' or 'byLitres'
  TextColumn get fillType => text()(); // 'full' or 'partial'
  TextColumn get stationName => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
