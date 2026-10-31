import 'dart:math' as math;

/// Pure Dart domain model representing a fuel entry for mileage calculations.
class FuelCalculationEntry {
  final String id;
  final String vehicleId;
  final DateTime timestamp;
  final double odometerKm;
  final int amountPaidMinorUnits;
  final double fuelQuantityLitres;
  final bool isFullTank;

  const FuelCalculationEntry({
    required this.id,
    required this.vehicleId,
    required this.timestamp,
    required this.odometerKm,
    required this.amountPaidMinorUnits,
    required this.fuelQuantityLitres,
    required this.isFullTank,
  });
}

/// A verified full-tank-to-full-tank mileage interval.
class CalculatedMileageInterval {
  final String vehicleId;
  final String startFuelEntryId;
  final String endFuelEntryId;
  final double startOdometerKm;
  final double endOdometerKm;
  final double distanceKm;
  final double fuelConsumedLitres;
  final double mileageKmPerLitre;
  final int fuelCostMinorUnits;
  final int intermediateRefillsCount;
  final DateTime startDate;
  final DateTime endDate;

  const CalculatedMileageInterval({
    required this.vehicleId,
    required this.startFuelEntryId,
    required this.endFuelEntryId,
    required this.startOdometerKm,
    required this.endOdometerKm,
    required this.distanceKm,
    required this.fuelConsumedLitres,
    required this.mileageKmPerLitre,
    required this.fuelCostMinorUnits,
    required this.intermediateRefillsCount,
    required this.startDate,
    required this.endDate,
  });

  /// Cost per kilometre in major currency units (e.g. Rupees per km).
  double get costPerKm {
    if (distanceKm <= 0) return 0.0;
    return (fuelCostMinorUnits / 100.0) / distanceKm;
  }
}

/// A mileage interval computed across consecutive partial refills without requiring a full tank.
class PartialMileageInterval {
  final String vehicleId;
  final String startFuelEntryId;
  final String endFuelEntryId;
  final double startOdometerKm;
  final double endOdometerKm;
  final double distanceKm;
  final double fuelQuantityLitres;
  final double mileageKmPerLitre;
  final int fuelCostMinorUnits;
  final DateTime startDate;
  final DateTime endDate;

  const PartialMileageInterval({
    required this.vehicleId,
    required this.startFuelEntryId,
    required this.endFuelEntryId,
    required this.startOdometerKm,
    required this.endOdometerKm,
    required this.distanceKm,
    required this.fuelQuantityLitres,
    required this.mileageKmPerLitre,
    required this.fuelCostMinorUnits,
    required this.startDate,
    required this.endDate,
  });

  double get costPerKm {
    if (distanceKm <= 0) return 0.0;
    return (fuelCostMinorUnits / 100.0) / distanceKm;
  }
}

/// A simple, useful interval between consecutive fuel refills for the Mileage page.
class RefillInterval {
  final int startIndex;
  final int endIndex;
  final String startEntryId;
  final String endEntryId;
  final DateTime startDate;
  final DateTime endDate;
  final double startOdometerKm;
  final double endOdometerKm;
  final double distanceKm;
  final double previousRefillFuelLitres; // Divisor: litres purchased in previous refill
  final double currentRefillFuelLitres;
  final double? estimatedMileageKmPerLitre;
  final double? actualMileageKmPerLitre;
  final String calculationType; // 'estimated' | 'actual' | 'baseline'
  final double cycleDistanceKm;
  final double cycleFuelConsumedLitres;
  final int intermediateFillsCount;
  final bool isStartFullTank;
  final bool isEndFullTank;
  final int endAmountPaidMinorUnits;
  final int endUnitPriceMinorUnits;

