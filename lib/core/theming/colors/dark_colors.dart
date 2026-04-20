import 'package:flutter/material.dart';

class DarkColors {
  DarkColors._();

  // Primary Brand Colors (Slightly desaturated for dark mode readability)
  static const Color primary = Color(0xFFFF8A65);
  static const Color onPrimary = Color(0xFF3E2723);
  static const Color primaryContainer = Color(0xFFD84315);
  static const Color onPrimaryContainer = Color(0xFFFFCCBC);

  // Background and Surface Colors (Deep greys, NOT pure black, to reduce eye strain)
  static const Color background = Color(0xFF121212);
  static const Color onBackground = Color(0xFFE0E0E0);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color onSurface = Color(0xFFE0E0E0);

  // Variations for cards and inactive elements
  static const Color surfaceContainerHighest = Color(0xFF2C2C2C);
  static const Color onSurfaceVariant = Color(0xFFAAAAAA);
  static const Color outlineVariant = Color(0xFF424242);

  // Semantic Colors
  static const Color error = Color(0xFFEF5350);
  static const Color onError = Colors.black;
  static const Color success = Color(0xFF66BB6A);
}