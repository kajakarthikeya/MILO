import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../app/theme/app_colors.dart';
import '../../core/formatters/metric_formatters.dart';
import '../../core/widgets/empty_state_view.dart';
import '../../core/widgets/confirmation_dialog.dart';
import '../../data/database/app_database.dart';
import '../../data/services/providers.dart';

class FuelHistoryScreen extends ConsumerWidget {
  const FuelHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final bikeAsync = ref.watch(primaryBikeProvider);
    final entriesAsync = ref.watch(primaryBikeFuelEntriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fuel Refills',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            tooltip: 'Add Fuel Refill',
            icon: const Icon(Icons.add_rounded, size: 26),
            color: AppColors.primaryTeal,
            onPressed: () => context.push('/fuel/add'),
          ),
        ],
      ),
      body: bikeAsync.when(
        data: (bike) {
          if (bike == null) {
            return const Center(child: Text('Please set up your bike first.'));
          }

          return entriesAsync.when(
            data: (rawEntries) {
              if (rawEntries.isEmpty) {
                return EmptyStateView(
                  icon: Icons.local_gas_station_rounded,
                  title: 'No Refuelling Records',
                  message: 'You have not recorded any fuel refills yet.',
                  buttonLabel: 'Record First Refill',
                  onButtonPressed: () => context.push('/fuel/add'),
                );
              }

              // Compute distance since previous refill chronologically
              // 1. Sort ascending (oldest first)
              final chronological = List<FuelEntryData>.from(rawEntries)
                ..sort((a, b) {
                  final timeCompare = a.timestamp.compareTo(b.timestamp);
                  if (timeCompare != 0) return timeCompare;
                  return a.odometerKm.compareTo(b.odometerKm);
                });

              // Map each entry to its distance since previous refill
              final Map<String, double?> distanceMap = {};
              for (int i = 0; i < chronological.length; i++) {
                final curr = chronological[i];
                if (i == 0) {
                  final d = curr.odometerKm - bike.initialOdometerKm;
                  distanceMap[curr.id] = d > 0 ? d : null;
                } else {
                  final prev = chronological[i - 1];
                  final d = curr.odometerKm - prev.odometerKm;
                  distanceMap[curr.id] = d >= 0 ? d : null;
                }
              }

              // Display newest first (descending)
              final entries = chronological.reversed.toList();

              // Group entries by Month and Year (e.g. "October 2026")
              final Map<String, List<FuelEntryData>> grouped = {};
              for (final entry in entries) {
                final groupKey = DateFormat('MMMM yyyy').format(entry.timestamp);
                grouped.putIfAbsent(groupKey, () => []).add(entry);
              }

              return RefreshIndicator(
                color: AppColors.primaryTeal,
                onRefresh: () async {
                  ref.invalidate(primaryBikeFuelEntriesProvider);
                },
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: grouped.keys.length,
                  itemBuilder: (context, groupIndex) {
                    final monthYear = grouped.keys.elementAt(groupIndex);
                    final monthEntries = grouped[monthYear]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Month Header
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 8, left: 4),
                          child: Text(
                            monthYear.toUpperCase(),
                            style: theme.textTheme.labelMedium?.copyWith(
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryTeal,
                            ),
                          ),
                        ),
                        // List of cards for this month
                        ...monthEntries.map((entry) {
                          final distance = distanceMap[entry.id];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _FuelEntryCard(
                              entry: entry,
                              distanceSincePreviousKm: distance,
                              onEdit: () => context.push('/fuel/edit', extra: entry),
                              onDelete: () => _confirmDelete(context, ref, entry),
                            ),
                          );
                        }),
                      ],
                    );
                  },
                ),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.primaryTeal),
            ),
            error: (err, stack) => Center(child: Text('Error: $err')),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primaryTeal),
        ),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    FuelEntryData entry,
  ) async {
    final confirmed = await ConfirmationDialog.show(
      context: context,
      title: 'Delete Fuel Record',
      message:
          'Are you sure you want to delete the fuel entry from ${MetricFormatters.formatDate(entry.timestamp)}? This will recalculate your mileage and expenditure.',
      confirmLabel: 'Delete',
      isDestructive: true,
    );

    if (confirmed == true) {
      await ref.read(fuelRepositoryProvider).deleteFuelEntry(
            id: entry.id,
            vehicleId: entry.vehicleId,
          );
      ref.invalidate(primaryBikeFuelEntriesProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.primaryTeal,
            content: Text('Fuel record deleted. Mileage updated.'),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}

class _FuelEntryCard extends StatelessWidget {
  final FuelEntryData entry;
  final double? distanceSincePreviousKm;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _FuelEntryCard({
    required this.entry,
    required this.distanceSincePreviousKm,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isFull = entry.fillType == 'full';

    // Format fuel quantity without trailing zeros if integer, e.g. "7 L" or "2.5 L"
    final fuelLitresStr = entry.fuelQuantity.truncateToDouble() == entry.fuelQuantity
        ? '${entry.fuelQuantity.toInt()} L'
        : '${entry.fuelQuantity.toStringAsFixed(2)} L';

    final unitPriceStr = '₹${(entry.unitPriceMinorUnitsPerLitre / 100.0).toStringAsFixed(2)}/L';

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
          // Top Row: Date & Fill Type Badge & Menu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      size: 13,
                      color: AppColors.primaryTeal,
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        MetricFormatters.formatDate(entry.timestamp),
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Fill Type Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: isFull
                          ? AppColors.primaryTeal.withValues(alpha: 0.15)
                          : AppColors.warningOrange.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      isFull ? 'Full Tank' : 'Partial Fill',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isFull ? AppColors.primaryTeal : AppColors.warningOrange,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert_rounded, size: 18),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onSelected: (val) {
                      if (val == 'edit') onEdit();
                      if (val == 'delete') onDelete();
                    },
                    itemBuilder: (ctx) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit_outlined, size: 16),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline, color: AppColors.errorRed, size: 16),
                            SizedBox(width: 8),
                            Text('Delete', style: TextStyle(color: AppColors.errorRed)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Main Stats Row: Amount Paid (Left) & Odometer + Distance (Right)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Amount Paid
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amount',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                      ),
                    ),
                    const SizedBox(height: 2),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        MetricFormatters.formatCurrency(entry.amountPaidMinorUnits),
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: isDark ? Colors.white : AppColors.textPrimaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Odometer Reading & Distance Since Previous Refill
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.speed_rounded,
                        size: 15,
                        color: AppColors.primaryTeal,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        MetricFormatters.formatDistance(entry.odometerKm, integerOnly: true),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  if (distanceSincePreviousKm != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      '+${distanceSincePreviousKm!.toStringAsFixed(0)} km',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryTeal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 8),

          // Bottom Details: Fuel Litres and Rate
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Fuel: $fuelLitresStr → $unitPriceStr',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (entry.stationName != null && entry.stationName!.trim().isNotEmpty) ...[
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    entry.stationName!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
