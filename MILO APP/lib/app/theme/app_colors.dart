import 'package:flutter/material.dart';

/// Premium minimal color palette for Milo Fuel & Expense Tracker.
class AppColors {
  AppColors._();

  // Light Theme Surfaces & Backgrounds (Pure White Interface)
  static const Color lightBackground = Color(0xFFFFFFFF); // Pure white background
  static const Color lightSurface = Color(0xFFFFFFFF); // Pure white cards
  static const Color lightSurfaceSecondary = Color(0xFFF8FAFC); // Subtle slate 50 for pills/chips
  static const Color lightBorder = Color(0xFFE2E8F0); // Crisp light slate 200 border
  static const Color lightBorderSubtle = Color(0xFFF1F5F9);

  // Light Theme Text & Icons (Deep Charcoal)
  static const Color textPrimaryLight = Color(0xFF0F172A); // Slate 900
  static const Color textSecondaryLight = Color(0xFF475569); // Slate 600
  static const Color textMutedLight = Color(0xFF94A3B8); // Slate 400

  // Dark Theme Surfaces & Backgrounds (Mapped to clean white interface)
  static const Color darkBackground = Color(0xFFFFFFFF);
  static const Color darkSurface = Color(0xFFFFFFFF);
  static const Color darkSurfaceSecondary = Color(0xFFF8FAFC);
  static const Color darkBorder = Color(0xFFE2E8F0);
  static const Color darkBorderSubtle = Color(0xFFF1F5F9);

  // Dark Theme Text & Icons (High contrast charcoal)
  static const Color textPrimaryDark = Color(0xFF0F172A);
  static const Color textSecondaryDark = Color(0xFF475569);
  static const Color textMutedDark = Color(0xFF94A3B8);

  // Primary & Accents (Rich Emerald / Teal for sharp contrast on white)
  static const Color primaryTeal = Color(0xFF00875A); // Deep crisp teal
  static const Color primaryTealDark = Color(0xFF006644);
  static const Color primaryTealLight = Color(0xFF00A87E);
  static const Color accentMint = Color(0xFFE6F4EA); // Light mint background
  static const Color accentMintDark = Color(0xFF006644);

  // Status Colors (Positive financial, warning, error)
  static const Color positiveGreen = Color(0xFF10B981); // Emerald 500
  static const Color positiveGreenLight = Color(0xFFD1FAE5);
  static const Color warningOrange = Color(0xFFF59E0B); // Amber 500
  static const Color warningOrangeLight = Color(0xFFFEF3C7);
  static const Color warningOrangeDark = Color(0xFFB45309); // Amber 700
  static const Color errorRed = Color(0xFFEF4444); // Red 500
  static const Color errorRedLight = Color(0xFFFEE2E2);
  static const Color infoBlue = Color(0xFF3B82F6); // Blue 500
  static const Color infoBlueLight = Color(0xFFDBEAFE);

  // Vehicle Category Accents
  static const Color motorcycleAccent = Color(0xFF6366F1); // Indigo
  static const Color carAccent = Color(0xFF0EA5E9); // Sky
  static const Color scooterAccent = Color(0xFF8B5CF6); // Purple
  static const Color otherAccent = Color(0xFF64748B); // Slate
}

