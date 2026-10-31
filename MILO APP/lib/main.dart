import 'dart:async';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/storage/storage_config.dart';
import 'data/database/app_database.dart';
import 'data/services/providers.dart';

void main() {
  // 1. Ensure Flutter bindings are ready
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Single shared ProviderContainer to avoid duplicate database allocations
  final container = ProviderContainer();

  // 3. Immediately launch the application UI — zero cold-start delay
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MiloApp(isOnboardingCompleted: true),
    ),
  );

  // 4. Asynchronously initialize background services without blocking UI draw
  _initServicesInBackground(container);
}

void _initServicesInBackground(ProviderContainer container) {
  // Run concurrently in background after UI rendering begins
  scheduleMicrotask(() async {
    // A. Storage directory verification
    try {
      final baseDir = await StorageConfig.getBaseDirectory();
      debugPrint('Milo Storage Directory verified at: ${baseDir.path}');
    } catch (e) {
      debugPrint('Storage initialization warning: $e');
    }

    // B. Default bike and profile seeding (using the unified single database instance)
    try {
      final db = container.read(databaseProvider);
      final profile = await db.userProfileDao.getProfile();
      if (profile == null) {
        final now = DateTime.now();
        await db.userProfileDao.upsertProfile(
          UserProfilesCompanion.insert(
            id: 'primary_user',
            displayName: const drift.Value('Rider'),
            currencyCode: const drift.Value('INR'),
            distanceUnit: const drift.Value('km'),
            onboardingCompleted: const drift.Value(true),
            createdAt: now,
            updatedAt: now,
          ),
        );
      }

      final vehicles = await db.vehicleDao.getAllVehicles();
      if (vehicles.isEmpty) {
        final now = DateTime.now();
        await db.vehicleDao.insertVehicle(
          VehiclesCompanion.insert(
            id: 'primary_bike',
            nickname: 'Speedy Hunter',
            make: 'Royal Enfield',
            model: 'Hunter 350',
            vehicleType: 'motorcycle',
            fuelType: 'petrol',
            initialOdometerKm: 0.0,
            createdAt: now,
            updatedAt: now,
          ),
        );
      } else {
        // If a previously seeded bike has initialOdometerKm == 1000.0 without user intention,
        // relax it to 0.0 so new bikes (e.g. 10 km) are never blocked by a hardcoded 1000 km.
        final bike = vehicles.first;
        if (bike.initialOdometerKm == 1000.0) {
          final entries = await db.fuelEntryDao.getEntriesForVehicle(bike.id);
          if (entries.isEmpty || entries.any((e) => e.odometerKm < 1000.0)) {
            await db.vehicleDao.updateVehicle(
              VehiclesCompanion(
                id: drift.Value(bike.id),
                initialOdometerKm: const drift.Value(0.0),
                updatedAt: drift.Value(DateTime.now()),
              ),
            );
          }
        }
      }
    } catch (e) {
      debugPrint('Database auto-initialization check: $e');
    }
  });
}