  const RefillInterval({
    this.startIndex = 1,
    this.endIndex = 2,
    required this.startEntryId,
    required this.endEntryId,
    required this.startDate,
    required this.endDate,
    required this.startOdometerKm,
    required this.endOdometerKm,
    required this.distanceKm,
    required this.previousRefillFuelLitres,
    this.currentRefillFuelLitres = 0.0,
    this.estimatedMileageKmPerLitre,
    this.actualMileageKmPerLitre,
    this.calculationType = 'estimated',
    this.cycleDistanceKm = 0.0,
    this.cycleFuelConsumedLitres = 0.0,
    this.intermediateFillsCount = 0,
    this.isStartFullTank = false,
    required this.isEndFullTank,
    required this.endAmountPaidMinorUnits,
    required this.endUnitPriceMinorUnits,
  });

  /// Alias for the divisor fuel quantity (from previous refill)
  double get fuelQuantityLitres => previousRefillFuelLitres;

  String get refillPairLabel => 'Refill $startIndex → Refill $endIndex';

  /// Primary mileage value to display for this interval
  double? get displayMileage =>
      calculationType == 'actual' ? actualMileageKmPerLitre : estimatedMileageKmPerLitre;

  bool get isMileageAvailable => displayMileage != null;

  bool get isActualMileage => calculationType == 'actual';
  bool get isEstimatedMileage => calculationType == 'estimated';
  bool get isBaseline => calculationType == 'baseline';
}

/// A documented estimation of fuel mileage with transparent methodology.
class MileageEstimate {
  final double? estimatedKmPerLitre;
  final String methodDescription;
  final String limitations;
  final bool isAvailable;

  const MileageEstimate({
    this.estimatedKmPerLitre,
    required this.methodDescription,
    required this.limitations,
    required this.isAvailable,
  });

  factory MileageEstimate.unavailable({required String reason}) => MileageEstimate(
        estimatedKmPerLitre: null,
        methodDescription: 'Unavailable',
        limitations: reason,
        isAvailable: false,
      );
}

/// Comprehensive vehicle mileage analytics supporting both full-tank and partial-fill calculation.
class VehicleMileageAnalytics {
  final CalculatedMileageInterval? latestMeasuredInterval;
  final PartialMileageInterval? latestPartialInterval;
  final List<PartialMileageInterval> partialIntervals;
  final MileageEstimate estimatedMileage;
  final double? overallAverageMeasuredMileage;
  final double? overallAveragePartialMileage;

  /// Effective average mileage: uses verified full-tank average if available,
  /// otherwise automatically uses cumulative partial-fill average!
  final double? effectiveAverageMileage;

  /// Effective latest mileage: uses latest full-tank interval if available,
  /// otherwise automatically uses latest partial refill leg!
  final double? effectiveLatestMileage;

  final double? distanceSinceLastEntryKm;
  final double totalDistanceTravelledKm;
  final double totalFuelPurchasedLitres;
  final int totalFuelCostMinorUnits;
  final double? averageCostPerKm;
  final int validMeasuredIntervalsCount;
  final int validPartialIntervalsCount;
  final int totalEntriesCount;

  bool get hasMeasuredIntervals => validMeasuredIntervalsCount > 0;
  bool get hasPartialIntervals => validPartialIntervalsCount > 0;

  const VehicleMileageAnalytics({
    this.latestMeasuredInterval,
    this.latestPartialInterval,
    this.partialIntervals = const [],
    required this.estimatedMileage,
    this.overallAverageMeasuredMileage,
    this.overallAveragePartialMileage,
    this.effectiveAverageMileage,
    this.effectiveLatestMileage,
    this.distanceSinceLastEntryKm,
    required this.totalDistanceTravelledKm,
    required this.totalFuelPurchasedLitres,
    required this.totalFuelCostMinorUnits,
    this.averageCostPerKm,
    required this.validMeasuredIntervalsCount,
    required this.validPartialIntervalsCount,
    required this.totalEntriesCount,
  });

