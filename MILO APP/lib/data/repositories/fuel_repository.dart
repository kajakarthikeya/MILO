import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';
import '../../domain/calculations/mileage_engine.dart';

class FuelRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  FuelRepository(this._db);

  Future<List<FuelEntryData>> getEntriesForVehicle(String vehicleId) {
    return _db.fuelEntryDao.getEntriesForVehicle(vehicleId);
  }

  Stream<List<FuelEntryData>> watchEntriesForVehicle(String vehicleId) {
    return _db.fuelEntryDao.watchEntriesForVehicle(vehicleId);
  }

  Future<List<FuelEntryData>> getAllEntries() {
    return _db.fuelEntryDao.getAllEntries();
  }

  Future<double?> getLatestOdometer(String vehicleId) {
    return _db.fuelEntryDao.getLatestOdometer(vehicleId);
  }

  Future<FuelEntryData> addFuelEntry({
    required String vehicleId,
    required DateTime timestamp,
    required double odometerKm,
    required int amountPaidMinorUnits,
    required double fuelQuantity,
    required int unitPriceMinorUnitsPerLitre,
    required String entryMethod,
    required String fillType,
    String? stationName,
    String? notes,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();

    final companion = FuelEntriesCompanion.insert(
      id: id,
      vehicleId: vehicleId,
      timestamp: timestamp,
      odometerKm: odometerKm,
      amountPaidMinorUnits: amountPaidMinorUnits,
      fuelQuantity: fuelQuantity,
      unitPriceMinorUnitsPerLitre: unitPriceMinorUnitsPerLitre,
      entryMethod: entryMethod,
      fillType: fillType,
      stationName: Value(stationName),
      notes: Value(notes),
      createdAt: now,
      updatedAt: now,
    );

    await _db.fuelEntryDao.insertEntry(companion);
    await recalculateVehicleMileage(vehicleId);

    final created = await _db.fuelEntryDao.getEntryById(id);
    return created!;
  }

  Future<void> updateFuelEntry({
    required String id,
    required String vehicleId,
    required DateTime timestamp,
    required double odometerKm,
    required int amountPaidMinorUnits,
    required double fuelQuantity,
    required int unitPriceMinorUnitsPerLitre,
    required String entryMethod,
    required String fillType,
    String? stationName,
    String? notes,
  }) async {
    final companion = FuelEntriesCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      timestamp: Value(timestamp),
      odometerKm: Value(odometerKm),
      amountPaidMinorUnits: Value(amountPaidMinorUnits),
      fuelQuantity: Value(fuelQuantity),
      unitPriceMinorUnitsPerLitre: Value(unitPriceMinorUnitsPerLitre),
      entryMethod: Value(entryMethod),
      fillType: Value(fillType),
      stationName: Value(stationName),
      notes: Value(notes),
      updatedAt: Value(DateTime.now()),
    );

    await _db.fuelEntryDao.updateEntry(companion);
    await recalculateVehicleMileage(vehicleId);
  }

  Future<void> deleteFuelEntry({
    required String id,
    required String vehicleId,
  }) async {
    await _db.fuelEntryDao.deleteEntry(id);
    await recalculateVehicleMileage(vehicleId);
  }

  /// Deterministically recalculates all derived full-tank mileage intervals
  /// for the specified vehicle and stores them in the database.
  Future<void> recalculateVehicleMileage(String vehicleId) async {
    final entries = await _db.fuelEntryDao.getEntriesForVehicle(vehicleId);

    final calcEntries = entries
        .map(
          (e) => FuelCalculationEntry(
            id: e.id,
            vehicleId: e.vehicleId,
            timestamp: e.timestamp,
            odometerKm: e.odometerKm,
            amountPaidMinorUnits: e.amountPaidMinorUnits,
            fuelQuantityLitres: e.fuelQuantity,
            isFullTank: e.fillType == 'full',
          ),
        )
        .toList();

    final intervals = MileageEngine.calculateIntervals(calcEntries);

    final companions = intervals
        .map(
          (interval) => MileageIntervalsCompanion.insert(
            id: '${interval.startFuelEntryId}_${interval.endFuelEntryId}',
            vehicleId: interval.vehicleId,
            startFuelEntryId: interval.startFuelEntryId,
            endFuelEntryId: interval.endFuelEntryId,
            startOdometerKm: interval.startOdometerKm,
            endOdometerKm: interval.endOdometerKm,
            distanceKm: interval.distanceKm,
            fuelConsumedLitres: interval.fuelConsumedLitres,
            mileageKmPerLitre: interval.mileageKmPerLitre,
            fuelCostMinorUnits: interval.fuelCostMinorUnits,
            calculatedAt: DateTime.now(),
          ),
        )
        .toList();

    await _db.mileageIntervalDao.replaceIntervalsForVehicle(
      vehicleId,
      companions,
    );
  }

  Stream<List<MileageIntervalData>> watchIntervalsForVehicle(String vehicleId) {
    return _db.mileageIntervalDao.watchIntervalsForVehicle(vehicleId);
  }

  Future<List<MileageIntervalData>> getIntervalsForVehicle(String vehicleId) {
    return _db.mileageIntervalDao.getIntervalsForVehicle(vehicleId);
  }
}
