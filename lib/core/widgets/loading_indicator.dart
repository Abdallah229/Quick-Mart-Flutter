import 'package:flutter/material.dart';

/// A globally shared, standardized loading spinner.
///
/// Ensures the loading animation is perfectly centered in whatever parent
/// container it is placed inside.
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}