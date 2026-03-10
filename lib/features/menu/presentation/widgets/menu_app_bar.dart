import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_system/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:food_ordering_system/features/cart/presentation/cubit/cart_state.dart';

/// The custom AppBar for the Menu Screen.
///
/// Implements [PreferredSizeWidget] so it can be used natively in a Scaffold.
/// It contains a dynamic shopping cart icon that listens to the [CartCubit]
/// and displays a badge with the total number of items currently in the cart.
class MenuAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MenuAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        // We only wrap the icon in the BlocBuilder so the rest of the AppBar
        // doesn't rebuild unnecessarily when the cart changes!
        BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            // Calculate the total quantity of items in the cart
            final totalItems = state.items.fold(
              0,
                  (sum, item) => sum + item.quantity,
            );

            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                onPressed: () {
                  // TODO: Navigate to the Cart Screen
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
                },
                // The Badge widget is a fantastic built-in Material 3 feature
                icon: Badge(
                  // Hide the red badge completely if the cart is empty
                  isLabelVisible: totalItems > 0,
                  label: Text(totalItems.toString()),
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}