  factory VehicleMileageAnalytics.empty() => VehicleMileageAnalytics(
        latestMeasuredInterval: null,
        latestPartialInterval: null,
        partialIntervals: const [],
        estimatedMileage: MileageEstimate.unavailable(
          reason: 'No fuel entries recorded for this vehicle.',
        ),
        overallAverageMeasuredMileage: null,
        overallAveragePartialMileage: null,
        effectiveAverageMileage: null,
        effectiveLatestMileage: null,
        distanceSinceLastEntryKm: null,
        totalDistanceTravelledKm: 0.0,
        totalFuelPurchasedLitres: 0.0,
        totalFuelCostMinorUnits: 0,
        averageCostPerKm: null,
        validMeasuredIntervalsCount: 0,
        validPartialIntervalsCount: 0,
        totalEntriesCount: 0,
      );
}

/// Aggregated mileage metrics across all valid intervals for a vehicle.
class MileageSummary {
  final CalculatedMileageInterval? latestInterval;
  final int validIntervalsCount;
  final double totalValidDistanceKm;
  final double totalValidFuelConsumedLitres;
  final int totalValidFuelCostMinorUnits;
  final double? weightedAverageMileageKmPerLitre;
  final double? averageCostPerKm;

  const MileageSummary({
    this.latestInterval,
    required this.validIntervalsCount,
    required this.totalValidDistanceKm,
    required this.totalValidFuelConsumedLitres,
    required this.totalValidFuelCostMinorUnits,
    this.weightedAverageMileageKmPerLitre,
    this.averageCostPerKm,
  });

  factory MileageSummary.empty() => const MileageSummary(
        latestInterval: null,
        validIntervalsCount: 0,
        totalValidDistanceKm: 0.0,
        totalValidFuelConsumedLitres: 0.0,
        totalValidFuelCostMinorUnits: 0,
        weightedAverageMileageKmPerLitre: null,
        averageCostPerKm: null,
      );
}

/// Engine implementing verified full-tank calculations and partial-fill mileage algorithms.
class MileageEngine {
  MileageEngine._();

  /// Computes all verified full-tank-to-full-tank intervals for a given set of entries.
  ///
  /// Entries are sorted chronologically by timestamp and odometer reading.
  /// All intermediate partial fills between two consecutive full tanks are included.
  /// Fuel from the starting full-tank fill is NOT counted in the new interval;
  /// fuel from the ending full-tank refill IS counted in the interval.
  static List<CalculatedMileageInterval> calculateIntervals(
    List<FuelCalculationEntry> rawEntries,
  ) {
    if (rawEntries.length < 2) return [];

    // Filter and sort deterministically by timestamp, then odometer
    final entries = List<FuelCalculationEntry>.from(rawEntries)
      ..sort((a, b) {
        final timeCompare = a.timestamp.compareTo(b.timestamp);
        if (timeCompare != 0) return timeCompare;
        return a.odometerKm.compareTo(b.odometerKm);
      });

    final List<CalculatedMileageInterval> intervals = [];

    FuelCalculationEntry? startFullTank;
    double accumulatedFuel = 0.0;
    int accumulatedCost = 0;
    int intermediateCount = 0;

    for (final entry in entries) {
      if (startFullTank == null) {
        if (entry.isFullTank) {
          startFullTank = entry;
          accumulatedFuel = 0.0;
          accumulatedCost = 0;
          intermediateCount = 0;
        }
        continue;
      }

      // Check chronological odometer consistency
      if (entry.odometerKm <= startFullTank.odometerKm) {
        continue;
      }

      // Accumulate fuel and cost from events occurring AFTER starting full tank
      accumulatedFuel += entry.fuelQuantityLitres;
      accumulatedCost += entry.amountPaidMinorUnits;

      if (!entry.isFullTank) {
        intermediateCount++;
      } else {
        // Reached the ending full tank!
        final distance = entry.odometerKm - startFullTank.odometerKm;
        if (distance > 0 && accumulatedFuel > 0) {
          final mileage = distance / accumulatedFuel;
          intervals.add(
            CalculatedMileageInterval(
              vehicleId: entry.vehicleId,
              startFuelEntryId: startFullTank.id,
              endFuelEntryId: entry.id,
              startOdometerKm: startFullTank.odometerKm,
              endOdometerKm: entry.odometerKm,
              distanceKm: distance,
              fuelConsumedLitres: accumulatedFuel,
              mileageKmPerLitre: mileage,
              fuelCostMinorUnits: accumulatedCost,
              intermediateRefillsCount: intermediateCount,
              startDate: startFullTank.timestamp,
              endDate: entry.timestamp,
            ),
          );
        }

        // The current full-tank entry becomes the starting baseline for the next interval
        startFullTank = entry;
        accumulatedFuel = 0.0;
        accumulatedCost = 0;
        intermediateCount = 0;
      }
    }

    return intervals;
  }

