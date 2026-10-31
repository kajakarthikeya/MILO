import 'package:drift/drift.dart';

import 'vehicles_table.dart';

@DataClassName('MaintenanceRecordData')
class MaintenanceRecords extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId =>
      text().references(Vehicles, #id, onDelete: KeyAction.cascade)();
  TextColumn get category => text()(); // 'Engine oil', 'Tyres', 'Brakes', etc.
  TextColumn get description => text()();
  IntColumn get amountMinorUnits => integer()();
  DateTimeColumn get serviceDate => dateTime()();
  RealColumn get odometerKm => real()();
  DateTimeColumn get nextServiceDate => dateTime().nullable()();
  RealColumn get nextServiceOdometerKm => real().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
