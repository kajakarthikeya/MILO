import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import '../../core/storage/storage_config.dart';
import 'tables/user_profiles_table.dart';
import 'tables/vehicles_table.dart';
import 'tables/fuel_entries_table.dart';
import 'tables/mileage_intervals_table.dart';
import 'tables/maintenance_records_table.dart';
import 'tables/fuel_budget_table.dart';
import 'tables/reminder_table.dart';
import 'tables/backup_metadata_table.dart';

import 'daos/vehicle_dao.dart';
import 'daos/fuel_entry_dao.dart';
import 'daos/mileage_interval_dao.dart';
import 'daos/maintenance_dao.dart';
import 'daos/fuel_budget_dao.dart';
import 'daos/user_profile_dao.dart';
import 'daos/reminder_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    UserProfiles,
    Vehicles,
    FuelEntries,
    MileageIntervals,
    MaintenanceRecords,
    FuelBudgets,
    Reminders,
    BackupMetadatas,
  ],
  daos: [
    VehicleDao,
    FuelEntryDao,
    MileageIntervalDao,
    MaintenanceDao,
    FuelBudgetDao,
    UserProfileDao,
    ReminderDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  /// In-memory database constructor for testing
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // Future migrations will be added here
    },
    beforeOpen: (details) async {
      // Strict enforcement of SQLite foreign key constraints
      await customStatement('PRAGMA foreign_keys = ON;');
    },
  );

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbPath = await StorageConfig.getDatabasePath();
      final file = File(dbPath);
      return NativeDatabase.createInBackground(file);
    });
  }
}
