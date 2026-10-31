import 'package:drift/drift.dart';

import 'vehicles_table.dart';
import 'maintenance_records_table.dart';

@DataClassName('ReminderData')
class Reminders extends Table {
  TextColumn get id => text()();
  TextColumn get vehicleId =>
      text().references(Vehicles, #id, onDelete: KeyAction.cascade)();
  TextColumn get maintenanceRecordId => text().nullable().references(
    MaintenanceRecords,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get reminderType => text()(); // 'date' or 'odometer'
  DateTimeColumn get scheduledDate => dateTime().nullable()();
  RealColumn get odometerThresholdKm => real().nullable()();
  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
  DateTimeColumn get lastTriggeredAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
