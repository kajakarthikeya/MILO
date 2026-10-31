import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:milo/data/database/app_database.dart';
import 'package:milo/data/repositories/fuel_repository.dart';

void main() {
  late AppDatabase db;
  late FuelRepository fuelRepo;

  setUp(() {
    // In-memory SQLite database for deterministic, fast isolated unit tests
    db = AppDatabase.forTesting(NativeDatabase.memory());
    fuelRepo = FuelRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('Drift Database & DAO Tests', () {
    test('Vehicle CRUD and isolation', () async {
      final now = DateTime.now();
      final vehicle1 = VehiclesCompanion.insert(
        id: 'v_scooter_1',
        nickname: 'Blue Activa',
        make: 'Honda',
        model: 'Activa 6G',
        vehicleType: 'scooter',
        fuelType: 'petrol',
        initialOdometerKm: 1200.0,
        createdAt: now,
        updatedAt: now,
      );

      final vehicle2 = VehiclesCompanion.insert(
        id: 'v_bike_2',
        nickname: 'Black Splendor',
        make: 'Hero',
        model: 'Splendor Plus',
        vehicleType: 'motorcycle',
        fuelType: 'petrol',
        initialOdometerKm: 8500.0,
        createdAt: now,
        updatedAt: now,
      );

      await db.vehicleDao.insertVehicle(vehicle1);
      await db.vehicleDao.insertVehicle(vehicle2);

      final all = await db.vehicleDao.getAllVehicles();
      expect(all.length, equals(2));

      final retrieved = await db.vehicleDao.getVehicleById('v_scooter_1');
      expect(retrieved, isNotNull);
      expect(retrieved!.nickname, equals('Blue Activa'));
      expect(retrieved.initialOdometerKm, equals(1200.0));

      // Test Archiving
      await db.vehicleDao.setArchivedStatus('v_scooter_1', true);
      final activeOnly = await db.vehicleDao.getAllVehicles(
        includeArchived: false,
      );
      expect(activeOnly.length, equals(1));
      expect(activeOnly.first.id, equals('v_bike_2'));

      final withArchived = await db.vehicleDao.getAllVehicles(
        includeArchived: true,
      );
      expect(withArchived.length, equals(2));
    });

    test('Fuel Entries CRUD, Foreign Keys, and Mileage Regeneration', () async {
      final now = DateTime(2026, 10, 1, 10, 0);

      // Create vehicle
      await db.vehicleDao.insertVehicle(
        VehiclesCompanion.insert(
          id: 'v_hunter_350',
          nickname: 'Hunter',
          make: 'Royal Enfield',
          model: 'Hunter 350',
          vehicleType: 'motorcycle',
          fuelType: 'petrol',
          initialOdometerKm: 3000.0,
          createdAt: now,
          updatedAt: now,
        ),
      );

      // Insert Fuel Entry A (Full Tank, 5000 km, 3L)
      await fuelRepo.addFuelEntry(
        vehicleId: 'v_hunter_350',
        timestamp: now,
        odometerKm: 5000.0,
        amountPaidMinorUnits: 31500, // ₹315
        fuelQuantity: 3.0,
        unitPriceMinorUnitsPerLitre: 10500,
        entryMethod: 'byLitres',
        fillType: 'full',
      );

      // Insert Fuel Entry B (Partial Fill, 5060 km, 1L)
      await fuelRepo.addFuelEntry(
        vehicleId: 'v_hunter_350',
        timestamp: now.add(const Duration(days: 2)),
        odometerKm: 5060.0,
        amountPaidMinorUnits: 10500,
        fuelQuantity: 1.0,
        unitPriceMinorUnitsPerLitre: 10500,
        entryMethod: 'byLitres',
        fillType: 'partial',
      );

      // Insert Fuel Entry C (Partial Fill, 5120 km, 2L)
      await fuelRepo.addFuelEntry(
        vehicleId: 'v_hunter_350',
        timestamp: now.add(const Duration(days: 4)),
        odometerKm: 5120.0,
        amountPaidMinorUnits: 21000,
        fuelQuantity: 2.0,
        unitPriceMinorUnitsPerLitre: 10500,
        entryMethod: 'byLitres',
        fillType: 'partial',
      );

      // Insert Fuel Entry D (Full Tank, 5180 km, 3L)
      final entryD = await fuelRepo.addFuelEntry(
        vehicleId: 'v_hunter_350',
        timestamp: now.add(const Duration(days: 6)),
        odometerKm: 5180.0,
        amountPaidMinorUnits: 31500,
        fuelQuantity: 3.0,
        unitPriceMinorUnitsPerLitre: 10500,
        entryMethod: 'byLitres',
        fillType: 'full',
      );

      final entries = await fuelRepo.getEntriesForVehicle('v_hunter_350');
      expect(entries.length, equals(4));

      var savedIntervals = await fuelRepo.getIntervalsForVehicle('v_hunter_350');
      expect(savedIntervals.length, equals(1));
      // 180 km / (1 + 2 + 3 = 6 L) = 30.0 km/L
      expect(savedIntervals.first.mileageKmPerLitre, equals(30.0));
      expect(savedIntervals.first.distanceKm, equals(180.0));
      expect(savedIntervals.first.fuelConsumedLitres, equals(6.0));

      // 5. Test Editing an entry recalculates affected mileage results
      // Edit entry D to 5,240 km (+60 km, distance becomes 240 km, mileage 240 / 6 = 40.0 km/L)
      await fuelRepo.updateFuelEntry(
        id: entryD.id,
        vehicleId: 'v_hunter_350',
        timestamp: now.add(const Duration(days: 6)),
        odometerKm: 5240.0,
        amountPaidMinorUnits: 31500,
        fuelQuantity: 3.0,
        unitPriceMinorUnitsPerLitre: 10500,
        entryMethod: 'byLitres',
        fillType: 'full',
      );

      savedIntervals = await fuelRepo.getIntervalsForVehicle('v_hunter_350');
      expect(savedIntervals.length, equals(1));
      expect(savedIntervals.first.distanceKm, equals(240.0));
      expect(savedIntervals.first.mileageKmPerLitre, equals(40.0));

      // 6. Test Deleting an entry recalculates affected mileage results
      // Deleting entry D removes the ending full tank; no completed full-tank interval remains!
      await fuelRepo.deleteFuelEntry(
        id: entryD.id,
        vehicleId: 'v_hunter_350',
      );

      savedIntervals = await fuelRepo.getIntervalsForVehicle('v_hunter_350');
      expect(savedIntervals, isEmpty); // Automatically cleaned up and recalculated

      // Test Cascading Delete: deleting vehicle cascades to fuel entries & mileage intervals
      await db.vehicleDao.deleteVehicle('v_hunter_350');
      final remainingEntries = await fuelRepo.getEntriesForVehicle(
        'v_hunter_350',
      );
      expect(remainingEntries, isEmpty);
    });

    test('UserProfile and Budget persistence', () async {
      final now = DateTime.now();
      await db.userProfileDao.upsertProfile(
        UserProfilesCompanion.insert(
          id: 'primary_user',
          displayName: const Value('Alex Rider'),
          currencyCode: const Value('INR'),
          distanceUnit: const Value('km'),
          themePreference: const Value('light'),
          onboardingCompleted: const Value(true),
          createdAt: now,
          updatedAt: now,
        ),
      );

      final profile = await db.userProfileDao.getProfile();
      expect(profile, isNotNull);
      expect(profile!.displayName, equals('Alex Rider'));
      expect(profile.currencyCode, equals('INR'));
      expect(profile.onboardingCompleted, isTrue);

      // Overall monthly fuel budget
      await db.fuelBudgetDao.upsertBudget(
        FuelBudgetsCompanion.insert(
          id: 'budget_overall',
          monthlyLimitMinorUnits: 500000, // ₹5,000.00
          warningThresholdPercent: const Value(85),
          createdAt: now,
          updatedAt: now,
        ),
      );

      final budget = await db.fuelBudgetDao.getBudgetForVehicle(null);
      expect(budget, isNotNull);
      expect(budget!.monthlyLimitMinorUnits, equals(500000));
      expect(budget.warningThresholdPercent, equals(85));
    });
  });
}
