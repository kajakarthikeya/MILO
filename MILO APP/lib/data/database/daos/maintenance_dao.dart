import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/maintenance_records_table.dart';

part 'maintenance_dao.g.dart';

@DriftAccessor(tables: [MaintenanceRecords])
class MaintenanceDao extends DatabaseAccessor<AppDatabase>
    with _$MaintenanceDaoMixin {
  MaintenanceDao(super.db);

  Future<List<MaintenanceRecordData>> getMaintenanceForVehicle(
    String vehicleId,
  ) {
    return (select(maintenanceRecords)
          ..where((tbl) => tbl.vehicleId.equals(vehicleId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.serviceDate)]))
        .get();
  }

  Stream<List<MaintenanceRecordData>> watchMaintenanceForVehicle(
    String vehicleId,
  ) {
    return (select(maintenanceRecords)
          ..where((tbl) => tbl.vehicleId.equals(vehicleId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.serviceDate)]))
        .watch();
  }

  Future<int> insertMaintenance(MaintenanceRecordsCompanion record) {
    return into(maintenanceRecords).insert(record);
  }

  Future<bool> updateMaintenance(MaintenanceRecordsCompanion record) async {
    final count = await (update(maintenanceRecords)
          ..where((tbl) => tbl.id.equals(record.id.value)))
        .write(record);
    return count > 0;
  }

  Future<int> deleteMaintenance(String id) {
    return (delete(maintenanceRecords)..where((tbl) => tbl.id.equals(id))).go();
  }
}