  /// Computes mileage intervals across consecutive partial refills without requiring full tank.
  ///
  /// For every consecutive pair of refuelling stops where distance > 0 and fuel > 0:
  /// Leg Mileage = (Odometer_curr - Odometer_prev) / Fuel_curr.
  /// If only 1 entry exists and vehicle has initialOdometerKm:
  /// First Leg Mileage = (Odometer_1 - initialOdometerKm) / Fuel_1.
  static List<PartialMileageInterval> calculatePartialIntervals({
    required List<FuelCalculationEntry> rawEntries,
    double initialVehicleOdometerKm = 0.0,
  }) {
    if (rawEntries.isEmpty) return [];

    final entries = List<FuelCalculationEntry>.from(rawEntries)
      ..sort((a, b) {
        final timeCompare = a.timestamp.compareTo(b.timestamp);
        if (timeCompare != 0) return timeCompare;
        return a.odometerKm.compareTo(b.odometerKm);
      });

    final List<PartialMileageInterval> partials = [];

    // Case 1: Multiple entries -> calculate consecutive leg mileage
    if (entries.length >= 2) {
      for (int i = 1; i < entries.length; i++) {
        final prev = entries[i - 1];
        final curr = entries[i];
        final distance = curr.odometerKm - prev.odometerKm;
        final divisorFuel = prev.fuelQuantityLitres;

        if (distance > 0 && divisorFuel > 0) {
          final mileage = distance / divisorFuel;
          partials.add(
            PartialMileageInterval(
              vehicleId: curr.vehicleId,
              startFuelEntryId: prev.id,
              endFuelEntryId: curr.id,
              startOdometerKm: prev.odometerKm,
              endOdometerKm: curr.odometerKm,
              distanceKm: distance,
              fuelQuantityLitres: divisorFuel,
              mileageKmPerLitre: mileage,
              fuelCostMinorUnits: curr.amountPaidMinorUnits,
              startDate: prev.timestamp,
              endDate: curr.timestamp,
            ),
          );
        }
      }
    } else if (entries.length == 1) {
      // Case 2: Exactly 1 entry with distance driven from vehicle initial odometer
      final single = entries.first;
      final distance = single.odometerKm - initialVehicleOdometerKm;
      final fuel = single.fuelQuantityLitres;
      if (distance > 0 && fuel > 0) {
        final mileage = distance / fuel;
        partials.add(
          PartialMileageInterval(
            vehicleId: single.vehicleId,
            startFuelEntryId: 'initial_odometer',
            endFuelEntryId: single.id,
            startOdometerKm: initialVehicleOdometerKm,
            endOdometerKm: single.odometerKm,
            distanceKm: distance,
            fuelQuantityLitres: fuel,
            mileageKmPerLitre: mileage,
            fuelCostMinorUnits: single.amountPaidMinorUnits,
            startDate: single.timestamp,
            endDate: single.timestamp,
          ),
        );
      }
    }

    return partials;
  }

