import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/mileage_intervals_table.dart';

part 'mileage_interval_dao.g.dart';

@DriftAccessor(tables: [MileageIntervals])
class MileageIntervalDao extends DatabaseAccessor<AppDatabase>
    with _$MileageIntervalDaoMixin {
  MileageIntervalDao(super.db);

  Future<List<MileageIntervalData>> getIntervalsForVehicle(String vehicleId) {
    return (select(mileageIntervals)
          ..where((tbl) => tbl.vehicleId.equals(vehicleId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.startOdometerKm)]))
        .get();
  }

  Stream<List<MileageIntervalData>> watchIntervalsForVehicle(String vehicleId) {
    return (select(mileageIntervals)
          ..where((tbl) => tbl.vehicleId.equals(vehicleId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.endOdometerKm)]))
        .watch();
  }

  Future<void> replaceIntervalsForVehicle(
    String vehicleId,
    List<MileageIntervalsCompanion> intervals,
  ) {
    return transaction(() async {
      // Clear derived intervals for this vehicle
      await (delete(
        mileageIntervals,
      )..where((tbl) => tbl.vehicleId.equals(vehicleId))).go();
      // Insert recomputed intervals
      for (final interval in intervals) {
        await into(mileageIntervals).insert(interval);
      }
    });
  }
}
