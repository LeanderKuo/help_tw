import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette - Google Material Blue
  static const Color primary = Color(0xFF1976D2); // Material Blue 700
  static const Color primaryLight = Color(0xFF2196F3); // Material Blue 500
  static const Color primaryDark = Color(0xFF1565C0); // Material Blue 800

  // Secondary/Accent Colors
  static const Color secondary = Color(0xFF00BFA5); // Teal Accent 700
  static const Color secondaryLight = Color(0xFF1DE9B6); // Teal Accent 400

  // Semantic Colors
  static const Color error = Color(0xFFD32F2F); // Material Red 700
  static const Color success = Color(0xFF388E3C); // Material Green 700
  static const Color warning = Color(0xFFF57C00); // Material Orange 700
  static const Color info = Color(0xFF1976D2); // Material Blue 700

  // Neutral Colors - Light Theme
  static const Color backgroundLight = Color(0xFFF5F5F5); // Material Grey 100
  static const Color surfaceLight = Colors.white;
  static const Color textPrimaryLight = Color(0xFF212121); // Material Grey 900
  static const Color textSecondaryLight = Color(0xFF757575); // Material Grey 600
  static const Color dividerLight = Color(0xFFE0E0E0); // Material Grey 300

  // Neutral Colors - Dark Theme
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  static const Color dividerDark = Color(0xFF2C2C2C);

  // Card and Container Colors
  static const Color cardLight = Colors.white;
  static const Color cardDark = Color(0xFF2C2C2C);

  // Status Colors for Tasks/Shuttles
  static const Color statusActive = Color(0xFF4CAF50); // Green
  static const Color statusPending = Color(0xFFFFC107); // Amber
  static const Color statusCompleted = Color(0xFF9E9E9E); // Grey
  static const Color statusUrgent = Color(0xFFF44336); // Red

  // Chip/Badge Colors
  static const Color chipFood = Color(0xFFFF9800); // Orange
  static const Color chipWater = Color(0xFF2196F3); // Blue
  static const Color chipClothes = Color(0xFF9C27B0); // Purple
  static const Color chipShelter = Color(0xFF4CAF50); // Green
}
