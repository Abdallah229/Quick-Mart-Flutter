import 'package:flutter/material.dart';
import '../colors/dark_colors.dart';

ThemeData get darkTheme {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: DarkColors.background,

    // Core Color Scheme
    colorScheme: const ColorScheme.dark(
      primary: DarkColors.primary,
      onPrimary: DarkColors.onPrimary,
      primaryContainer: DarkColors.primaryContainer,
      onPrimaryContainer: DarkColors.onPrimaryContainer,
      surface: DarkColors.surface,
      onSurface: DarkColors.onSurface,
      surfaceContainerHighest: DarkColors.surfaceContainerHighest,
      onSurfaceVariant: DarkColors.onSurfaceVariant,
      outlineVariant: DarkColors.outlineVariant,
      error: DarkColors.error,
      onError: DarkColors.onError,
    ),

    // Component-Specific Overrides
    appBarTheme: const AppBarTheme(
      backgroundColor: DarkColors.surface,
      foregroundColor: DarkColors.onSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: DarkColors.surface,
      selectedItemColor: DarkColors.primary,
      unselectedItemColor: DarkColors.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    cardTheme: CardThemeData(
      color: DarkColors.surface,
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}