import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../repositories/vehicle_repository.dart';
import '../repositories/fuel_repository.dart';
import '../repositories/maintenance_repository.dart';
import '../repositories/budget_repository.dart';
import '../repositories/profile_repository.dart';
import '../../domain/calculations/mileage_engine.dart';

// Database & Core Repositories
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final vehicleRepositoryProvider = Provider<VehicleRepository>((ref) {
  return VehicleRepository(ref.watch(databaseProvider));
});

final fuelRepositoryProvider = Provider<FuelRepository>((ref) {
  return FuelRepository(ref.watch(databaseProvider));
});

final maintenanceRepositoryProvider = Provider<MaintenanceRepository>((ref) {
  return MaintenanceRepository(ref.watch(databaseProvider));
});

final budgetRepositoryProvider = Provider<BudgetRepository>((ref) {
  return BudgetRepository(ref.watch(databaseProvider));
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.watch(databaseProvider));
});

// Profile Stream
final userProfileStreamProvider = StreamProvider<UserProfileData?>((ref) {
  return ref.watch(profileRepositoryProvider).watchProfile();
});

// Vehicles Stream (Active vehicles)
final vehiclesStreamProvider = StreamProvider<List<VehicleData>>((ref) {
  return ref
      .watch(vehicleRepositoryProvider)
      .watchVehicles(includeArchived: false);
});

// All Vehicles (Including Archived)
final allVehiclesStreamProvider = StreamProvider<List<VehicleData>>((ref) {
  return ref
      .watch(vehicleRepositoryProvider)
      .watchVehicles(includeArchived: true);
});

// Active Selected Vehicle ID Notifier
class ActiveVehicleIdNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void selectVehicle(String? id) => state = id;
}

final activeVehicleIdProvider =
    NotifierProvider<ActiveVehicleIdNotifier, String?>(
      ActiveVehicleIdNotifier.new,
    );

// Active Vehicle Entity Provider
final activeVehicleProvider = Provider<VehicleData?>((ref) {
  final activeId = ref.watch(activeVehicleIdProvider);
  final vehiclesAsync = ref.watch(vehiclesStreamProvider);

  return vehiclesAsync.maybeWhen(
    data: (vehicles) {
      if (vehicles.isEmpty) return null;
      if (activeId == null) {
        return vehicles.first;
      }
      return vehicles.firstWhere(
        (v) => v.id == activeId,
        orElse: () => vehicles.first,
      );
    },
    orElse: () => null,
  );
});

// Fuel Entries Stream for a Vehicle
final vehicleFuelEntriesProvider =
    StreamProvider.family<List<FuelEntryData>, String>((ref, vehicleId) {
      return ref
          .watch(fuelRepositoryProvider)
          .watchEntriesForVehicle(vehicleId);
    });

// Mileage Intervals Stream for a Vehicle
final vehicleMileageIntervalsProvider =
    StreamProvider.family<List<MileageIntervalData>, String>((ref, vehicleId) {
      return ref
          .watch(fuelRepositoryProvider)
          .watchIntervalsForVehicle(vehicleId);
    });

// Mileage Summary Provider for a Vehicle
final vehicleMileageSummaryProvider = Provider.family<MileageSummary, String>((
  ref,
  vehicleId,
) {
  final intervalsAsync = ref.watch(vehicleMileageIntervalsProvider(vehicleId));

  return intervalsAsync.maybeWhen(
    data: (dbIntervals) {
      final intervals = dbIntervals
          .map(
            (i) => CalculatedMileageInterval(
              vehicleId: i.vehicleId,
              startFuelEntryId: i.startFuelEntryId,
              endFuelEntryId: i.endFuelEntryId,
              startOdometerKm: i.startOdometerKm,
              endOdometerKm: i.endOdometerKm,
              distanceKm: i.distanceKm,
              fuelConsumedLitres: i.fuelConsumedLitres,
              mileageKmPerLitre: i.mileageKmPerLitre,
              fuelCostMinorUnits: i.fuelCostMinorUnits,
              intermediateRefillsCount: 0,
              startDate: i.calculatedAt,
              endDate: i.calculatedAt,
            ),
          )
          .toList();

      return MileageEngine.calculateSummary(intervals);
    },
    orElse: () => MileageSummary.empty(),
  );
});

// Comprehensive Vehicle Mileage Analytics Provider (Measured & Estimated)
final vehicleMileageAnalyticsProvider =
    Provider.family<VehicleMileageAnalytics, String>((ref, vehicleId) {
  final entriesAsync = ref.watch(vehicleFuelEntriesProvider(vehicleId));
  final vehiclesAsync = ref.watch(vehiclesStreamProvider);

  return entriesAsync.maybeWhen(
    data: (dbEntries) {
      final vehicles = vehiclesAsync.asData?.value;
      final vehicle = vehicles?.where((v) => v.id == vehicleId).firstOrNull;

      final calcEntries = dbEntries
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

      return MileageEngine.calculateAnalytics(
        rawEntries: calcEntries,
        initialVehicleOdometerKm: vehicle?.initialOdometerKm ?? 0.0,
        expectedMileageKmPerLitre: vehicle?.expectedMileageKmPerLitre,
      );
    },
    orElse: () => VehicleMileageAnalytics.empty(),
  );
});

