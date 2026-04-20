import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_mart/core/enums/request_state.dart';
import 'package:quick_mart/core/widgets/loading_indicator.dart';
import 'package:quick_mart/features/home/presentation/cubit/menu_cubit.dart';
import 'package:quick_mart/features/home/presentation/cubit/menu_state.dart';
import 'package:quick_mart/features/home/presentation/widgets/category_filter_row.dart';
import 'package:quick_mart/features/home/presentation/widgets/menu_app_bar.dart';
import 'package:quick_mart/features/home/presentation/widgets/menu_list.dart';
import 'package:quick_mart/features/home/presentation/widgets/when_empty_menu.dart';
import 'package:quick_mart/features/home/presentation/widgets/when_menu_error.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MenuAppBar(title: 'Market'),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            const CategoryFilterRow(),
            const SizedBox(height: 16),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: BlocBuilder<MenuCubit, MenuState>(
                  builder: (context, state) {
                    switch (state.status) {
                      case RequestState.initial:
                        return const SizedBox.shrink();

                      case RequestState.loading:
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
                        if (state.products.isEmpty) {
                          return WhenMenuError(
                            errorMessage: state.errorMessage,
                          );
                        } else {
                          return MenuList(products: state.products);
                        }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
