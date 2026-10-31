/// Domain service for pure mathematical calculations of fuel costs, quantities,
/// and reciprocal values without binary float inaccuracies.
class FuelCalculator {
  FuelCalculator._();

  /// Calculates fuel quantity in litres given amount paid in minor units (paise)
  /// and unit price per litre in minor units (paise).
  ///
  /// Example: ₹150 (15000 paise) at ₹105/L (10500 paise) -> 1.4285714285714286 L
  static double calculateQuantityFromMoney({
    required int amountPaidMinorUnits,
    required int unitPriceMinorUnitsPerLitre,
  }) {
    if (amountPaidMinorUnits <= 0) {
      throw ArgumentError.value(
        amountPaidMinorUnits,
        'amountPaidMinorUnits',
        'Amount paid must be strictly positive.',
      );
    }
    if (unitPriceMinorUnitsPerLitre <= 0) {
      throw ArgumentError.value(
        unitPriceMinorUnitsPerLitre,
        'unitPriceMinorUnitsPerLitre',
        'Unit price per litre must be strictly positive.',
      );
    }

    return amountPaidMinorUnits / unitPriceMinorUnitsPerLitre;
  }

  /// Calculates total cost in minor units (paise) given quantity in litres
  /// and unit price per litre in minor units (paise).
  ///
  /// Example: 2.5 L at ₹105/L (10500 paise) -> 26250 paise (₹262.50)
  static int calculateCostFromQuantity({
    required double fuelQuantityLitres,
    required int unitPriceMinorUnitsPerLitre,
  }) {
    if (fuelQuantityLitres <= 0 ||
        fuelQuantityLitres.isNaN ||
        fuelQuantityLitres.isInfinite) {
      throw ArgumentError.value(
        fuelQuantityLitres,
        'fuelQuantityLitres',
        'Fuel quantity must be strictly positive and finite.',
      );
    }
    if (unitPriceMinorUnitsPerLitre <= 0) {
      throw ArgumentError.value(
        unitPriceMinorUnitsPerLitre,
        'unitPriceMinorUnitsPerLitre',
        'Unit price per litre must be strictly positive.',
      );
    }

    // Rounding to nearest minor unit (e.g., paise)
    return (fuelQuantityLitres * unitPriceMinorUnitsPerLitre).round();
  }

  /// Calculates unit price in minor units (paise/L) from total cost and quantity.
  static int calculateUnitPrice({
    required int amountPaidMinorUnits,
    required double fuelQuantityLitres,
  }) {
    if (amountPaidMinorUnits <= 0) {
      throw ArgumentError('Amount paid must be strictly positive.');
    }
    if (fuelQuantityLitres <= 0 ||
        fuelQuantityLitres.isNaN ||
        fuelQuantityLitres.isInfinite) {
      throw ArgumentError(
        'Fuel quantity must be strictly positive and finite.',
      );
    }

    return (amountPaidMinorUnits / fuelQuantityLitres).round();
  }

  /// Validates odometer sequence between a previous and current reading.
  /// Distance must be non-negative (strictly positive for new refuelling trips).
  static double validateAndCalculateDistance({
    required double previousOdometerKm,
    required double currentOdometerKm,
  }) {
    if (previousOdometerKm < 0) {
      throw ArgumentError('Previous odometer cannot be negative.');
    }
    if (currentOdometerKm < 0) {
      throw ArgumentError('Current odometer cannot be negative.');
    }
    final distance = currentOdometerKm - previousOdometerKm;
    if (distance < 0) {
      throw ArgumentError(
        'Chronological odometer error: Current reading ($currentOdometerKm km) '
        'is lower than previous reading ($previousOdometerKm km).',
      );
    }
    return distance;
  }
}
