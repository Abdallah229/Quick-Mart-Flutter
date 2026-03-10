import 'package:flutter/material.dart';

/// Displays a modern, floating SnackBar for global app notifications.
void showSnackBar({
  required BuildContext context,
  required String description,
  bool isError = false,
}) {
  final theme = Theme.of(context);

  // 1. Clear any existing snack-bars so they don't queue up and
  // block the screen if the user taps the button 5 times quickly.
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  // 2. Show the new floating SnackBar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // Makes the SnackBar float above the bottom of the screen
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      backgroundColor: isError
          ? theme.colorScheme.error
          : theme.colorScheme.secondary, // Using secondary often pops better for success!
      duration: const Duration(milliseconds: 2000),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: Row(
        children: [
          // Dynamic icon based on success or error
          Icon(
            isError ? Icons.error_outline : Icons.check_circle_outline,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          // Expanded prevents text overflow if the food title is incredibly long
          Expanded(
            child: Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}