// Maintenance Records Stream for a Vehicle
final vehicleMaintenanceProvider =
    StreamProvider.family<List<MaintenanceRecordData>, String>((
      ref,
      vehicleId,
    ) {
      return ref
          .watch(maintenanceRepositoryProvider)
          .watchRecordsForVehicle(vehicleId);
    });

// Fuel Budgets Stream
final fuelBudgetsStreamProvider = StreamProvider<List<FuelBudgetData>>((ref) {
  return ref.watch(budgetRepositoryProvider).watchBudgets();
});

// Current Month Fuel Expense Minor Units
final currentMonthSpendProvider = Provider.family<int, String?>((
  ref,
  vehicleId,
) {
  final entriesAsync = vehicleId != null
      ? ref.watch(vehicleFuelEntriesProvider(vehicleId))
      : null;

  if (entriesAsync == null) return 0;

  return entriesAsync.maybeWhen(
    data: (entries) {
      final now = DateTime.now();
      int totalPaise = 0;
      for (final e in entries) {
        if (e.timestamp.year == now.year && e.timestamp.month == now.month) {
          totalPaise += e.amountPaidMinorUnits;
        }
      }
      return totalPaise;
    },
    orElse: () => 0,
  );
});

// Theme Mode Preference Notifier
class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.light; // Clean pure white interface

  void setThemeMode(ThemeMode mode) => state = mode;
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

// -------------------------------------------------------------
// Simplified 3-Page Providers (Single Bike Focus)
// -------------------------------------------------------------

/// Stream of the primary bike (first vehicle in the database).
final primaryBikeProvider = StreamProvider<VehicleData?>((ref) {
  final vehicleRepo = ref.watch(vehicleRepositoryProvider);
  return vehicleRepo.watchVehicles(includeArchived: false).map((vehicles) {
    if (vehicles.isEmpty) return null;
    return vehicles.first;
  });
});

/// Stream of all fuel entries for the primary bike, sorted newest first.
final primaryBikeFuelEntriesProvider = StreamProvider<List<FuelEntryData>>((ref) {
  final bikeAsync = ref.watch(primaryBikeProvider);
  final bike = bikeAsync.asData?.value;
  if (bike == null) return Stream.value([]);
  return ref.watch(fuelRepositoryProvider).watchEntriesForVehicle(bike.id);
});

/// Current live odometer reading: updates automatically from the latest fuel entry or initial bike odometer.
final currentOdometerProvider = Provider<double>((ref) {
  final bike = ref.watch(primaryBikeProvider).asData?.value;
  final entries = ref.watch(primaryBikeFuelEntriesProvider).asData?.value ?? [];

  if (entries.isNotEmpty) {
    double maxOdo = entries.first.odometerKm;
    for (final e in entries) {
      if (e.odometerKm > maxOdo) {
        maxOdo = e.odometerKm;
      }
    }
    return maxOdo;
  }
  return bike?.initialOdometerKm ?? 0.0;
});

/// Total amount spent on fuel for the primary bike in minor units (paise).
final totalFuelExpenditurePaiseProvider = Provider<int>((ref) {
  final entries = ref.watch(primaryBikeFuelEntriesProvider).asData?.value ?? [];
  int totalPaise = 0;
  for (final e in entries) {
    totalPaise += e.amountPaidMinorUnits;
  }
  return totalPaise;
});

/// Consecutive refill intervals for the Mileage page, sorted newest interval first.
final refillIntervalsProvider = Provider<List<RefillInterval>>((ref) {
  final entries = ref.watch(primaryBikeFuelEntriesProvider).asData?.value ?? [];
  if (entries.length < 2) return [];

  final calcEntries = entries.map((e) => FuelCalculationEntry(
    id: e.id,
    vehicleId: e.vehicleId,
    timestamp: e.timestamp,
    odometerKm: e.odometerKm,
    amountPaidMinorUnits: e.amountPaidMinorUnits,
    fuelQuantityLitres: e.fuelQuantity,
    isFullTank: e.fillType == 'full',
  )).toList();

  final intervals = MileageEngine.calculateConsecutiveIntervals(calcEntries);
  return intervals.reversed.toList();
});

/// Arithmetic average of valid consecutive refill-interval mileage estimates (Partial Fills).
final averageEstimatedMileageProvider = Provider<double?>((ref) {
  final intervals = ref.watch(refillIntervalsProvider);
  return MileageEngine.calculateArithmeticAverageEstimatedMileage(intervals);
});

/// Verified average actual mileage from full-to-full records.
final averageActualMileageProvider = Provider<double?>((ref) {
  final intervals = ref.watch(refillIntervalsProvider);
  return MileageEngine.calculateAverageActualMileage(intervals);
});