  /// Computes consecutive refill intervals between chronologically sorted entries.
  /// Categorizes each interval into Actual Mileage (full-to-full) or Estimated Mileage (partial fill).
  ///
  /// Partial fill-up (Estimated Mileage):
  /// - Distance Travelled = Current Odometer - Previous Odometer
  /// - Estimated Mileage = Distance Travelled ÷ Previous Fill-up Litres
  ///
  /// Full-tank fill-up (Actual Mileage):
  /// - First full tank: Establishes baseline only.
  /// - Subsequent full tank:
  ///   - Distance Travelled = Current Full-Tank Odometer - Previous Full-Tank Odometer
  ///   - Fuel Consumed = Sum of all fuel added AFTER previous full-tank entry, including current refill.
  ///   - Actual Mileage = Distance Travelled ÷ Fuel Consumed.
  static List<RefillInterval> calculateConsecutiveIntervals(
    List<FuelCalculationEntry> rawEntries,
  ) {
    if (rawEntries.length < 2) return [];

    // Sort chronologically ascending
    final entries = List<FuelCalculationEntry>.from(rawEntries)
      ..sort((a, b) {
        final timeCompare = a.timestamp.compareTo(b.timestamp);
        if (timeCompare != 0) return timeCompare;
        return a.odometerKm.compareTo(b.odometerKm);
      });

    final List<RefillInterval> intervals = [];

    // Full-to-full tracking state
    FuelCalculationEntry? lastFullTank;
    double fuelAccumulatedSinceLastFull = 0.0;
    int intermediateCount = 0;

    // Check if the very first entry is a full tank
    if (entries.first.isFullTank) {
      lastFullTank = entries.first;
      fuelAccumulatedSinceLastFull = 0.0;
      intermediateCount = 0;
    }

    for (int i = 1; i < entries.length; i++) {
      final prev = entries[i - 1];
      final curr = entries[i];
      final distance = curr.odometerKm - prev.odometerKm;
      final prevFuel = prev.fuelQuantityLitres;
      final currFuel = curr.fuelQuantityLitres;

      String calcType = 'estimated';
      double? estimatedMileage;
      double? actualMileage;
      double cycleDistance = distance > 0 ? distance : 0.0;
      double cycleFuel = currFuel;
      int cycleIntermediates = 0;

      if (curr.isFullTank) {
        if (lastFullTank != null) {
          // Reached the next full tank! Completes standard full-to-full cycle:
          fuelAccumulatedSinceLastFull += currFuel;
          final fullDistance = curr.odometerKm - lastFullTank.odometerKm;
          if (fullDistance > 0 && fuelAccumulatedSinceLastFull > 0) {
            actualMileage = fullDistance / fuelAccumulatedSinceLastFull;
            calcType = 'actual';
            cycleDistance = fullDistance;
            cycleFuel = fuelAccumulatedSinceLastFull;
            cycleIntermediates = intermediateCount;
          }
          // Reset baseline to current full tank
          lastFullTank = curr;
          fuelAccumulatedSinceLastFull = 0.0;
          intermediateCount = 0;
        } else {
          // First full tank ever recorded in history: Establishes baseline only
          calcType = 'baseline';
          lastFullTank = curr;
          fuelAccumulatedSinceLastFull = 0.0;
          intermediateCount = 0;
          if (distance > 0 && prevFuel > 0) {
            estimatedMileage = distance / prevFuel;
          }
        }
      } else {
        // Partial fill-up!
        calcType = 'estimated';
        if (lastFullTank != null) {
          fuelAccumulatedSinceLastFull += currFuel;
          intermediateCount++;
        }
        if (distance > 0 && prevFuel > 0) {
          estimatedMileage = distance / prevFuel;
        }
      }

      intervals.add(
        RefillInterval(
          startIndex: i,
          endIndex: i + 1,
          startEntryId: prev.id,
          endEntryId: curr.id,
          startDate: prev.timestamp,
          endDate: curr.timestamp,
          startOdometerKm: prev.odometerKm,
          endOdometerKm: curr.odometerKm,
          distanceKm: distance > 0 ? distance : 0.0,
          previousRefillFuelLitres: prevFuel,
          currentRefillFuelLitres: currFuel,
          estimatedMileageKmPerLitre: estimatedMileage,
          actualMileageKmPerLitre: actualMileage,
          calculationType: calcType,
          cycleDistanceKm: cycleDistance,
          cycleFuelConsumedLitres: cycleFuel,
          intermediateFillsCount: cycleIntermediates,
          isStartFullTank: prev.isFullTank,
          isEndFullTank: curr.isFullTank,
          endAmountPaidMinorUnits: curr.amountPaidMinorUnits,
          endUnitPriceMinorUnits:
              currFuel > 0 ? (curr.amountPaidMinorUnits / currFuel).round() : 0,
        ),
      );
    }

    return intervals;
  }

