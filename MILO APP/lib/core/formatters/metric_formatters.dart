import 'package:intl/intl.dart';

/// Formatter utilities for currency (minor units -> major units), distance, fuel, and dates.
class MetricFormatters {
  MetricFormatters._();

  /// Converts minor currency units (e.g., paise) to major currency units (e.g., rupees).
  /// 15000 paise -> ₹150.00
  static String formatCurrency(
    int minorUnits, {
    String currencyCode = 'INR',
    bool showDecimals = true,
  }) {
    final majorAmount = minorUnits / 100.0;
    if (currencyCode.toUpperCase() == 'INR') {
      final formatter = NumberFormat.currency(
        locale: 'en_IN',
        symbol: '₹',
        decimalDigits: showDecimals ? 2 : 0,
      );
      return formatter.format(majorAmount);
    }

    final formatter = NumberFormat.currency(
      name: currencyCode,
      decimalDigits: showDecimals ? 2 : 0,
    );
    return formatter.format(majorAmount);
  }

  /// Parses an entered string amount (e.g. "150.50") into integer minor units (15050).
  /// Avoids floating point precision loss by splitting integer and fractional parts.
  static int parseMajorToMinorUnits(String input) {
    final clean = input.trim().replaceAll(',', '');
    if (clean.isEmpty) return 0;
    final parts = clean.split('.');
    final integerPart = int.tryParse(parts[0]) ?? 0;
    int fractionalPart = 0;
    if (parts.length > 1) {
      final fractionString = parts[1].padRight(2, '0').substring(0, 2);
      fractionalPart = int.tryParse(fractionString) ?? 0;
    }
    return (integerPart * 100) + fractionalPart;
  }

  /// Formats fuel quantity in litres with standard precision (e.g. 1.429 L or 2.50 L).
  static String formatFuelQuantity(double litres, {int decimals = 2}) {
    return '${litres.toStringAsFixed(decimals)} L';
  }

  /// Formats distance in kilometres (e.g. 180.0 km or 5,180 km).
  static String formatDistance(double km, {bool integerOnly = false}) {
    final formatter = NumberFormat('#,##0${integerOnly ? '' : '.#'}');
    return '${formatter.format(km)} km';
  }

  /// Formats mileage in km/L (e.g. 30.00 km/L).
  static String formatMileage(double? kmPerLitre) {
    if (kmPerLitre == null || kmPerLitre.isNaN || kmPerLitre.isInfinite) {
      return '-- km/L';
    }
    return '${kmPerLitre.toStringAsFixed(2)} km/L';
  }

  /// Formats cost per kilometre in currency (e.g. ₹3.50/km).
  static String formatCostPerKm(
    double? costPerKm, {
    String currencyCode = 'INR',
  }) {
    if (costPerKm == null || costPerKm.isNaN || costPerKm.isInfinite) {
      return '-- / km';
    }
    final symbol = currencyCode.toUpperCase() == 'INR' ? '₹' : '$currencyCode ';
    return '$symbol${costPerKm.toStringAsFixed(2)}/km';
  }

  /// Formats short dates (e.g. 28 Oct 2026).
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  /// Formats date with time (e.g. 28 Oct 2026, 04:15 PM).
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
  }
}
