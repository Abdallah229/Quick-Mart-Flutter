import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_system/features/menu/presentation/cubit/menu_cubit.dart';

/// The fallback UI displayed when a network or parsing error occurs.
///
/// Takes a human-readable [errorMessage] to present to the user, and provides
/// a "Try Again" button that triggers a fresh API request via the [MenuCubit].
class WhenMenuError extends StatelessWidget {
  final String errorMessage;

  const WhenMenuError({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off_rounded, // A great default icon for API/Network failures
              size: 80,
              color: theme.colorScheme.error.withOpacity(0.8),
            ),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong.',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // Trigger a fresh reload of the menu starting at page 1
                context.read<MenuCubit>().getMenu(page: 1);
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}