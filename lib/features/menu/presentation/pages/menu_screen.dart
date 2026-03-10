import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_system/core/enums/request_state.dart';
import 'package:food_ordering_system/core/widgets/loading_indicator.dart';
import 'package:food_ordering_system/features/menu/presentation/cubit/menu_cubit.dart';
import 'package:food_ordering_system/features/menu/presentation/cubit/menu_state.dart';
import 'package:food_ordering_system/features/menu/presentation/widgets/menu_app_bar.dart';
import 'package:food_ordering_system/features/menu/presentation/widgets/menu_list.dart';
import 'package:food_ordering_system/features/menu/presentation/widgets/when_empty_menu.dart';
import 'package:food_ordering_system/features/menu/presentation/widgets/when_menu_error.dart';
import 'package:food_ordering_system/injection_container.dart';

/// The root UI component for the Menu feature.
///
/// This screen acts as a shell. It injects the [MenuCubit] into the widget tree
/// and listens to state changes. It contains no complex UI logic itself; instead,
/// it delegates rendering to highly specific, stateless child widgets based on
/// the current [RequestState].
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Fetch the first page of the menu immediately when the screen opens
      create: (context) => sl<MenuCubit>()..getMenu(page: 1),
      child: Scaffold(
        appBar: const MenuAppBar(title: 'Delicious Menu'),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: BlocBuilder<MenuCubit, MenuState>(
              builder: (context, state) {
                switch (state.status) {
                  case RequestState.initial:
                    return const SizedBox.shrink();

                  case RequestState.loading:
                  // Only show full-screen loader if we have no products.
                  // If we have products, we are paginating, so keep showing the list!
                    if (state.products.isEmpty) {
                      return const LoadingIndicator();
                    } else {
                      return MenuList(products: state.products);
                    }

                  case RequestState.success:
                    if (state.products.isEmpty) {
                      return const WhenEmptyMenu();
                    } else {
                      return MenuList(products: state.products);
                    }

                  case RequestState.error:
                  // If we have an error but also have products (e.g., page 2 failed),
                  // you might want to show a SnackBar instead of replacing the list.
                  // For now, replacing it with the error widget is a safe fallback.
                    if (state.products.isEmpty) {
                      return WhenMenuError(errorMessage: state.errorMessage);
                    } else {
                      // TODO : Add snack-bar to indicate the error.
                      // Keep the list on screen if a pagination fetch fails
                      return MenuList(products: state.products);
                    }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}