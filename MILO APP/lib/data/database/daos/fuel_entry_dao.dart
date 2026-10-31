import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/fuel_entries_table.dart';

part 'fuel_entry_dao.g.dart';

@DriftAccessor(tables: [FuelEntries])
class FuelEntryDao extends DatabaseAccessor<AppDatabase>
    with _$FuelEntryDaoMixin {
  FuelEntryDao(super.db);

  Future<List<FuelEntryData>> getEntriesForVehicle(String vehicleId) {
    return (select(fuelEntries)
          ..where((tbl) => tbl.vehicleId.equals(vehicleId))
          ..orderBy([
            (tbl) => OrderingTerm.asc(tbl.timestamp),
            (tbl) => OrderingTerm.asc(tbl.odometerKm),
          ]))
        .get();
  }

  Stream<List<FuelEntryData>> watchEntriesForVehicle(String vehicleId) {
    return (select(fuelEntries)
          ..where((tbl) => tbl.vehicleId.equals(vehicleId))
          ..orderBy([
            (tbl) => OrderingTerm.desc(tbl.timestamp),
            (tbl) => OrderingTerm.desc(tbl.odometerKm),
          ]))
        .watch();
  }

  Future<List<FuelEntryData>> getAllEntries() {
    return (select(fuelEntries)..orderBy([
          (tbl) => OrderingTerm.desc(tbl.timestamp),
          (tbl) => OrderingTerm.desc(tbl.odometerKm),
        ]))
        .get();
  }

  Future<FuelEntryData?> getEntryById(String id) {
    return (select(
      fuelEntries,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<double?> getLatestOdometer(String vehicleId) async {
    final latest =
        await (select(fuelEntries)
              ..where((tbl) => tbl.vehicleId.equals(vehicleId))
              ..orderBy([(tbl) => OrderingTerm.desc(tbl.odometerKm)])
              ..limit(1))
            .getSingleOrNull();
    return latest?.odometerKm;
  }

  Future<int> insertEntry(FuelEntriesCompanion entry) {
    return into(fuelEntries).insert(entry);
  }

  Future<bool> updateEntry(FuelEntriesCompanion entry) async {
    final count = await (update(fuelEntries)
          ..where((tbl) => tbl.id.equals(entry.id.value)))
        .write(entry);
    return count > 0;
  }

  Future<int> deleteEntry(String id) {
    return (delete(fuelEntries)..where((tbl) => tbl.id.equals(id))).go();
  }
}
