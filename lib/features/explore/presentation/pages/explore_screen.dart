import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_mart/core/constants/app_categories.dart';
import 'package:quick_mart/core/utils/category_icon_mapper.dart';
import 'package:quick_mart/features/home/presentation/cubit/menu_cubit.dart';

// TODO : fix when choosing a filter that filter be presented in the category filter row
class ExploreScreen extends StatelessWidget {
  // This callback allows us to talk to the BottomNavigationBar in the Shell
  final void Function(int index) onNavigateToTab;

  const ExploreScreen({super.key, required this.onNavigateToTab});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // We filter out the 'All' category because the Explore screen is for specific discovery
    final categories = AppCategories.items
        .where((c) => c.slug != 'all')
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 columns for a neat directory layout
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio:
              0.85, // Slightly taller than a square to fit the text
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return Material(
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.3,
            ),
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                // 1. Tell the Cubit to apply the category filter
                context.read<MenuCubit>().selectCategory(category);

                // 2. Tell the Shell Screen to jump to Tab 0 (The Market)
                onNavigateToTab(0);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // A nice circular background behind the icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      CategoryIconMapper.getIcon(category.slug),
                      color: theme.colorScheme.primary,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Text(
                      category.name,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
