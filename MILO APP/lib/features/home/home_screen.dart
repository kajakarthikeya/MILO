import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme/app_colors.dart';
import '../../core/formatters/metric_formatters.dart';
import '../../data/database/app_database.dart';
import '../../data/services/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final profileAsync = ref.watch(userProfileStreamProvider);
    final bikeAsync = ref.watch(primaryBikeProvider);
    final entriesAsync = ref.watch(primaryBikeFuelEntriesProvider);
    final currentOdo = ref.watch(currentOdometerProvider);
    final totalSpentPaise = ref.watch(totalFuelExpenditurePaiseProvider);
    final actualMileage = ref.watch(averageActualMileageProvider);
    final estimatedMileage = ref.watch(averageEstimatedMileageProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 26,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'MILO',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
                color: isDark ? AppColors.textPrimaryDark : AppColors.primaryTeal,
              ),
            ),
          ],
        ),
      ),
      body: bikeAsync.when(
        data: (bike) {
          if (bike == null) {
            return _SetupBikeView(onBikeCreated: (name, make, model, initialOdo) async {
              await ref.read(vehicleRepositoryProvider).createVehicle(
                    nickname: name,
                    make: make,
                    model: model,
                    vehicleType: 'motorcycle',
                    fuelType: 'petrol',
                    initialOdometerKm: initialOdo,
                  );
            });
          }

          final entries = entriesAsync.asData?.value ?? [];
          final profile = profileAsync.asData?.value;
          final userName = (profile?.displayName != null &&
                  profile!.displayName!.trim().isNotEmpty)
              ? profile.displayName!
              : 'Rider';

          return RefreshIndicator(
            color: AppColors.primaryTeal,
            onRefresh: () async {
              ref.invalidate(primaryBikeFuelEntriesProvider);
              ref.invalidate(primaryBikeProvider);
            },
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              children: [
                // 1. User Details Card (Editable)
                _UserHeaderCard(
                  userName: userName,
                  currencyCode: profile?.currencyCode ?? 'INR',
                  onEditName: () => _showEditUserDialog(context, ref, profile),
                ),
                const SizedBox(height: 14),

                // 2. Bike Details Card (Editable & Shows Current Odometer)
                _BikeDetailsCard(
                  bike: bike,
                  currentOdometerKm: currentOdo,
                  onEditBike: () => _showEditBikeDialog(context, ref, bike),
                ),
                const SizedBox(height: 14),

                // 3. Total Fuel Expenditure Card
                _TotalSpentCard(
                  totalSpentPaise: totalSpentPaise,
                  refuelCount: entries.length,
                  currencyCode: profile?.currencyCode ?? 'INR',
                ),
                const SizedBox(height: 14),

                // 4. Mileage Dashboard Card (Separate Actual & Estimated Values)
                _DashboardMileageCard(
                  actualMileage: actualMileage,
                  estimatedMileage: estimatedMileage,
                  onTap: () => context.go('/mileage'),
                ),
                const SizedBox(height: 20),

                // 5. Primary Add Fuel Action Button
                ElevatedButton.icon(
                  icon: const Icon(Icons.add_circle_outline_rounded, size: 22),
                  label: const Text(
                    'Add Fuel',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryTeal,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => context.push('/fuel/add'),
                ),
                const SizedBox(height: 20),

                // Quick Hint / Summary Bar
                if (entries.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.darkSurface
                          : AppColors.lightSurface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isDark
                            ? AppColors.darkBorder
                            : AppColors.lightBorder,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(
                                Icons.history_rounded,
                                size: 18,
                                color: AppColors.primaryTeal,
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  'Latest: ${MetricFormatters.formatDate(entries.first.timestamp)}',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 6),
                        TextButton(
                          onPressed: () => context.go('/fuel'),
                          child: const Text('View All'),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 20),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primaryTeal),
        ),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  void _showEditUserDialog(
    BuildContext context,
    WidgetRef ref,
    UserProfileData? profile,
  ) {
    final controller = TextEditingController(text: profile?.displayName ?? '');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit User Name'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Your Name',
            hintText: 'e.g. Alex Rider',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryTeal,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                await ref.read(profileRepositoryProvider).saveProfile(
                      displayName: newName,
                      currencyCode: profile?.currencyCode ?? 'INR',
                      distanceUnit: profile?.distanceUnit ?? 'km',
                    );
              }
              if (ctx.mounted) Navigator.of(ctx).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showEditBikeDialog(
    BuildContext context,
    WidgetRef ref,
    VehicleData bike,
  ) {
    final nameController = TextEditingController(text: bike.nickname);
    final makeController = TextEditingController(text: bike.make);
    final modelController = TextEditingController(text: bike.model);
    final odoController = TextEditingController(
      text: bike.initialOdometerKm.toStringAsFixed(0),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Bike Details',
                style: Theme.of(ctx).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Bike Name / Nickname *',
                  hintText: 'e.g. Speedy Hunter',
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: makeController,
                      decoration: const InputDecoration(
                        labelText: 'Brand',
                        hintText: 'e.g. Royal Enfield',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: modelController,
                      decoration: const InputDecoration(
                        labelText: 'Model',
                        hintText: 'e.g. Hunter 350',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: odoController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Initial Odometer (km)',
                  suffixText: 'km',
                  hintText: 'e.g. 0, 10, or 6550',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryTeal,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  final name = nameController.text.trim();
                  if (name.isEmpty) return;

                  final initialOdo =
                      double.tryParse(odoController.text.trim()) ??
                          bike.initialOdometerKm;

                  await ref.read(vehicleRepositoryProvider).updateVehicle(
                        id: bike.id,
                        nickname: name,
                        make: makeController.text.trim(),
                        model: modelController.text.trim(),
                        vehicleType: bike.vehicleType,
                        fuelType: bike.fuelType,
                        initialOdometerKm: initialOdo,
                        isArchived: bike.isArchived,
                      );
                  if (ctx.mounted) Navigator.of(ctx).pop();
                },
                child: const Text(
                  'Save Bike Details',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -------------------------------------------------------------
// UI Subcomponents for Home Page
// -------------------------------------------------------------

class _UserHeaderCard extends StatelessWidget {
  final String userName;
  final String currencyCode;
  final VoidCallback onEditName;

  const _UserHeaderCard({
    required this.userName,
    required this.currencyCode,
    required this.onEditName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primaryTeal.withValues(alpha: 0.18),
            child: Text(
              userName.isNotEmpty ? userName[0].toUpperCase() : 'R',
              style: const TextStyle(
                color: AppColors.primaryTeal,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HELLO,',
                  style: theme.textTheme.labelSmall?.copyWith(
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  userName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Edit Name',
            icon: const Icon(Icons.edit_outlined, size: 18),
            color: AppColors.primaryTeal,
            onPressed: onEditName,
          ),
        ],
      ),
    );
  }
}

class _BikeDetailsCard extends StatelessWidget {
  final VehicleData bike;
  final double currentOdometerKm;
  final VoidCallback onEditBike;

  const _BikeDetailsCard({
    required this.bike,
    required this.currentOdometerKm,
    required this.onEditBike,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final subtitle = [bike.make, bike.model]
        .where((s) => s.trim().isNotEmpty)
        .join(' • ');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryTeal.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.two_wheeler_rounded,
                  color: AppColors.primaryTeal,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bike.nickname,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Edit Bike',
                icon: const Icon(Icons.edit_outlined, size: 18),
                color: AppColors.primaryTeal,
                onPressed: onEditBike,
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(),
          const SizedBox(height: 12),

          // Current Odometer Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CURRENT ODOMETER',
                      style: theme.textTheme.labelSmall?.copyWith(
                        letterSpacing: 1.1,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        MetricFormatters.formatDistance(
                          currentOdometerKm,
                          integerOnly: true,
                        ),
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryTeal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.primaryTeal.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.speed_rounded,
                      size: 14,
                      color: AppColors.primaryTeal,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Live Reading',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: AppColors.primaryTeal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TotalSpentCard extends StatelessWidget {
  final int totalSpentPaise;
  final int refuelCount;
  final String currencyCode;

  const _TotalSpentCard({
    required this.totalSpentPaise,
    required this.refuelCount,
    required this.currencyCode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'TOTAL FUEL EXPENDITURE',
                  style: theme.textTheme.labelSmall?.copyWith(
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryTeal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.account_balance_wallet_rounded,
                size: 20,
                color: AppColors.primaryTeal,
              ),
            ],
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              MetricFormatters.formatCurrency(
                totalSpentPaise,
                currencyCode: currencyCode,
                showDecimals: true,
              ),
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : AppColors.textPrimaryLight,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            refuelCount > 0
                ? 'Calculated from $refuelCount refuel stop${refuelCount > 1 ? "s" : ""}'
                : 'No refuels logged yet',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _SetupBikeView extends StatefulWidget {
  final void Function(String name, String make, String model, double initialOdo) onBikeCreated;

  const _SetupBikeView({required this.onBikeCreated});

  @override
  State<_SetupBikeView> createState() => _SetupBikeViewState();
}

class _SetupBikeViewState extends State<_SetupBikeView> {
  final _nameController = TextEditingController(text: 'My Bike');
  final _makeController = TextEditingController(text: 'Royal Enfield');
  final _modelController = TextEditingController(text: 'Hunter 350');
  final _odoController = TextEditingController(text: '0');

  @override
  void dispose() {
    _nameController.dispose();
    _makeController.dispose();
    _modelController.dispose();
    _odoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 52,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Welcome to MILO',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Enter your bike details to get started with simple fuel and mileage tracking.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Bike Name *',
                  hintText: 'e.g. My Hunter',
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _makeController,
                      decoration: const InputDecoration(
                        labelText: 'Brand',
                        hintText: 'Royal Enfield',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _modelController,
                      decoration: const InputDecoration(
                        labelText: 'Model',
                        hintText: 'Hunter 350',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _odoController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Initial Odometer (km) *',
                  hintText: 'e.g. 0, 10, or 6550',
                  suffixText: 'km',
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryTeal,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  final name = _nameController.text.trim();
                  if (name.isEmpty) return;
                  final odo = double.tryParse(_odoController.text.trim()) ?? 0.0;
                  widget.onBikeCreated(
                    name,
                    _makeController.text.trim(),
                    _modelController.text.trim(),
                    odo,
                  );
                },
                child: const Text(
                  'Save Bike & Continue',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Dashboard card displaying separate Actual (Full-to-Full) and Estimated (Partial Fills) mileage
class _DashboardMileageCard extends StatelessWidget {
  final double? actualMileage;
  final double? estimatedMileage;
  final VoidCallback onTap;

  const _DashboardMileageCard({
    required this.actualMileage,
    required this.estimatedMileage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.speed_rounded,
                        size: 18,
                        color: AppColors.primaryTeal,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'MILEAGE DASHBOARD',
                          style: theme.textTheme.labelSmall?.copyWith(
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryTeal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: AppColors.primaryTeal,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // 1. Actual Mileage (Full-to-Full)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.darkSurfaceSecondary
                          : AppColors.lightSurfaceSecondary,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: actualMileage != null
                            ? AppColors.primaryTeal.withValues(alpha: 0.3)
                            : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primaryTeal.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Actual',
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryTeal,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            actualMileage != null
                                ? '${actualMileage!.toStringAsFixed(2)} km/L'
                                : '--',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: actualMileage != null
                                  ? (isDark ? Colors.white : AppColors.textPrimaryLight)
                                  : (isDark ? AppColors.textMutedDark : AppColors.textMutedLight),
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          actualMileage != null
                              ? 'Full-to-Full verified'
                              : 'Need 2 full tanks',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 11,
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // 2. Estimated Mileage (Partial Fills)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.darkSurfaceSecondary
                          : AppColors.lightSurfaceSecondary,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: estimatedMileage != null
                            ? AppColors.warningOrange.withValues(alpha: 0.3)
                            : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.warningOrange.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'Estimated',
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.warningOrange,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            estimatedMileage != null
                                ? '${estimatedMileage!.toStringAsFixed(2)} km/L'
                                : '--',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: estimatedMileage != null
                                  ? (isDark ? Colors.white : AppColors.textPrimaryLight)
                                  : (isDark ? AppColors.textMutedDark : AppColors.textMutedLight),
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          estimatedMileage != null
                              ? 'From partial fills'
                              : 'Need 2 refills',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 11,
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
