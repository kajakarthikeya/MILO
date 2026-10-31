import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router.dart';
import 'theme/app_theme.dart';
import '../data/services/providers.dart';

class MiloApp extends ConsumerStatefulWidget {
  final bool isOnboardingCompleted;

  const MiloApp({super.key, required this.isOnboardingCompleted});

  @override
  ConsumerState<MiloApp> createState() => _MiloAppState();
}

class _MiloAppState extends ConsumerState<MiloApp> {
  late final _router = createAppRouter(
    isOnboardingCompleted: widget.isOnboardingCompleted,
  );

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: 'Milo Fuel Tracker',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: _router,
    );
  }
}
