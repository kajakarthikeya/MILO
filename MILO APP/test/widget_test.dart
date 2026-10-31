import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milo/app/app.dart';
import 'package:milo/data/database/app_database.dart';
import 'package:milo/data/services/providers.dart';

void main() {
  testWidgets('MiloApp smoke test - launches and renders cleanly', (
    WidgetTester tester,
  ) async {
    final testDb = AppDatabase.forTesting(NativeDatabase.memory());

    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() async {
      tester.view.resetPhysicalSize();
      await testDb.close();
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(testDb),
          userProfileStreamProvider.overrideWith((ref) => Stream.value(null)),
          vehiclesStreamProvider.overrideWith((ref) => Stream.value([])),
          primaryBikeProvider.overrideWith((ref) => Stream.value(null)),
        ],
        child: const MiloApp(isOnboardingCompleted: true),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(MiloApp), findsOneWidget);
    expect(find.text('Welcome to MILO'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
  });
}
