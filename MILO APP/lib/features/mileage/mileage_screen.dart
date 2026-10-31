import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme/app_colors.dart';
import '../../core/formatters/metric_formatters.dart';
import '../../core/widgets/empty_state_view.dart';
import '../../data/services/providers.dart';
import '../../domain/calculations/mileage_engine.dart';

class MileageScreen extends ConsumerWidget {
  const MileageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final bikeAsync = ref.watch(primaryBikeProvider);
    final currentOdo = ref.watch(currentOdometerProvider);
    final intervals = ref.watch(refillIntervalsProvider);
    final averageMileage = ref.watch(averageEstimatedMileageProvider);
    final actualMileage = ref.watch(averageActualMileageProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mileage Insights',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: bikeAsync.when(
        data: (bike) {
          if (bike == null) {
            return const Center(child: Text('Please set up your bike first.'));
          }

          final validIntervals = intervals
              .where((i) =>
                  i.distanceKm > 0 &&
                  i.fuelQuantityLitres > 0 &&
                  i.estimatedMileageKmPerLitre != null)
              .length;

          return RefreshIndicator(
            color: AppColors.primaryTeal,
            onRefresh: () async {
              ref.invalidate(primaryBikeFuelEntriesProvider);
            },
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                // 1. Top Header Card: Bike Name & Current Odometer
                _MileageHeaderCard(
                  bikeName: bike.nickname,
                  bikeModel: [bike.make, bike.model]
                      .where((s) => s.trim().isNotEmpty)
                      .join(' • '),
                  currentOdometerKm: currentOdo,
                ),
                const SizedBox(height: 14),

                // 2. Verified Actual Mileage Card (Full-to-Full)
                _ActualMileageCard(
                  actualMileageKmPerLitre: actualMileage,
                ),
                const SizedBox(height: 12),

                // 3. Prominent Average Estimated Mileage Card (Partial Fills)
                _AverageMileageCard(
                  averageMileageKmPerLitre: averageMileage,
                  validIntervalsCount: validIntervals,
                ),
                const SizedBox(height: 16),

                // 3. Consecutive Intervals Section Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'CONSECUTIVE REFILL INTERVALS',
                        style: theme.textTheme.labelMedium?.copyWith(
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryTeal,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${intervals.length} interval${intervals.length == 1 ? "" : "s"}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // 4. Consecutive Refill Cards List or Empty State
                if (intervals.isEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: EmptyStateView(
                      icon: Icons.speed_rounded,
                      title: 'Need 2 Fuel Stops',
                      message:
                          'Mileage insights are calculated between consecutive refills. Add at least two fuel refills with odometer readings to see your interval mileage.',
                      buttonLabel: 'Add Fuel Refill',
                      onButtonPressed: () => context.push('/fuel/add'),
                    ),
                  ),
                ] else ...[
                  ...intervals.map(
                    (interval) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _RefillIntervalCard(interval: interval),
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
}

// -------------------------------------------------------------
// UI Subcomponents for Mileage Page
// -------------------------------------------------------------

/// Top card displaying Bike Nickname, Model, and Live Current Odometer
class _MileageHeaderCard extends StatelessWidget {
  final String bikeName;
  final String bikeModel;
  final double currentOdometerKm;

  const _MileageHeaderCard({
    required this.bikeName,
    required this.bikeModel,
    required this.currentOdometerKm,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

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
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryTeal.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.two_wheeler_rounded,
                  color: AppColors.primaryTeal,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bikeName,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (bikeModel.isNotEmpty) ...[
                      Text(
                        bikeModel,
                        style: theme.textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(),
          const SizedBox(height: 12),
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
                    const SizedBox(height: 2),
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
                child: const Text(
                  'Auto-Updated',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryTeal,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Card displaying verified Actual Mileage calculated using the standard full-to-full method
class _ActualMileageCard extends StatelessWidget {
  final double? actualMileageKmPerLitre;

  const _ActualMileageCard({
    required this.actualMileageKmPerLitre,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final hasActual = actualMileageKmPerLitre != null;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: hasActual
              ? AppColors.primaryTeal.withValues(alpha: 0.4)
              : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
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
                  'ACTUAL MILEAGE (FULL-TO-FULL)',
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryTeal.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Verified Actual',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.primaryTeal,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              hasActual
                  ? '${actualMileageKmPerLitre!.toStringAsFixed(2)} km/L'
                  : 'Requires 2 full tanks',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: hasActual
                    ? (isDark ? Colors.white : AppColors.textPrimaryLight)
                    : (isDark ? AppColors.textMutedDark : AppColors.textMutedLight),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            hasActual
                ? 'Calculated with verified full-to-full method: Distance between full tanks ÷ all fuel consumed'
                : 'Record a second full-tank refuel to calculate your verified actual mileage',
            style: theme.textTheme.bodySmall?.copyWith(
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}

/// Prominent card showing Average Estimated Mileage across all valid consecutive refill intervals
class _AverageMileageCard extends StatelessWidget {
  final double? averageMileageKmPerLitre;
  final int validIntervalsCount;

  const _AverageMileageCard({
    required this.averageMileageKmPerLitre,
    required this.validIntervalsCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final hasAverage = averageMileageKmPerLitre != null;

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
                  'AVERAGE ESTIMATED MILEAGE',
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryTeal.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Estimate',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.primaryTeal,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              hasAverage
                  ? '${averageMileageKmPerLitre!.toStringAsFixed(2)} km/L'
                  : 'Not enough data yet',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: hasAverage
                    ? (isDark ? Colors.white : AppColors.textPrimaryLight)
                    : (isDark ? AppColors.textMutedDark : AppColors.textMutedLight),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            hasAverage
                ? 'Arithmetic average across $validIntervalsCount valid consecutive interval${validIntervalsCount == 1 ? "" : "s"}'
                : 'Requires at least 2 consecutive refills with odometer readings',
            style: theme.textTheme.bodySmall?.copyWith(
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}

/// Card representing a single interval between two consecutive refills
class _RefillIntervalCard extends StatelessWidget {
  final RefillInterval interval;

  const _RefillIntervalCard({required this.interval});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final isActual = interval.isActualMileage;
    final isBaseline = interval.isBaseline;

    final prevFuelLitres = interval.previousRefillFuelLitres;
    final prevFuelLitresStr = prevFuelLitres.truncateToDouble() == prevFuelLitres
        ? '${prevFuelLitres.toInt()} L'
        : '${prevFuelLitres.toStringAsFixed(2)} L';

    final hasMileage = interval.isMileageAvailable;
    final displayMileage = interval.displayMileage;
    final mileageStr = hasMileage
        ? '${displayMileage!.toStringAsFixed(2)} km/L'
        : (isBaseline ? 'Baseline' : 'Mileage unavailable');

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
          // 1. Header: Refill Pair Label & Fill Type / Calculation Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.compare_arrows_rounded,
                      size: 16,
                      color: AppColors.primaryTeal,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        interval.refillPairLabel,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isActual
                      ? AppColors.primaryTeal.withValues(alpha: 0.15)
                      : (isBaseline
                          ? Colors.blue.withValues(alpha: 0.15)
                          : AppColors.warningOrange.withValues(alpha: 0.15)),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  isActual
                      ? 'Full Tank'
                      : (isBaseline ? 'Baseline' : 'Partial Fill'),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isActual
                        ? AppColors.primaryTeal
                        : (isBaseline ? Colors.blue.shade700 : AppColors.warningOrange),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Date Range Subtitle
          Row(
            children: [
              const Icon(
                Icons.calendar_today_rounded,
                size: 13,
                color: AppColors.primaryTeal,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '${MetricFormatters.formatDate(interval.startDate)} → ${MetricFormatters.formatDate(interval.endDate)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 2. Odometer Readings
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkSurfaceSecondary
                  : AppColors.lightSurfaceSecondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.speed_rounded,
                        size: 14,
                        color: AppColors.primaryTeal,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Odometer:',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${interval.startOdometerKm.toStringAsFixed(0)} → ${interval.endOdometerKm.toStringAsFixed(0)} km',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryTeal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // 3. Stats Row: Distance Travelled, Fuel Divisor, and Mileage
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Distance Travelled
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isActual ? 'Cycle Distance' : 'Distance',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                    ),
                    const SizedBox(height: 2),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        isActual
                            ? '${interval.cycleDistanceKm.toStringAsFixed(0)} km'
                            : '${interval.distanceKm.toStringAsFixed(0)} km',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: isDark ? Colors.white : AppColors.textPrimaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Fuel (Divisor)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      isActual
                          ? 'Fuel Consumed'
                          : (isBaseline ? 'Starting Fuel' : 'Prev Refill Fuel'),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.center,
                      child: Text(
                        isActual
                            ? '${interval.cycleFuelConsumedLitres.toStringAsFixed(2)} L'
                            : (isBaseline
                                ? '${interval.currentRefillFuelLitres.toStringAsFixed(2)} L'
                                : prevFuelLitresStr),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Mileage (Actual or Estimated)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      isActual
                          ? 'Actual Mileage'
                          : (isBaseline ? 'Baseline' : 'Estimated Mileage'),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        mileageStr,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: hasMileage ? AppColors.primaryTeal : AppColors.textMutedDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // 4. Transparency Footnote
          Text(
            isActual
                ? '* Actual: ${interval.cycleDistanceKm.toStringAsFixed(0)} km full-to-full distance ÷ ${interval.cycleFuelConsumedLitres.toStringAsFixed(2)} L consumed.'
                : (isBaseline
                    ? '* First full tank: establishes baseline for future actual mileage calculations.'
                    : (hasMileage
                        ? '* Estimated: ${interval.distanceKm.toStringAsFixed(0)} km travelled ÷ $prevFuelLitresStr (previous refill fuel).'
                        : '* Insufficient distance or fuel data from previous refill.')),
            style: theme.textTheme.bodySmall?.copyWith(
              fontStyle: FontStyle.italic,
              fontSize: 11,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    );
  }
}
