import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_scaffold.dart';
import '../data/database/app_database.dart';
import '../features/home/home_screen.dart';
import '../features/fuel/fuel_history_screen.dart';
import '../features/fuel/fuel_entry_screen.dart';
import '../features/mileage/mileage_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createAppRouter({bool isOnboardingCompleted = true}) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: [

      // 3 Main Essential Pages Shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppScaffold(navigationShell: navigationShell);
        },
        branches: [
          // Branch 0: Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
              GoRoute(
                path: '/dashboard',
                redirect: (context, state) => '/home',
              ),
            ],
          ),

          // Branch 1: Fuel (Refill History)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/fuel',
                builder: (context, state) => const FuelHistoryScreen(),
              ),
              GoRoute(
                path: '/fuel/history',
                redirect: (context, state) => '/fuel',
              ),
            ],
          ),

          // Branch 2: Mileage (Insights between consecutive refills)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/mileage',
                builder: (context, state) => const MileageScreen(),
              ),
            ],
          ),
        ],
      ),

      // Fuel Entry Action Subroutes
      GoRoute(
        path: '/fuel/add',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const FuelEntryScreen(),
      ),
      GoRoute(
        path: '/fuel/edit',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final entry = state.extra as FuelEntryData?;
          return FuelEntryScreen(entryToEdit: entry);
        },
      ),
    ],
  );
}
