import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_mart/features/home/domain/entities/product.dart';
import 'package:quick_mart/features/home/presentation/cubit/menu_cubit.dart';
import 'package:quick_mart/features/home/presentation/widgets/menu_item.dart';
import 'package:quick_mart/features/product_details/presentation/pages/product_details_screen.dart';

import '../../../../core/widgets/responsive_layout.dart';

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
    // 🚀 Dynamically set columns to prevent massive stretched images on tablets
    final isTablet = ResponsiveLayout.isTablet(context);
    final isDesktop = ResponsiveLayout.isDesktop(context);

    int columns = 2;
    if (isTablet) columns = 4;
    if (isDesktop) columns = 6;

    return GridView.builder(
      controller: _scrollController,
      itemCount: widget.products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns, // Applied here!
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        // TODO : this might fire an exception for now
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ProductDetailsScreen(productID: widget.products[index].id),
              ),
            );
          },

          child: MenuItem(product: widget.products[index]),
        );
      },
    );
  }
}
