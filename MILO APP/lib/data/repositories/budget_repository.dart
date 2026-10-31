import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../database/app_database.dart';

class BudgetRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  BudgetRepository(this._db);

  Future<List<FuelBudgetData>> getBudgets() {
    return _db.fuelBudgetDao.getBudgets();
  }

  Stream<List<FuelBudgetData>> watchBudgets() {
    return _db.fuelBudgetDao.watchBudgets();
  }

  Future<FuelBudgetData?> getBudgetForVehicle(String? vehicleId) {
    return _db.fuelBudgetDao.getBudgetForVehicle(vehicleId);
  }

  Future<void> setBudget({
    String? vehicleId,
    required int monthlyLimitMinorUnits,
    int warningThresholdPercent = 80,
    bool isEnabled = true,
  }) async {
    final existing = await _db.fuelBudgetDao.getBudgetForVehicle(vehicleId);
    final now = DateTime.now();

    final companion = FuelBudgetsCompanion.insert(
      id: existing?.id ?? _uuid.v4(),
      vehicleId: Value(vehicleId),
      monthlyLimitMinorUnits: monthlyLimitMinorUnits,
      warningThresholdPercent: Value(warningThresholdPercent),
      period: const Value('monthly'),
      isEnabled: Value(isEnabled),
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );

    await _db.fuelBudgetDao.upsertBudget(companion);
  }

  Future<void> deleteBudget(String id) {
    return _db.fuelBudgetDao.deleteBudget(id);
  }
}
