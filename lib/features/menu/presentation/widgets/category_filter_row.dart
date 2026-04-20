import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_system/core/constants/app_categories.dart';
import 'package:food_ordering_system/core/utils/category_icon_mapper.dart';
import 'package:food_ordering_system/features/menu/presentation/cubit/menu_cubit.dart';
import 'package:food_ordering_system/features/menu/presentation/cubit/menu_state.dart';

class CategoryFilterRow extends StatelessWidget {
  const CategoryFilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        return SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // FIXED: Edge padding
            itemCount: AppCategories.items.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final currentCategory = AppCategories.items[index];
              final isSelected = state.selectedCategory.slug == currentCategory.slug;

              final backgroundColor = isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5);
              final foregroundColor = isSelected
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onSurfaceVariant;
              return Material(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(24), // Pill shape
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: ()  {
                     context.read<MenuCubit>().selectCategory(currentCategory);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CategoryIconMapper.getIcon(currentCategory.slug),
                          color: foregroundColor,
                          size: 20, // Slightly smaller icon
                        ),
                        const SizedBox(width: 8),
                        Text(
                          currentCategory.name,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: foregroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}