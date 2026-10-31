import 'package:flutter_test/flutter_test.dart';
import 'package:milo/domain/calculations/mileage_engine.dart';

void main() {
  group('MileageEngine & Analytics Unit Tests', () {
    // 1. Full-tank-to-full-tank calculation returns 30 km/L for the prompt example
    test('1. Full-tank-to-full-tank calculation returns 30 km/L for prompt example', () {
      // Prompt specification:
      // Entry 1: 5,000 km, Full tank, 3 L
      // Entry 2: 5,060 km, Partial, 1 L
      // Entry 3: 5,120 km, Partial, 2 L
      // Entry 4: 5,180 km, Full tank, 3 L
      // Consumed: 1 + 2 + 3 = 6 L. Distance: 5180 - 5000 = 180 km. Mileage: 30 km/L.
      final entries = [
        FuelCalculationEntry(
          id: '1',
          vehicleId: 'bike_01',
          timestamp: DateTime(2026, 10, 1, 10, 0),
          odometerKm: 5000.0,
          amountPaidMinorUnits: 31500, // ₹315.00
          fuelQuantityLitres: 3.0,
          isFullTank: true,
        ),
        FuelCalculationEntry(
          id: '2',
          vehicleId: 'bike_01',
          timestamp: DateTime(2026, 10, 3, 11, 0),
          odometerKm: 5060.0,
          amountPaidMinorUnits: 10500, // ₹105.00
          fuelQuantityLitres: 1.0,
          isFullTank: false,
        ),
        FuelCalculationEntry(
          id: '3',
          vehicleId: 'bike_01',
          timestamp: DateTime(2026, 10, 5, 12, 0),
          odometerKm: 5120.0,
          amountPaidMinorUnits: 21000, // ₹210.00
          fuelQuantityLitres: 2.0,
          isFullTank: false,
        ),
        FuelCalculationEntry(
          id: '4',
          vehicleId: 'bike_01',
          timestamp: DateTime(2026, 10, 7, 13, 0),
          odometerKm: 5180.0,
          amountPaidMinorUnits: 31500, // ₹315.00
          fuelQuantityLitres: 3.0,
          isFullTank: true,
        ),
      ];

      final intervals = MileageEngine.calculateIntervals(entries);
      expect(intervals.length, equals(1));

      final interval = intervals.first;
      expect(interval.distanceKm, equals(180.0));
      expect(interval.fuelConsumedLitres, equals(6.0));
      expect(interval.mileageKmPerLitre, equals(30.0));
      expect(interval.fuelCostMinorUnits, equals(63000));
      expect(interval.costPerKm, equals(3.50));
      expect(interval.intermediateRefillsCount, equals(2));

      final analytics = MileageEngine.calculateAnalytics(
        rawEntries: entries,
        initialVehicleOdometerKm: 5000.0,
      );
      expect(analytics.overallAverageMeasuredMileage, equals(30.0));
      expect(analytics.latestMeasuredInterval?.mileageKmPerLitre, equals(30.0));
      expect(analytics.validMeasuredIntervalsCount, equals(1));
    });

    // 2. Partial entries are included in fuel history and total expenditure
    test('2. Partial entries are included in fuel history and total expenditure', () {
      final entries = [
        FuelCalculationEntry(
          id: '1',
          vehicleId: 'v1',
          timestamp: DateTime(2026, 10, 1),
          odometerKm: 1000.0,
          amountPaidMinorUnits: 20000, // ₹200
          fuelQuantityLitres: 2.0,
          isFullTank: true,
        ),
        FuelCalculationEntry(
          id: '2',
          vehicleId: 'v1',
          timestamp: DateTime(2026, 10, 3),
          odometerKm: 1050.0,
          amountPaidMinorUnits: 15000, // ₹150 (Partial)
          fuelQuantityLitres: 1.5,
          isFullTank: false,
        ),
        FuelCalculationEntry(
          id: '3',
          vehicleId: 'v1',
          timestamp: DateTime(2026, 10, 6),
          odometerKm: 1110.0,
          amountPaidMinorUnits: 25000, // ₹250 (Partial)
          fuelQuantityLitres: 2.5,
          isFullTank: false,
        ),
      ];

      final analytics = MileageEngine.calculateAnalytics(
        rawEntries: entries,
        initialVehicleOdometerKm: 1000.0,
      );

      // Total fuel: 2.0 + 1.5 + 2.5 = 6.0 L
      expect(analytics.totalFuelPurchasedLitres, equals(6.0));
      // Total expenditure: 20000 + 15000 + 25000 = 60000 paise (₹600.00)
      expect(analytics.totalFuelCostMinorUnits, equals(60000));
      expect(analytics.totalEntriesCount, equals(3));
      // Distance since last entry: 1110 - 1050 = 60 km
      expect(analytics.distanceSinceLastEntryKm, equals(60.0));
    });

    // 3. Partial-only records calculate valid partial interval and average mileage without requiring full tank
    test('3. Partial-only records calculate valid partial interval and average mileage without requiring full tank', () {
      // User never fills full tank:
      // Entry 1: 5,000 km, Partial, 2.0 L
      // Entry 2: 5,070 km, Partial, 2.0 L (Leg distance: 70 km / 2.0 L = 35.0 km/L)
      // Entry 3: 5,140 km, Partial, 2.0 L (Leg distance: 70 km / 2.0 L = 35.0 km/L)
      final partialEntries = [
        FuelCalculationEntry(
          id: 'p1',
          vehicleId: 'car_01',
          timestamp: DateTime(2026, 10, 1),
          odometerKm: 5000.0,
          amountPaidMinorUnits: 21000,
          fuelQuantityLitres: 2.0,
          isFullTank: false,
        ),
        FuelCalculationEntry(
          id: 'p2',
          vehicleId: 'car_01',
          timestamp: DateTime(2026, 10, 5),
          odometerKm: 5070.0,
          amountPaidMinorUnits: 21000,
          fuelQuantityLitres: 2.0,
          isFullTank: false,
        ),
        FuelCalculationEntry(
          id: 'p3',
          vehicleId: 'car_01',
          timestamp: DateTime(2026, 10, 9),
          odometerKm: 5140.0,
          amountPaidMinorUnits: 21000,
          fuelQuantityLitres: 2.0,
          isFullTank: false,
        ),
      ];

      // Verified full-tank intervals are empty because user never filled a full tank
      final intervals = MileageEngine.calculateIntervals(partialEntries);
      expect(intervals, isEmpty);

      // But partial intervals and effective mileage are calculated accurately!
      final analytics = MileageEngine.calculateAnalytics(
        rawEntries: partialEntries,
        initialVehicleOdometerKm: 5000.0,
      );

      expect(analytics.validMeasuredIntervalsCount, equals(0));
      expect(analytics.validPartialIntervalsCount, equals(2));
      expect(analytics.partialIntervals.length, equals(2));

      // First leg: 5070 - 5000 = 70 km on 2.0 L = 35.0 km/L
      expect(analytics.partialIntervals[0].distanceKm, equals(70.0));
      expect(analytics.partialIntervals[0].mileageKmPerLitre, equals(35.0));

      // Second leg: 5140 - 5070 = 70 km on 2.0 L = 35.0 km/L
      expect(analytics.partialIntervals[1].distanceKm, equals(70.0));
      expect(analytics.partialIntervals[1].mileageKmPerLitre, equals(35.0));

      // Overall average partial mileage: 140 km / 4.0 L = 35.0 km/L
      expect(analytics.overallAveragePartialMileage, equals(35.0));
      // Effective average and latest mileage automatically reflect the partial fill economy!
      expect(analytics.effectiveAverageMileage, equals(35.0));
      expect(analytics.effectiveLatestMileage, equals(35.0));
      expect(analytics.estimatedMileage.isAvailable, isTrue);
      expect(analytics.estimatedMileage.estimatedKmPerLitre, equals(35.0));
    });

    // 4. A valid estimated mileage is shown when estimation data exists
    test('4. A valid estimated mileage is shown when estimation data exists', () {
      // 1. Single entry with no distance driven from initial odometer -> estimate unavailable
      final singleNoDistance = [
        FuelCalculationEntry(
          id: 'p1',
          vehicleId: 'v1',
          timestamp: DateTime(2026, 10, 1),
          odometerKm: 2000.0,
          amountPaidMinorUnits: 10000,
          fuelQuantityLitres: 1.0,
          isFullTank: false,
        ),
      ];
      final noDistanceAnalytics = MileageEngine.calculateAnalytics(
        rawEntries: singleNoDistance,
        initialVehicleOdometerKm: 2000.0, // Same odometer as entry
      );
      expect(noDistanceAnalytics.estimatedMileage.isAvailable, isFalse);

      // 2. Add two full tanks to establish verified baseline (30 km/L)
      // Then add subsequent partial refill -> clearly labelled estimated mileage is available!
      final entriesWithBaselineAndPartial = [
        FuelCalculationEntry(
          id: 'f1',
          vehicleId: 'v1',
          timestamp: DateTime(2026, 10, 1),
          odometerKm: 5000.0,
          amountPaidMinorUnits: 31500,
          fuelQuantityLitres: 3.0,
          isFullTank: true,
        ),
        FuelCalculationEntry(
          id: 'f2',
          vehicleId: 'v1',
          timestamp: DateTime(2026, 10, 5),
          odometerKm: 5180.0,
          amountPaidMinorUnits: 63000,
          fuelQuantityLitres: 6.0,
          isFullTank: true, // Baseline interval: 180 km / 6 L = 30.0 km/L
        ),
        FuelCalculationEntry(
          id: 'p3',
          vehicleId: 'v1',
          timestamp: DateTime(2026, 10, 8),
          odometerKm: 5240.0, // 60 km later
          amountPaidMinorUnits: 21000,
          fuelQuantityLitres: 2.0, // Partial fill
          isFullTank: false,
        ),
      ];

      final analyticsWithEstimate = MileageEngine.calculateAnalytics(
        rawEntries: entriesWithBaselineAndPartial,
        initialVehicleOdometerKm: 5000.0,
      );

      expect(analyticsWithEstimate.overallAverageMeasuredMileage, equals(30.0));
      expect(analyticsWithEstimate.estimatedMileage.isAvailable, isTrue);
      expect(analyticsWithEstimate.estimatedMileage.estimatedKmPerLitre, isNotNull);
      expect(
        analyticsWithEstimate.estimatedMileage.methodDescription,
        contains('Baseline & Partial Refuels'),
      );
      expect(
        analyticsWithEstimate.estimatedMileage.limitations,
        contains('Blended with your verified full-tank baseline'),
      );
    });

    // 7. Entries for one vehicle do not affect another vehicle's mileage
    test('7. Entries for one vehicle do not affect another vehicle\'s mileage', () {
      final entriesV1 = [
        FuelCalculationEntry(
          id: 'v1_1',
          vehicleId: 'v1',
          timestamp: DateTime(2026, 10, 1),
          odometerKm: 1000.0,
          amountPaidMinorUnits: 50000,
          fuelQuantityLitres: 5.0,
          isFullTank: true,
        ),
        FuelCalculationEntry(
          id: 'v1_2',
          vehicleId: 'v1',
          timestamp: DateTime(2026, 10, 5),
          odometerKm: 1200.0,
          amountPaidMinorUnits: 50000,
          fuelQuantityLitres: 5.0,
          isFullTank: true, // 200 km / 5 L = 40.0 km/L
        ),
      ];

      final entriesV2 = [
        FuelCalculationEntry(
          id: 'v2_1',
          vehicleId: 'v2',
          timestamp: DateTime(2026, 10, 2),
          odometerKm: 10000.0,
          amountPaidMinorUnits: 100000,
          fuelQuantityLitres: 10.0,
          isFullTank: true,
        ),
        FuelCalculationEntry(
          id: 'v2_2',
          vehicleId: 'v2',
          timestamp: DateTime(2026, 10, 6),
          odometerKm: 10150.0,
          amountPaidMinorUnits: 100000,
          fuelQuantityLitres: 10.0,
          isFullTank: true, // 150 km / 10 L = 15.0 km/L
        ),
      ];

      final analyticsV1 = MileageEngine.calculateAnalytics(
        rawEntries: entriesV1,
        initialVehicleOdometerKm: 1000.0,
      );
      final analyticsV2 = MileageEngine.calculateAnalytics(
        rawEntries: entriesV2,
        initialVehicleOdometerKm: 10000.0,
      );

      expect(analyticsV1.overallAverageMeasuredMileage, equals(40.0));
      expect(analyticsV2.overallAverageMeasuredMileage, equals(15.0));
      expect(analyticsV1.totalDistanceTravelledKm, equals(200.0));
      expect(analyticsV2.totalDistanceTravelledKm, equals(150.0));
    });

    test('Multiple entries with same odometer reading do not divide by zero', () {
      final duplicateOdoEntries = [
        FuelCalculationEntry(
          id: 'd1',
          vehicleId: 'v1',
          timestamp: DateTime(2026, 10, 1),
          odometerKm: 5000.0,
          amountPaidMinorUnits: 10000,
          fuelQuantityLitres: 1.0,
          isFullTank: true,
        ),
        FuelCalculationEntry(
          id: 'd2',
          vehicleId: 'v1',
          timestamp: DateTime(2026, 10, 1, 10, 30),
          odometerKm: 5000.0, // Same odometer!
          amountPaidMinorUnits: 10000,
          fuelQuantityLitres: 1.0,
          isFullTank: true,
        ),
      ];

      final intervals = MileageEngine.calculateIntervals(duplicateOdoEntries);
      expect(intervals, isEmpty); // Skips 0 distance without dividing by zero
    });

    test('Consecutive refill intervals and arithmetic average mileage match prompt examples (33, 29, 45 -> 35.67 km/L)', () {
      // User prompt specification:
      // Refill 1: 6,550 km, 4 L, Partial
      // Refill 2: 6,682 km, 2 L, Partial -> Distance: 132 km, Divisor: 4 L (prev) -> 132 / 4 = 33 km/L
      // Refill 3: 6,740 km, 1 L, Partial -> Distance: 58 km, Divisor: 2 L (prev) -> 58 / 2 = 29 km/L
      // Refill 4: 6,785 km, 7 L, Partial -> Distance: 45 km, Divisor: 1 L (prev) -> 45 / 1 = 45 km/L
      // Arithmetic average: (33 + 29 + 45) / 3 = 107 / 3 = 35.6666... -> 35.67 km/L
      final entries = [
        FuelCalculationEntry(
          id: 'r1',
          vehicleId: 'bike_01',
          timestamp: DateTime(2026, 10, 1),
          odometerKm: 6550.0,
          amountPaidMinorUnits: 46896, // 4 L * ₹117.24 = ₹468.96
          fuelQuantityLitres: 4.0,
          isFullTank: false,
        ),
        FuelCalculationEntry(
          id: 'r2',
          vehicleId: 'bike_01',
          timestamp: DateTime(2026, 10, 3),
          odometerKm: 6682.0,
          amountPaidMinorUnits: 23448, // 2 L * ₹117.24 = ₹234.48
          fuelQuantityLitres: 2.0,
          isFullTank: false,
        ),
        FuelCalculationEntry(
          id: 'r3',
          vehicleId: 'bike_01',
          timestamp: DateTime(2026, 10, 5),
          odometerKm: 6740.0,
          amountPaidMinorUnits: 11724, // 1 L * ₹117.24 = ₹117.24
          fuelQuantityLitres: 1.0,
          isFullTank: false,
        ),
        FuelCalculationEntry(
          id: 'r4',
          vehicleId: 'bike_01',
          timestamp: DateTime(2026, 10, 7),
          odometerKm: 6785.0,
          amountPaidMinorUnits: 82068, // 7 L * ₹117.24 = ₹820.68
          fuelQuantityLitres: 7.0,
          isFullTank: false,
        ),
      ];

      final intervals = MileageEngine.calculateConsecutiveIntervals(entries);
      expect(intervals.length, equals(3));

      // Interval 1: Refill 1 -> Refill 2
      // 132 km travelled using 4 L from Refill 1 = 33 km/L
      expect(intervals[0].startOdometerKm, equals(6550.0));
      expect(intervals[0].endOdometerKm, equals(6682.0));
      expect(intervals[0].distanceKm, equals(132.0));
      expect(intervals[0].previousRefillFuelLitres, equals(4.0));
      expect(intervals[0].estimatedMileageKmPerLitre, equals(33.0));
      expect(intervals[0].refillPairLabel, equals('Refill 1 → Refill 2'));

      // Interval 2: Refill 2 -> Refill 3
      // 58 km travelled using 2 L from Refill 2 = 29 km/L
      expect(intervals[1].startOdometerKm, equals(6682.0));
      expect(intervals[1].endOdometerKm, equals(6740.0));
      expect(intervals[1].distanceKm, equals(58.0));
      expect(intervals[1].previousRefillFuelLitres, equals(2.0));
      expect(intervals[1].estimatedMileageKmPerLitre, equals(29.0));
      expect(intervals[1].refillPairLabel, equals('Refill 2 → Refill 3'));

      // Interval 3: Refill 3 -> Refill 4
      // 45 km travelled using 1 L from Refill 3 = 45 km/L
      expect(intervals[2].startOdometerKm, equals(6740.0));
      expect(intervals[2].endOdometerKm, equals(6785.0));
      expect(intervals[2].distanceKm, equals(45.0));
      expect(intervals[2].previousRefillFuelLitres, equals(1.0));
      expect(intervals[2].estimatedMileageKmPerLitre, equals(45.0));
      expect(intervals[2].refillPairLabel, equals('Refill 3 → Refill 4'));

      // Arithmetic Average: (33 + 29 + 45) / 3 = 35.67 km/L
      final avgMileage = MileageEngine.calculateArithmeticAverageMileage(intervals);
      expect(avgMileage, isNotNull);
      expect(avgMileage!, closeTo(35.67, 0.01));
      expect(avgMileage.toStringAsFixed(2), equals('35.67'));
    });
  });
}