  /// Calculates the arithmetic average of estimated mileage strictly from partial fill-ups.
  /// Formula: Sum(valid partial estimated mileages) ÷ count of valid partial intervals.
  ///
  /// Requirements:
  /// - Only includes partial-fill intervals.
  /// - Uses previous refill fuel as divisor.
  /// - Does NOT mix with actual mileage.
  /// - Returns null if no valid partial intervals exist.
  static double? calculateArithmeticAverageEstimatedMileage(List<RefillInterval> intervals) {
    final validEstimates = intervals
        .where((i) =>
            i.calculationType == 'estimated' &&
            i.distanceKm > 0 &&
            i.previousRefillFuelLitres > 0)
        .map((i) => i.estimatedMileageKmPerLitre)
        .whereType<double>()
        .where((m) => m > 0 && !m.isNaN && !m.isInfinite)
        .toList();

    if (validEstimates.isEmpty) return null;

    final sum = validEstimates.fold<double>(0.0, (acc, val) => acc + val);
    return sum / validEstimates.length;
  }

  /// Calculates the average actual mileage strictly from verified full-to-full records.
  /// Formula: Total Full-to-Full Distance ÷ Total Fuel Consumed across full-tank cycles.
  ///
  /// Requirements:
  /// - Only includes full-to-full cycles.
  /// - Does NOT mix with estimated mileage.
  /// - Returns null if no full-to-full cycles are completed.
  static double? calculateAverageActualMileage(List<RefillInterval> intervals) {
    final actualIntervals = intervals
        .where((i) =>
            i.calculationType == 'actual' &&
            i.cycleDistanceKm > 0 &&
            i.cycleFuelConsumedLitres > 0 &&
            i.actualMileageKmPerLitre != null)
        .toList();

    if (actualIntervals.isEmpty) return null;

    double totalDistance = 0.0;
    double totalFuel = 0.0;
    for (final i in actualIntervals) {
      totalDistance += i.cycleDistanceKm;
      totalFuel += i.cycleFuelConsumedLitres;
    }

    if (totalDistance > 0 && totalFuel > 0) {
      return totalDistance / totalFuel;
    }
    return null;
  }

  /// Backwards-compatible alias for existing callers and tests.
  static double? calculateArithmeticAverageMileage(List<RefillInterval> intervals) {
    return calculateArithmeticAverageEstimatedMileage(intervals);
  }

  /// Calculates the weighted average mileage across all valid intervals.
  static MileageSummary calculateSummary(
    List<CalculatedMileageInterval> intervals,
  ) {
    if (intervals.isEmpty) {
      return MileageSummary.empty();
    }

    double totalDistance = 0.0;
    double totalFuel = 0.0;
    int totalCostMinorUnits = 0;

    for (final interval in intervals) {
      totalDistance += interval.distanceKm;
      totalFuel += interval.fuelConsumedLitres;
      totalCostMinorUnits += interval.fuelCostMinorUnits;
    }

    final double? weightedMileage =
        totalFuel > 0 ? (totalDistance / totalFuel) : null;
    final double? costPerKm = totalDistance > 0
        ? ((totalCostMinorUnits / 100.0) / totalDistance)
        : null;

    return MileageSummary(
      latestInterval: intervals.isNotEmpty ? intervals.last : null,
      validIntervalsCount: intervals.length,
      totalValidDistanceKm: totalDistance,
      totalValidFuelConsumedLitres: totalFuel,
      totalValidFuelCostMinorUnits: totalCostMinorUnits,
      weightedAverageMileageKmPerLitre: weightedMileage,
      averageCostPerKm: costPerKm,
    );
  }

