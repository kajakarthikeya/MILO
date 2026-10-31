import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/reminder_table.dart';

part 'reminder_dao.g.dart';

@DriftAccessor(tables: [Reminders])
class ReminderDao extends DatabaseAccessor<AppDatabase>
    with _$ReminderDaoMixin {
  ReminderDao(super.db);

  Future<List<ReminderData>> getRemindersForVehicle(String vehicleId) {
    return (select(
      reminders,
    )..where((tbl) => tbl.vehicleId.equals(vehicleId))).get();
  }

  Stream<List<ReminderData>> watchRemindersForVehicle(String vehicleId) {
    return (select(
      reminders,
    )..where((tbl) => tbl.vehicleId.equals(vehicleId))).watch();
  }

  Future<List<ReminderData>> getAllActiveReminders() {
    return (select(
      reminders,
    )..where((tbl) => tbl.isEnabled.equals(true))).get();
  }

  Future<int> insertReminder(RemindersCompanion reminder) {
    return into(reminders).insert(reminder);
  }

  Future<bool> updateReminder(RemindersCompanion reminder) {
    return update(reminders).replace(reminder);
  }

  Future<int> deleteReminder(String id) {
    return (delete(reminders)..where((tbl) => tbl.id.equals(id))).go();
  }
}
