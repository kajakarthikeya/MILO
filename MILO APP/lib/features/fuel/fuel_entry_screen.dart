import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/theme/app_colors.dart';
import '../../core/formatters/metric_formatters.dart';
import '../../core/widgets/empty_state_view.dart';
import '../../domain/calculations/fuel_calculator.dart';
import '../../data/database/app_database.dart';
import '../../data/services/providers.dart';

class FuelEntryScreen extends ConsumerStatefulWidget {
  final FuelEntryData? entryToEdit;

  const FuelEntryScreen({super.key, this.entryToEdit});

  @override
  ConsumerState<FuelEntryScreen> createState() => _FuelEntryScreenState();
}

class _FuelEntryScreenState extends ConsumerState<FuelEntryScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedVehicleId;
  DateTime _entryDateTime = DateTime.now();
  String _entryMethod = 'byMoney'; // 'byMoney' or 'byLitres'
  String _fillType = 'full'; // 'full' or 'partial'

  final _odometerController = TextEditingController();
  final _unitPriceController = TextEditingController(text: '117.24');
  final _amountPaidController = TextEditingController();
  final _litresController = TextEditingController();
  final _stationController = TextEditingController();
  final _notesController = TextEditingController();

  bool _isSaving = false;
  String? _calculationDisplay;

  bool get isEditing => widget.entryToEdit != null;

  @override
  void initState() {
    super.initState();
    final e = widget.entryToEdit;
    if (e != null) {
      _selectedVehicleId = e.vehicleId;
      _entryDateTime = e.timestamp;
      _entryMethod = e.entryMethod;
      _fillType = e.fillType;
      _odometerController.text = e.odometerKm.toStringAsFixed(0);
      _unitPriceController.text =
          (e.unitPriceMinorUnitsPerLitre / 100.0).toStringAsFixed(2);
      _amountPaidController.text =
          (e.amountPaidMinorUnits / 100.0).toStringAsFixed(2);
      _litresController.text = e.fuelQuantity.toStringAsFixed(3);
      _stationController.text = e.stationName ?? '';
      _notesController.text = e.notes ?? '';
    }
  }

  @override
  void dispose() {
    _odometerController.dispose();
    _unitPriceController.dispose();
    _amountPaidController.dispose();
    _litresController.dispose();
    _stationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onValuesChanged() {
    setState(() {
      final unitPricePaise = MetricFormatters.parseMajorToMinorUnits(
        _unitPriceController.text,
      );

      if (_entryMethod == 'byMoney') {
        final amountPaise = MetricFormatters.parseMajorToMinorUnits(
          _amountPaidController.text,
        );
        if (amountPaise > 0 && unitPricePaise > 0) {
          final litres = FuelCalculator.calculateQuantityFromMoney(
            amountPaidMinorUnits: amountPaise,
            unitPriceMinorUnitsPerLitre: unitPricePaise,
          );
          _litresController.text = litres.toStringAsFixed(3);
          _calculationDisplay =
              'Calculated: ${litres.toStringAsFixed(3)} Litres';
        } else {
          _calculationDisplay = null;
        }
      } else {
        // By Litres
        final litres = double.tryParse(_litresController.text.trim()) ?? 0.0;
        if (litres > 0 && unitPricePaise > 0) {
          final totalCostPaise = FuelCalculator.calculateCostFromQuantity(
            fuelQuantityLitres: litres,
            unitPriceMinorUnitsPerLitre: unitPricePaise,
          );
          _amountPaidController.text =
              (totalCostPaise / 100.0).toStringAsFixed(2);
          _calculationDisplay =
              'Calculated Total: ${MetricFormatters.formatCurrency(totalCostPaise)}';
        } else {
          _calculationDisplay = null;
        }
      }
    });
  }

  /// Resets the form state cleanly after a successful save while preserving selected vehicle
  void _resetFormForNextEntry() {
    setState(() {
      _odometerController.clear();
      _amountPaidController.clear();
      _litresController.clear();
      _stationController.clear();
      _notesController.clear();
      _unitPriceController.text = '117.24';
      _entryDateTime = DateTime.now();
      _entryMethod = 'byMoney';
      _fillType = 'full';
      _calculationDisplay = null;
      _formKey.currentState?.reset();
    });
  }

  Future<void> _selectDateTime() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _entryDateTime,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );

    if (pickedDate != null && mounted) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_entryDateTime),
      );

      if (pickedTime != null && mounted) {
        setState(() {
          _entryDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Future<void> _saveFuelEntry() async {
    // 1. Prevent duplicate submission
    if (_isSaving) return;

    // 2. Form field validation
    if (!_formKey.currentState!.validate()) return;

    final vehicleId = _selectedVehicleId;
    if (vehicleId == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a vehicle'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final odo = double.parse(_odometerController.text.trim());
    final unitPricePaise = MetricFormatters.parseMajorToMinorUnits(
      _unitPriceController.text,
    );
    final amountPaidPaise = MetricFormatters.parseMajorToMinorUnits(
      _amountPaidController.text,
    );
    final fuelQuantity = double.parse(_litresController.text.trim());

    if (amountPaidPaise <= 0 || fuelQuantity <= 0 || unitPricePaise <= 0) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Amount paid, fuel quantity, and fuel rate must all be strictly positive.',
          ),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // 3. Reject if new odometer reading is lower than previous reading for that vehicle
    if (!isEditing) {
      final fuelRepo = ref.read(fuelRepositoryProvider);
      final entries = await fuelRepo.getEntriesForVehicle(vehicleId);
      if (entries.isNotEmpty) {
        final latestOdo = entries.map((e) => e.odometerKm).reduce(math.max);
        if (odo < latestOdo) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Odometer reading (${odo.toStringAsFixed(0)} km) cannot be lower than the previous reading (${latestOdo.toStringAsFixed(0)} km).',
              ),
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red.shade700,
            ),
          );
          return;
        }
      } else {
        // First entry: ensure vehicle's initial odometer aligns if vehicle had older default
        final vehicleRepo = ref.read(vehicleRepositoryProvider);
        final vehicle = await vehicleRepo.getVehicleById(vehicleId);
        if (vehicle != null && vehicle.initialOdometerKm > odo) {
          await vehicleRepo.updateVehicle(
            id: vehicle.id,
            nickname: vehicle.nickname,
            make: vehicle.make,
            model: vehicle.model,
            vehicleType: vehicle.vehicleType,
            fuelType: vehicle.fuelType,
            initialOdometerKm: odo,
            isArchived: vehicle.isArchived,
          );
        }
      }
    }

    setState(() => _isSaving = true);

    try {
      final fuelRepo = ref.read(fuelRepositoryProvider);

      if (isEditing) {
        await fuelRepo.updateFuelEntry(
          id: widget.entryToEdit!.id,
          vehicleId: vehicleId,
          timestamp: _entryDateTime,
          odometerKm: odo,
          amountPaidMinorUnits: amountPaidPaise,
          fuelQuantity: fuelQuantity,
          unitPriceMinorUnitsPerLitre: unitPricePaise,
          entryMethod: _entryMethod,
          fillType: _fillType,
          stationName: _stationController.text.trim().isNotEmpty
              ? _stationController.text.trim()
              : null,
          notes: _notesController.text.trim().isNotEmpty
              ? _notesController.text.trim()
              : null,
        );
      } else {
        await fuelRepo.addFuelEntry(
          vehicleId: vehicleId,
          timestamp: _entryDateTime,
          odometerKm: odo,
          amountPaidMinorUnits: amountPaidPaise,
          fuelQuantity: fuelQuantity,
          unitPriceMinorUnitsPerLitre: unitPricePaise,
          entryMethod: _entryMethod,
          fillType: _fillType,
          stationName: _stationController.text.trim().isNotEmpty
              ? _stationController.text.trim()
              : null,
          notes: _notesController.text.trim().isNotEmpty
              ? _notesController.text.trim()
              : null,
        );
      }

      // Immediately invalidate providers to trigger fresh recalculation
      ref.invalidate(primaryBikeFuelEntriesProvider);
      ref.invalidate(vehicleFuelEntriesProvider(vehicleId));
      ref.invalidate(vehicleMileageIntervalsProvider(vehicleId));
      ref.invalidate(vehicleMileageSummaryProvider(vehicleId));
      ref.invalidate(vehicleMileageAnalyticsProvider(vehicleId));
      ref.invalidate(currentMonthSpendProvider(vehicleId));

      if (mounted) {
        if (isEditing) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColors.primaryTeal,
              content: Text('Fuel record updated! Mileage recalculated.'),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
          if (Navigator.of(context).canPop()) {
            context.pop();
          } else {
            context.go('/fuel/history');
          }
        } else {
          // Success confirmation for new entry: presents for exactly 2 seconds and dismisses cleanly
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColors.primaryTeal,
              content: Text('Fuel entry saved!'),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );

          // Reset the form cleanly for next entry
          _resetFormForNextEntry();

          // Navigate back if opened from Home or Fuel list
          if (Navigator.of(context).canPop()) {
            context.pop();
          } else {
            context.go('/fuel');
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.errorRed,
            content: Text('Error saving entry: $e'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final vehiclesAsync = ref.watch(vehiclesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Fuel Entry' : 'Quick Fuel Entry'),
        actions: [
          IconButton(
            tooltip: 'View Fuel History',
            icon: const Icon(Icons.history_rounded),
            onPressed: () => context.push('/fuel/history'),
          ),
        ],
      ),
      body: vehiclesAsync.when(
        data: (vehicles) {
          if (vehicles.isEmpty) {
            return EmptyStateView(
              icon: Icons.two_wheeler_rounded,
              title: 'No Vehicle Available',
              message: 'Please add a vehicle before recording fuel entries.',
              buttonLabel: 'Add Vehicle',
              onButtonPressed: () => context.push('/vehicles/add'),
            );
          }

          // Default vehicle selection
          if (_selectedVehicleId == null) {
            final active = ref.watch(activeVehicleProvider);
            _selectedVehicleId = active?.id ?? vehicles.first.id;
          }

          final selectedVehicle = vehicles.firstWhere(
            (v) => v.id == _selectedVehicleId,
            orElse: () => vehicles.first,
          );

          final vehicleEntriesAsync = ref.watch(primaryBikeFuelEntriesProvider);
          final vehicleEntries = vehicleEntriesAsync.asData?.value ?? [];
          final double? latestOdometer = vehicleEntries.isNotEmpty
              ? vehicleEntries.map((e) => e.odometerKm).reduce(math.max)
              : null;

          return SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 14.0,
                ),
                children: [
                  // Bike Banner (Single Bike Focus)
                  Container(
                    padding: const EdgeInsets.all(12),
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
                      children: [
                        const Icon(
                          Icons.two_wheeler_rounded,
                          color: AppColors.primaryTeal,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedVehicle.nickname,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${selectedVehicle.make} ${selectedVehicle.model}',
                                style: theme.textTheme.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Mode Switcher: By Money vs By Litres
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(
                          value: 'byMoney',
                          label: Text('By Money (₹)'),
                          icon: Icon(Icons.currency_rupee_rounded, size: 16),
                        ),
                        ButtonSegment(
                          value: 'byLitres',
                          label: Text('By Litres (L)'),
                          icon: Icon(Icons.water_drop_outlined, size: 16),
                        ),
                      ],
                      selected: {_entryMethod},
                      onSelectionChanged: (set) {
                        setState(() {
                          _entryMethod = set.first;
                          _onValuesChanged();
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Interactive Amount / Litres / Unit Price Fields
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _entryMethod == 'byMoney'
                              ? _amountPaidController
                              : _litresController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          onChanged: (_) => _onValuesChanged(),
                          decoration: InputDecoration(
                            labelText: _entryMethod == 'byMoney'
                                ? 'Amount Paid *'
                                : 'Litres Purchased *',
                            prefixText: _entryMethod == 'byMoney' ? '₹ ' : null,
                            suffixText: _entryMethod == 'byMoney' ? null : 'L',
                            hintText: _entryMethod == 'byMoney' ? '150' : '2.5',
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Required';
                            }
                            final numVal = double.tryParse(val.trim());
                            if (numVal == null || numVal <= 0) {
                              return 'Must be > 0';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _unitPriceController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          onChanged: (_) => _onValuesChanged(),
                          decoration: const InputDecoration(
                            labelText: 'Price / Litre *',
                            prefixText: '₹ ',
                            hintText: '105.00',
                          ),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Required';
                            }
                            final numVal = double.tryParse(val.trim());
                            if (numVal == null || numVal <= 0) {
                              return 'Must be > 0';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Computed Field Display Banner
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryTeal.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.primaryTeal.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.calculate_outlined,
                          size: 20,
                          color: AppColors.primaryTeal,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _calculationDisplay ??
                                (_entryMethod == 'byMoney'
                                    ? 'Enter amount and rate to calculate litres'
                                    : 'Enter litres and rate to calculate cost'),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.primaryTealDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Mandatory Odometer Reading
                  TextFormField(
                    controller: _odometerController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Current Odometer Reading (km) *',
                      hintText: 'e.g. 5180',
                      suffixText: 'km',
                      prefixIcon: const Icon(Icons.speed_rounded),
                      helperText:
                          'Required for precision mileage interval calculation',
                      helperStyle: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryTeal,
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Odometer reading is mandatory';
                      }
                      final parsed = double.tryParse(val.trim());
                      if (parsed == null || parsed < 0) {
                        return 'Enter a valid non-negative reading';
                      }
                      if (!isEditing && latestOdometer != null && parsed < latestOdometer) {
                        return 'Cannot be lower than previous reading (${latestOdometer.toStringAsFixed(0)} km)';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),

                  // Fill Type Selector (Full Tank vs Partial Fill)
                  Text('Fill Type', style: theme.textTheme.titleSmall),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SegmentedButton<String>(
                      segments: const [
                        ButtonSegment(
                          value: 'full',
                          label: Text('Full Tank'),
                          icon: Icon(Icons.local_gas_station_rounded, size: 16),
                        ),
                        ButtonSegment(
                          value: 'partial',
                          label: Text('Partial Fill'),
                          icon: Icon(Icons.opacity_rounded, size: 16),
                        ),
                      ],
                      selected: {_fillType},
                      onSelectionChanged: (set) =>
                          setState(() => _fillType = set.first),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _fillType == 'full'
                        ? 'Full tank marks a verified calculation boundary.'
                        : 'Partial fills automatically calculate your consecutive refuel mileage without requiring a full tank.',
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 18),

                  // Date & Time Picker Row
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: isDark
                            ? AppColors.darkBorder
                            : AppColors.lightBorder,
                      ),
                    ),
                    leading: const Icon(
                      Icons.calendar_today_rounded,
                      color: AppColors.primaryTeal,
                    ),
                    title: const Text('Date & Time'),
                    subtitle: Text(
                      MetricFormatters.formatDateTime(_entryDateTime),
                    ),
                    trailing: const Icon(Icons.edit_calendar_rounded, size: 20),
                    onTap: _selectDateTime,
                  ),
                  const SizedBox(height: 16),

                  // Optional Fields: Station & Notes
                  TextFormField(
                    controller: _stationController,
                    decoration: const InputDecoration(
                      labelText: 'Petrol Pump / Station Name (Optional)',
                      hintText: 'e.g. IndianOil / HP / Shell',
                      prefixIcon: Icon(Icons.storefront_outlined),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _notesController,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Notes (Optional)',
                      hintText: 'e.g. Highway trip / Premium XP95',
                      prefixIcon: Icon(Icons.notes_rounded),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Save Button with repeated tap prevention
                  ElevatedButton(
                    onPressed: _isSaving ? null : _saveFuelEntry,
                    child: _isSaving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            isEditing
                                ? 'Update Entry'
                                : 'Save Fuel Entry (15s)',
                          ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
