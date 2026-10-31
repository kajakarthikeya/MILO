import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';

class MaintenanceRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  MaintenanceRepository(this._db);

  Future<List<MaintenanceRecordData>> getRecordsForVehicle(String vehicleId) {
    return _db.maintenanceDao.getMaintenanceForVehicle(vehicleId);
  }

  Stream<List<MaintenanceRecordData>> watchRecordsForVehicle(String vehicleId) {
    return _db.maintenanceDao.watchMaintenanceForVehicle(vehicleId);
  }

  Future<MaintenanceRecordData> addRecord({
    required String vehicleId,
    required String category,
    required String description,
    required int amountMinorUnits,
    required DateTime serviceDate,
    required double odometerKm,
    DateTime? nextServiceDate,
    double? nextServiceOdometerKm,
    String? notes,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();

    final companion = MaintenanceRecordsCompanion.insert(
      id: id,
      vehicleId: vehicleId,
      category: category,
      description: description,
      amountMinorUnits: amountMinorUnits,
      serviceDate: serviceDate,
      odometerKm: odometerKm,
      nextServiceDate: Value(nextServiceDate),
      nextServiceOdometerKm: Value(nextServiceOdometerKm),
      notes: Value(notes),
      createdAt: now,
      updatedAt: now,
    );

    await _db.maintenanceDao.insertMaintenance(companion);
    final all = await _db.maintenanceDao.getMaintenanceForVehicle(vehicleId);
    return all.firstWhere((r) => r.id == id);
  }

  Future<void> updateRecord({
    required String id,
    required String vehicleId,
    required String category,
    required String description,
    required int amountMinorUnits,
    required DateTime serviceDate,
    required double odometerKm,
    DateTime? nextServiceDate,
    double? nextServiceOdometerKm,
    String? notes,
  }) async {
    final companion = MaintenanceRecordsCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      category: Value(category),
      description: Value(description),
      amountMinorUnits: Value(amountMinorUnits),
      serviceDate: Value(serviceDate),
      odometerKm: Value(odometerKm),
      nextServiceDate: Value(nextServiceDate),
      nextServiceOdometerKm: Value(nextServiceOdometerKm),
      notes: Value(notes),
      updatedAt: Value(DateTime.now()),
    );

    await _db.maintenanceDao.updateMaintenance(companion);
  }

  Future<void> deleteRecord(String id) {
    return _db.maintenanceDao.deleteMaintenance(id);
  }
}
