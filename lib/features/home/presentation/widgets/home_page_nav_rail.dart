import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../../core/utils/destination/app_destinations.dart';

class HomePageNavRail extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const HomePageNavRail({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final totalCartItems = context.read<CartCubit>().getTotalCartItems();

    return NavigationRail(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: AppDestinations.items.map((dest) {
        final isCart = dest.label == 'Cart';
        return NavigationRailDestination(
          icon: isCart
              ? Badge(isLabelVisible: totalCartItems > 0, label: Text('$totalCartItems'), child: Icon(dest.icon))
              : Icon(dest.icon),
          selectedIcon: isCart
              ? Badge(isLabelVisible: totalCartItems > 0, label: Text('$totalCartItems'), child: Icon(dest.activeIcon))
              : Icon(dest.activeIcon),
          label: Text(dest.label),
        );
      }).toList(),
    );
  }
}