import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/fuel_budget_table.dart';

part 'fuel_budget_dao.g.dart';

@DriftAccessor(tables: [FuelBudgets])
class FuelBudgetDao extends DatabaseAccessor<AppDatabase>
    with _$FuelBudgetDaoMixin {
  FuelBudgetDao(super.db);

  Future<List<FuelBudgetData>> getBudgets() {
    return select(fuelBudgets).get();
  }

  Stream<List<FuelBudgetData>> watchBudgets() {
    return select(fuelBudgets).watch();
  }

  Future<FuelBudgetData?> getBudgetForVehicle(String? vehicleId) {
    if (vehicleId == null) {
      return (select(
        fuelBudgets,
      )..where((tbl) => tbl.vehicleId.isNull())).getSingleOrNull();
    }
    return (select(
      fuelBudgets,
    )..where((tbl) => tbl.vehicleId.equals(vehicleId))).getSingleOrNull();
  }

  Future<int> upsertBudget(FuelBudgetsCompanion budget) {
    return into(fuelBudgets).insertOnConflictUpdate(budget);
  }

  Future<int> deleteBudget(String id) {
    return (delete(fuelBudgets)..where((tbl) => tbl.id.equals(id))).go();
  }
}
