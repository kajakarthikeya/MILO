import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';

class VehicleRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  VehicleRepository(this._db);

  Future<List<VehicleData>> getVehicles({bool includeArchived = false}) {
    return _db.vehicleDao.getAllVehicles(includeArchived: includeArchived);
  }

  Stream<List<VehicleData>> watchVehicles({bool includeArchived = false}) {
    return _db.vehicleDao.watchAllVehicles(includeArchived: includeArchived);
  }

  Future<VehicleData?> getVehicleById(String id) {
    return _db.vehicleDao.getVehicleById(id);
  }

  Future<VehicleData> createVehicle({
    required String nickname,
    required String make,
    required String model,
    required String vehicleType,
    required String fuelType,
    String? registrationLabel,
    required double initialOdometerKm,
    double? expectedMileageKmPerLitre,
    double? tankCapacityLitres,
    DateTime? purchaseDate,
    String? notes,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();

    final companion = VehiclesCompanion.insert(
      id: id,
      nickname: nickname,
      make: make,
      model: model,
      vehicleType: vehicleType,
      fuelType: fuelType,
      registrationLabel: Value(registrationLabel),
      initialOdometerKm: initialOdometerKm,
      expectedMileageKmPerLitre: Value(expectedMileageKmPerLitre),
      tankCapacityLitres: Value(tankCapacityLitres),
      purchaseDate: Value(purchaseDate),
      notes: Value(notes),
      isArchived: const Value(false),
      createdAt: now,
      updatedAt: now,
    );

    await _db.vehicleDao.insertVehicle(companion);
    final created = await _db.vehicleDao.getVehicleById(id);
    return created!;
  }

  Future<void> updateVehicle({
    required String id,
    required String nickname,
    required String make,
    required String model,
    required String vehicleType,
    required String fuelType,
    String? registrationLabel,
    required double initialOdometerKm,
    double? expectedMileageKmPerLitre,
    double? tankCapacityLitres,
    DateTime? purchaseDate,
    String? notes,
    required bool isArchived,
  }) async {
    final companion = VehiclesCompanion(
      id: Value(id),
      nickname: Value(nickname),
      make: Value(make),
      model: Value(model),
      vehicleType: Value(vehicleType),
      fuelType: Value(fuelType),
      registrationLabel: Value(registrationLabel),
      initialOdometerKm: Value(initialOdometerKm),
      expectedMileageKmPerLitre: Value(expectedMileageKmPerLitre),
      tankCapacityLitres: Value(tankCapacityLitres),
      purchaseDate: Value(purchaseDate),
      notes: Value(notes),
      isArchived: Value(isArchived),
      updatedAt: Value(DateTime.now()),
    );

    await _db.vehicleDao.updateVehicle(companion);
  }

  Future<void> archiveVehicle(String id, bool isArchived) {
    return _db.vehicleDao.setArchivedStatus(id, isArchived);
  }

  Future<void> deleteVehicle(String id) {
    return _db.vehicleDao.deleteVehicle(id);
  }
}
