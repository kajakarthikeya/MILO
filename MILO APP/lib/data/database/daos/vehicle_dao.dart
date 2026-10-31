import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/vehicles_table.dart';

part 'vehicle_dao.g.dart';

@DriftAccessor(tables: [Vehicles])
class VehicleDao extends DatabaseAccessor<AppDatabase> with _$VehicleDaoMixin {
  VehicleDao(super.db);

  Future<List<VehicleData>> getAllVehicles({bool includeArchived = false}) {
    if (includeArchived) {
      return select(vehicles).get();
    }
    return (select(
      vehicles,
    )..where((tbl) => tbl.isArchived.equals(false))).get();
  }

  Stream<List<VehicleData>> watchAllVehicles({bool includeArchived = false}) {
    if (includeArchived) {
      return select(vehicles).watch();
    }
    return (select(
      vehicles,
    )..where((tbl) => tbl.isArchived.equals(false))).watch();
  }

  Future<VehicleData?> getVehicleById(String id) {
    return (select(
      vehicles,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertVehicle(VehiclesCompanion vehicle) {
    return into(vehicles).insert(vehicle);
  }

  Future<bool> updateVehicle(VehiclesCompanion vehicle) async {
    final count = await (update(vehicles)
          ..where((tbl) => tbl.id.equals(vehicle.id.value)))
        .write(vehicle);
    return count > 0;
  }

  Future<int> setArchivedStatus(String id, bool isArchived) {
    return (update(vehicles)..where((tbl) => tbl.id.equals(id))).write(
      VehiclesCompanion(
        isArchived: Value(isArchived),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> deleteVehicle(String id) {
    return (delete(vehicles)..where((tbl) => tbl.id.equals(id))).go();
  }
}
