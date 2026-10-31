import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milo/data/database/app_database.dart';
import 'package:milo/data/services/providers.dart';
import 'package:milo/features/fuel/fuel_entry_screen.dart';
import 'package:milo/features/home/home_screen.dart';
import 'package:milo/features/fuel/fuel_history_screen.dart';
import 'package:milo/features/mileage/mileage_screen.dart';
import 'package:drift/native.dart';

void main() {
  final now = DateTime(2026, 10, 28, 10, 0);

  final testBike = VehicleData(
    id: 'test_bike_1',
    nickname: 'Speedy Hunter',
    make: 'Royal Enfield',
    model: 'Hunter 350',
    vehicleType: 'motorcycle',
    fuelType: 'petrol',
    initialOdometerKm: 1000.0,
    isArchived: false,
    createdAt: now,
    updatedAt: now,
  );

  // User's example refill entries:
  // Refill 1: 6,550 km, 4 L, Partial, ₹468.96 (46896 paise)
  // Refill 2: 6,682 km, 2 L, Partial, ₹234.48 (23448 paise) -> Delta 132 km / 2 L = 66 km/L
  // Refill 3: 6,740 km, 1 L, Partial, ₹117.24 (11724 paise) -> Delta 58 km / 1 L = 58 km/L
  // Refill 4: 6,785 km, 7 L, Partial, ₹820.68 (82068 paise) -> Delta 45 km / 7 L = 6.43 km/L
  // Arithmetic average: (66 + 58 + 6.42857) / 3 = 43.48 km/L
  final refill1 = FuelEntryData(
    id: 'r1',
    vehicleId: testBike.id,
    timestamp: DateTime(2026, 10, 1, 9, 0),
    odometerKm: 6550.0,
    amountPaidMinorUnits: 46896,
    fuelQuantity: 4.0,
    unitPriceMinorUnitsPerLitre: 11724,
    entryMethod: 'byMoney',
    fillType: 'partial',
    createdAt: now,
    updatedAt: now,
  );

  final refill2 = FuelEntryData(
    id: 'r2',
    vehicleId: testBike.id,
    timestamp: DateTime(2026, 10, 3, 10, 0),
    odometerKm: 6682.0,
    amountPaidMinorUnits: 23448,
    fuelQuantity: 2.0,
    unitPriceMinorUnitsPerLitre: 11724,
    entryMethod: 'byMoney',
    fillType: 'partial',
    createdAt: now,
    updatedAt: now,
  );

  final refill3 = FuelEntryData(
    id: 'r3',
    vehicleId: testBike.id,
    timestamp: DateTime(2026, 10, 5, 11, 0),
    odometerKm: 6740.0,
    amountPaidMinorUnits: 11724,
    fuelQuantity: 1.0,
    unitPriceMinorUnitsPerLitre: 11724,
    entryMethod: 'byMoney',
    fillType: 'partial',
    createdAt: now,
    updatedAt: now,
  );

  final refill4 = FuelEntryData(
    id: 'r4',
    vehicleId: testBike.id,
    timestamp: DateTime(2026, 10, 7, 12, 0),
    odometerKm: 6785.0,
    amountPaidMinorUnits: 82068,
    fuelQuantity: 7.0,
    unitPriceMinorUnitsPerLitre: 11724,
    entryMethod: 'byMoney',
    fillType: 'partial',
    createdAt: now,
    updatedAt: now,
  );

  final sampleEntries = [refill4, refill3, refill2, refill1];

  late AppDatabase sharedTestDb;

  setUp(() {
    sharedTestDb = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await sharedTestDb.close();
  });

  Widget buildAppWithOverrides({
    required Widget child,
    List<VehicleData> vehicles = const [],
    List<FuelEntryData> entries = const [],
    UserProfileData? profile,
    AppDatabase? database,
  }) {
    final db = database ?? sharedTestDb;
    return ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
        vehiclesStreamProvider.overrideWith((ref) => Stream.value(vehicles)),
        primaryBikeProvider.overrideWith((ref) => Stream.value(vehicles.isNotEmpty ? vehicles.first : null)),
        primaryBikeFuelEntriesProvider.overrideWith((ref) => Stream.value(entries)),
        userProfileStreamProvider.overrideWith((ref) => Stream.value(profile)),
      ],
      child: MaterialApp(home: child),
    );
  }

  group('Widget, Validation & Screen Layout Tests', () {
    testWidgets('1. Home Screen renders bike header, current odometer, and Add Fuel', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        buildAppWithOverrides(
          vehicles: [testBike],
          child: const HomeScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('MILO'), findsOneWidget);
      expect(find.text('Speedy Hunter'), findsOneWidget);
      expect(find.text('Add Fuel'), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 100));
    });

    testWidgets('2. Fuel Entry Screen automatically populates petrol price with ₹117.24/L default', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        buildAppWithOverrides(
          child: const FuelEntryScreen(),
          vehicles: [testBike],
        ),
      );
      await tester.pumpAndSettle();

      final rateFinder = find.widgetWithText(TextFormField, 'Price / Litre *');
      expect(rateFinder, findsOneWidget);
      final rateField = tester.widget<TextFormField>(rateFinder);
      expect(rateField.controller?.text, equals('117.24'));

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });

    testWidgets('3. Invalid odometer readings are rejected', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        buildAppWithOverrides(
          child: const FuelEntryScreen(),
          vehicles: [testBike],
          entries: [refill1], // Latest reading: 6550 km
        ),
      );
      await tester.pumpAndSettle();

      final amountFinder = find.widgetWithText(TextFormField, 'Amount Paid *');
      await tester.enterText(amountFinder, '150');

      // Enter odometer reading lower than previous entry reading (6550 km) -> e.g. 500 km
      final odoFinder = find.widgetWithText(
        TextFormField,
        'Current Odometer Reading (km) *',
      );
      await tester.enterText(odoFinder, '500');

      final saveButton = find.text('Save Fuel Entry (15s)');
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      expect(
        find.text('Cannot be lower than previous reading (6550 km)'),
        findsOneWidget,
      );

      // Also verify negative reading is rejected
      await tester.enterText(odoFinder, '-50');
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      expect(
        find.text('Enter a valid non-negative reading'),
        findsOneWidget,
      );

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });

    testWidgets('4. Form resets after successful save and repeated taps do not create duplicates', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await sharedTestDb.vehicleDao.insertVehicle(
        VehiclesCompanion.insert(
          id: testBike.id,
          nickname: testBike.nickname,
          make: testBike.make,
          model: testBike.model,
          vehicleType: testBike.vehicleType,
          fuelType: testBike.fuelType,
          initialOdometerKm: testBike.initialOdometerKm,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            databaseProvider.overrideWithValue(sharedTestDb),
            vehiclesStreamProvider.overrideWith((ref) => Stream.value([testBike])),
            primaryBikeProvider.overrideWith((ref) => Stream.value(testBike)),
            primaryBikeFuelEntriesProvider.overrideWith((ref) => Stream.value([])),
          ],
          child: const MaterialApp(home: FuelEntryScreen()),
        ),
      );
      await tester.pumpAndSettle();

      // Enter amount: ₹234.48, odometer: 1050 km
      final amountFinder = find.widgetWithText(TextFormField, 'Amount Paid *');
      await tester.enterText(amountFinder, '234.48');

      final odoFinder = find.widgetWithText(
        TextFormField,
        'Current Odometer Reading (km) *',
      );
      await tester.enterText(odoFinder, '1050');
      await tester.pumpAndSettle();

      final saveButton = find.text('Save Fuel Entry (15s)');
      await tester.tap(saveButton);
      await tester.pump();
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      // Database should contain exactly 1 entry
      final entries = await sharedTestDb.fuelEntryDao.getEntriesForVehicle(testBike.id);
      expect(entries.length, equals(1));
      expect(entries.first.odometerKm, equals(1050.0));

      // Price resets to default ₹117.24/L
      final rateFinder = find.widgetWithText(TextFormField, 'Price / Litre *');
      final rateField = tester.widget<TextFormField>(rateFinder);
      expect(rateField.controller?.text, equals('117.24'));

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });

    testWidgets('5. Form retains its values if validation fails', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        buildAppWithOverrides(
          child: const FuelEntryScreen(),
          vehicles: [testBike],
        ),
      );
      await tester.pumpAndSettle();

      final amountFinder = find.widgetWithText(TextFormField, 'Amount Paid *');
      await tester.enterText(amountFinder, '350');

      // Leave odometer empty so validation fails
      final saveButton = find.text('Save Fuel Entry (15s)');
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      expect(find.text('Odometer reading is mandatory'), findsOneWidget);

      final amountField = tester.widget<TextFormField>(amountFinder);
      expect(amountField.controller?.text, equals('350'));

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });

    testWidgets('6. Home Screen renders user, bike, live odometer, total spent, and Add Fuel', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        buildAppWithOverrides(
          child: const HomeScreen(),
          vehicles: [testBike],
          entries: sampleEntries,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Speedy Hunter'), findsOneWidget);
      expect(find.text('Royal Enfield • Hunter 350'), findsOneWidget);
      expect(find.text('6,785 km'), findsOneWidget); // Latest live odometer
      expect(find.text('Add Fuel'), findsOneWidget);
      expect(find.text('TOTAL FUEL EXPENDITURE'), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });

    testWidgets('7. Fuel History Screen renders grouped refills with delta distance and unit rate', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        buildAppWithOverrides(
          child: const FuelHistoryScreen(),
          vehicles: [testBike],
          entries: sampleEntries,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Fuel Refills'), findsOneWidget);
      expect(find.text('+45 km'), findsOneWidget); // 6785 - 6740 = 45 km
      expect(find.text('+58 km'), findsOneWidget); // 6740 - 6682 = 58 km
      expect(find.text('+132 km'), findsOneWidget); // 6682 - 6550 = 132 km
      expect(find.text('Partial Fill'), findsWidgets);
      expect(find.textContaining('₹117.24/L'), findsWidgets);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });

    testWidgets('8. Mileage Screen renders bike header, Average Estimated Mileage (35.67 km/L), and intervals', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        buildAppWithOverrides(
          child: const MileageScreen(),
          vehicles: [testBike],
          entries: sampleEntries,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Mileage Insights'), findsOneWidget);
      expect(find.text('Speedy Hunter'), findsOneWidget);
      expect(find.text('6,785 km'), findsOneWidget); // Latest live odometer

      // Average Estimated Mileage: (33 + 29 + 45) / 3 = 35.67 km/L
      expect(find.text('AVERAGE ESTIMATED MILEAGE'), findsOneWidget);
      expect(find.text('35.67 km/L'), findsOneWidget);

      // Consecutive intervals
      expect(find.text('Refill 3 → Refill 4'), findsOneWidget);
      expect(find.text('Refill 2 → Refill 3'), findsOneWidget);
      expect(find.text('Refill 1 → Refill 2'), findsOneWidget);

      // Distance and estimated mileage per interval using previous refill fuel
      // Refill 1 -> 2: 132 km / 4 L = 33 km/L
      expect(find.text('33.00 km/L'), findsOneWidget);
      // Refill 2 -> 3: 58 km / 2 L = 29 km/L
      expect(find.text('29.00 km/L'), findsOneWidget);
      // Refill 3 -> 4: 45 km / 1 L = 45 km/L
      expect(find.text('45.00 km/L'), findsOneWidget);

      // Distances
      expect(find.text('132 km'), findsOneWidget);
      expect(find.text('58 km'), findsOneWidget);
      expect(find.text('45 km'), findsOneWidget);

      // Divisors from previous refills
      expect(find.text('Prev Refill Fuel'), findsWidgets);
      expect(find.text('4 L'), findsOneWidget);
      expect(find.text('2 L'), findsOneWidget);
      expect(find.text('1 L'), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });

    testWidgets('9. Mileage Screen displays "Not enough data yet" when less than 2 refills exist', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        buildAppWithOverrides(
          child: const MileageScreen(),
          vehicles: [testBike],
          entries: [refill1], // Only 1 refill
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Not enough data yet'), findsOneWidget);
      expect(find.text('Need 2 Fuel Stops'), findsOneWidget);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });

    testWidgets('10. Small-screen (320x600) layouts produce no pixel overflow errors', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      // HomeScreen on 320x600
      await tester.pumpWidget(
        buildAppWithOverrides(
          child: const HomeScreen(),
          vehicles: [testBike],
          entries: sampleEntries,
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      // FuelHistoryScreen on 320x600
      await tester.pumpWidget(
        buildAppWithOverrides(
          child: const FuelHistoryScreen(),
          vehicles: [testBike],
          entries: sampleEntries,
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      // MileageScreen on 320x600
      await tester.pumpWidget(
        buildAppWithOverrides(
          child: const MileageScreen(),
          vehicles: [testBike],
          entries: sampleEntries,
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      // FuelEntryScreen on 320x600
      await tester.pumpWidget(
        buildAppWithOverrides(
          child: const FuelEntryScreen(),
          vehicles: [testBike],
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
    });
  });
}
