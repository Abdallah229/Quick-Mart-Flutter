import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_system/features/menu/domain/entities/product.dart';
import 'package:food_ordering_system/features/menu/presentation/cubit/menu_cubit.dart';
import 'package:food_ordering_system/features/menu/presentation/widgets/menu_item.dart';

/// Renders the scrollable grid of food items and handles Infinite Scrolling.
class MenuList extends StatefulWidget {
  final List<Product> products;

  const MenuList({super.key, required this.products});

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    // Listen to the scroll controller to trigger pagination
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // If we are near the bottom of the list (within 200 pixels)
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {

      _currentPage++;
      // Ask the Cubit to fetch the next page!
      context.read<MenuCubit>().getMenu(page: _currentPage);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Prevent memory leaks!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      itemCount: widget.products.length,
      // Added spacing so the cards don't touch each other
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75, // Adjusts the height of the cards
      ),
      itemBuilder: (context, index) {
        return MenuItem(product: widget.products[index]);
      },
    );
  }
}