  /// Comprehensive analytics computing both full-tank measured mileage and
  /// active partial-fill mileage without requiring full tank.
  static VehicleMileageAnalytics calculateAnalytics({
    required List<FuelCalculationEntry> rawEntries,
    double initialVehicleOdometerKm = 0.0,
    double? expectedMileageKmPerLitre,
  }) {
    if (rawEntries.isEmpty) {
      return VehicleMileageAnalytics.empty();
    }

    // Sort entries deterministically by timestamp, then odometer
    final entries = List<FuelCalculationEntry>.from(rawEntries)
      ..sort((a, b) {
        final timeCompare = a.timestamp.compareTo(b.timestamp);
        if (timeCompare != 0) return timeCompare;
        return a.odometerKm.compareTo(b.odometerKm);
      });

    // 1. Full-tank intervals (laboratory standard)
    final measuredIntervals = calculateIntervals(entries);
    final measuredSummary = calculateSummary(measuredIntervals);

    // 2. Partial-fill intervals (continuous refuel standard)
    final partialIntervals = calculatePartialIntervals(
      rawEntries: entries,
      initialVehicleOdometerKm: initialVehicleOdometerKm,
    );

    // Total expenditures & fuel across all entries
    double totalFuelPurchased = 0.0;
    int totalFuelCost = 0;
    for (final e in entries) {
      totalFuelPurchased += e.fuelQuantityLitres;
      totalFuelCost += e.amountPaidMinorUnits;
    }

    // Distance since the last fuel entry
    double? distanceSinceLastEntry;
    if (entries.length >= 2) {
      final last = entries.last;
      final prev = entries[entries.length - 2];
      final d = last.odometerKm - prev.odometerKm;
      if (d >= 0) distanceSinceLastEntry = d;
    } else if (entries.length == 1) {
      final d = entries.first.odometerKm - initialVehicleOdometerKm;
      if (d >= 0) distanceSinceLastEntry = d;
    }

    // Total distance travelled across all recorded entries
    final minOdo = math.min(initialVehicleOdometerKm, entries.first.odometerKm);
    final maxOdo = entries.last.odometerKm;
    final totalDistanceTravelled = math.max(0.0, maxOdo - minOdo);

    // Cumulative Partial Mileage calculation across all partial refill legs
    double? overallAveragePartialMileage;
    double? partialCostPerKm;
    if (partialIntervals.isNotEmpty) {
      double partialTotalDistance = 0.0;
      double partialTotalFuel = 0.0;
      int partialTotalCost = 0;
      for (final p in partialIntervals) {
        partialTotalDistance += p.distanceKm;
        partialTotalFuel += p.fuelQuantityLitres;
        partialTotalCost += p.fuelCostMinorUnits;
      }
      if (partialTotalDistance > 0 && partialTotalFuel > 0) {
        overallAveragePartialMileage = partialTotalDistance / partialTotalFuel;
        partialCostPerKm = (partialTotalCost / 100.0) / partialTotalDistance;
      }
    }

    // Effective metrics seamlessly fallback to partial refills if user never filled full tank!
    final bool hasMeasured = measuredSummary.weightedAverageMileageKmPerLitre != null;
    final double? effectiveAverageMileage = hasMeasured
        ? measuredSummary.weightedAverageMileageKmPerLitre
        : overallAveragePartialMileage;

    final double? effectiveLatestMileage = measuredSummary.latestInterval != null
        ? measuredSummary.latestInterval!.mileageKmPerLitre
        : (partialIntervals.isNotEmpty ? partialIntervals.last.mileageKmPerLitre : null);

    final double? effectiveCostPerKm = measuredSummary.averageCostPerKm ?? partialCostPerKm;

    // Build Estimated / Partial Mileage Details
    MileageEstimate estimate;

    if (hasMeasured) {
      // Vehicle has verified full tanks
      final baselineMileage = measuredSummary.weightedAverageMileageKmPerLitre!;

      int lastFullIndex = -1;
      for (int i = entries.length - 1; i >= 0; i--) {
        if (entries[i].isFullTank) {
          lastFullIndex = i;
          break;
        }
      }

      final bool hasPartialsAfterLastFull =
          lastFullIndex >= 0 && lastFullIndex < entries.length - 1;

      if (hasPartialsAfterLastFull) {
        final lastFull = entries[lastFullIndex];
        final distanceSinceFull = entries.last.odometerKm - lastFull.odometerKm;
        double fuelSinceFull = 0.0;
        for (int i = lastFullIndex + 1; i < entries.length; i++) {
          fuelSinceFull += entries[i].fuelQuantityLitres;
        }

        if (distanceSinceFull > 0 && fuelSinceFull > 0) {
          final rawPartialRatio = distanceSinceFull / fuelSinceFull;
          final estimatedValue = (0.70 * baselineMileage) + (0.30 * rawPartialRatio);

          estimate = MileageEstimate(
            estimatedKmPerLitre: double.parse(estimatedValue.toStringAsFixed(1)),
            methodDescription:
                'Baseline & Partial Refuels (${baselineMileage.toStringAsFixed(1)} km/L baseline over ${distanceSinceFull.toStringAsFixed(0)} km)',
            limitations:
                'Blended with your verified full-tank baseline and current partial refills.',
            isAvailable: true,
          );
        } else {
          estimate = MileageEstimate(
            estimatedKmPerLitre: baselineMileage,
            methodDescription: 'Verified Historical Baseline',
            limitations: 'Using verified full-tank average mileage.',
            isAvailable: true,
          );
        }
      } else {
        estimate = MileageEstimate(
          estimatedKmPerLitre: measuredSummary.latestInterval?.mileageKmPerLitre ?? baselineMileage,
          methodDescription: 'Verified Full-Tank Measurement Reference',
          limitations: 'Measured from verified full-tank refuel.',
          isAvailable: true,
        );
      }
    } else if (overallAveragePartialMileage != null) {
      // User has NOT filled a full tank, but has recorded partial refills!
      // Calculate mileage directly from partial fillups!
      estimate = MileageEstimate(
        estimatedKmPerLitre: double.parse(overallAveragePartialMileage.toStringAsFixed(1)),
        methodDescription:
            'Partial-Fill Refuel Tracking (${partialIntervals.length} refuel stop${partialIntervals.length > 1 ? "s" : ""})',
        limitations:
            'Calculated from distance travelled between partial refills. No full-tank required.',
        isAvailable: true,
      );
    } else if (expectedMileageKmPerLitre != null && expectedMileageKmPerLitre > 0) {
      estimate = MileageEstimate(
        estimatedKmPerLitre: expectedMileageKmPerLitre,
        methodDescription:
            'Vehicle Target (${expectedMileageKmPerLitre.toStringAsFixed(1)} km/L)',
        limitations: 'Log your next refuel to calculate actual mileage.',
        isAvailable: true,
      );
    } else {
      estimate = MileageEstimate.unavailable(
        reason: 'Log your next refuel with odometer reading to calculate mileage.',
      );
    }

    return VehicleMileageAnalytics(
      latestMeasuredInterval: measuredSummary.latestInterval,
      latestPartialInterval: partialIntervals.isNotEmpty ? partialIntervals.last : null,
      partialIntervals: partialIntervals,
      estimatedMileage: estimate,
      overallAverageMeasuredMileage: measuredSummary.weightedAverageMileageKmPerLitre,
      overallAveragePartialMileage: overallAveragePartialMileage,
      effectiveAverageMileage: effectiveAverageMileage,
      effectiveLatestMileage: effectiveLatestMileage,
      distanceSinceLastEntryKm: distanceSinceLastEntry,
      totalDistanceTravelledKm: totalDistanceTravelled,
      totalFuelPurchasedLitres: totalFuelPurchased,
      totalFuelCostMinorUnits: totalFuelCost,
      averageCostPerKm: effectiveCostPerKm,
      validMeasuredIntervalsCount: measuredSummary.validIntervalsCount,
      validPartialIntervalsCount: partialIntervals.length,
      totalEntriesCount: entries.length,
    );
  }
}
