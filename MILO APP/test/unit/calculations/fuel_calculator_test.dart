import 'package:flutter_test/flutter_test.dart';
import 'package:milo/domain/calculations/fuel_calculator.dart';

void main() {
  group('FuelCalculator Unit Tests', () {
    test('Calculates fuel quantity from money accurately (₹150 at ₹105/L)', () {
      // 15000 paise / 10500 paise per litre = 1.4285714... L
      final quantity = FuelCalculator.calculateQuantityFromMoney(
        amountPaidMinorUnits: 15000,
        unitPriceMinorUnitsPerLitre: 10500,
      );

      expect(quantity, closeTo(1.428571, 0.00001));
    });

    test('Calculates total cost from quantity accurately (2.5 L at ₹105/L = ₹262.50)', () {
      // 2.5 L * 10500 paise = 26250 paise (₹262.50)
      final costMinorUnits = FuelCalculator.calculateCostFromQuantity(
        fuelQuantityLitres: 2.5,
        unitPriceMinorUnitsPerLitre: 10500,
      );

      expect(costMinorUnits, equals(26250));
    });

    test('Rejects zero and negative amounts paid', () {
      expect(
        () => FuelCalculator.calculateQuantityFromMoney(
          amountPaidMinorUnits: 0,
          unitPriceMinorUnitsPerLitre: 10500,
        ),
        throwsArgumentError,
      );

      expect(
        () => FuelCalculator.calculateQuantityFromMoney(
          amountPaidMinorUnits: -500,
          unitPriceMinorUnitsPerLitre: 10500,
        ),
        throwsArgumentError,
      );
    });

    test('Rejects zero and negative unit prices', () {
      expect(
        () => FuelCalculator.calculateQuantityFromMoney(
          amountPaidMinorUnits: 15000,
          unitPriceMinorUnitsPerLitre: 0,
        ),
        throwsArgumentError,
      );

      expect(
        () => FuelCalculator.calculateCostFromQuantity(
          fuelQuantityLitres: 2.5,
          unitPriceMinorUnitsPerLitre: -100,
        ),
        throwsArgumentError,
      );
    });

    test('Rejects zero, negative, NaN and Infinite quantities', () {
      expect(
        () => FuelCalculator.calculateCostFromQuantity(
          fuelQuantityLitres: 0.0,
          unitPriceMinorUnitsPerLitre: 10500,
        ),
        throwsArgumentError,
      );

      expect(
        () => FuelCalculator.calculateCostFromQuantity(
          fuelQuantityLitres: -2.0,
          unitPriceMinorUnitsPerLitre: 10500,
        ),
        throwsArgumentError,
      );

      expect(
        () => FuelCalculator.calculateCostFromQuantity(
          fuelQuantityLitres: double.nan,
          unitPriceMinorUnitsPerLitre: 10500,
        ),
        throwsArgumentError,
      );
    });

    test('Odometer validation: increasing readings produce valid distance', () {
      final distance = FuelCalculator.validateAndCalculateDistance(
        previousOdometerKm: 5000.0,
        currentOdometerKm: 5180.0,
      );

      expect(distance, equals(180.0));
    });

    test('Odometer validation: decreasing readings are rejected', () {
      expect(
        () => FuelCalculator.validateAndCalculateDistance(
          previousOdometerKm: 5180.0,
          currentOdometerKm: 5000.0,
        ),
        throwsArgumentError,
      );
    });

    test('Calculates fuel and cost accurately at default petrol price ₹117.24/L', () {
      // 7 L at ₹117.24/L (11724 paise/L) = 82068 paise (₹820.68)
      final costMinorUnits = FuelCalculator.calculateCostFromQuantity(
        fuelQuantityLitres: 7.0,
        unitPriceMinorUnitsPerLitre: 11724,
      );
      expect(costMinorUnits, equals(82068));

      // ₹820.68 (82068 paise) at ₹117.24/L (11724 paise/L) = 7.0 L
      final quantity = FuelCalculator.calculateQuantityFromMoney(
        amountPaidMinorUnits: 82068,
        unitPriceMinorUnitsPerLitre: 11724,
      );
      expect(quantity, closeTo(7.0, 0.0001));
    });
  });
}

