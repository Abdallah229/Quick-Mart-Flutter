import 'package:flutter/material.dart';
import '../colors/light_colors.dart';

ThemeData get lightTheme {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: LightColors.background,

    // Core Color Scheme
    colorScheme: const ColorScheme.light(
      primary: LightColors.primary,
      onPrimary: LightColors.onPrimary,
      primaryContainer: LightColors.primaryContainer,
      onPrimaryContainer: LightColors.onPrimaryContainer,
      surface: LightColors.surface,
      onSurface: LightColors.onSurface,
      surfaceContainerHighest: LightColors.surfaceContainerHighest,
      onSurfaceVariant: LightColors.onSurfaceVariant,
      outlineVariant: LightColors.outlineVariant,
      error: LightColors.error,
      onError: LightColors.onError,
    ),

    // Component-Specific Overrides
    appBarTheme: const AppBarTheme(
      backgroundColor: LightColors.surface,
      foregroundColor: LightColors.onSurface,
      elevation: 0,
      scrolledUnderElevation: 0, // Prevents weird tinting on scroll in M3
      centerTitle: true,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: LightColors.surface,
      selectedItemColor: LightColors.primary,
      unselectedItemColor: LightColors.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    cardTheme: CardThemeData(
      color: LightColors.surface,
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}