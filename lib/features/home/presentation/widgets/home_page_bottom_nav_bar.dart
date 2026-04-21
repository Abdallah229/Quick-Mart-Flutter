import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cart/presentation/cubit/cart_cubit.dart';
import '../../../../core/utils/destination/app_destinations.dart';

class HomePageBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const HomePageBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Real-time cart reading for the badge!
    final totalCartItems = context.read<CartCubit>().getTotalCartItems();

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: theme.colorScheme.primary,
      unselectedItemColor: theme.colorScheme.onSurfaceVariant,
      items: AppDestinations.items.map((dest) {
        final isCart = dest.label == 'Cart';
        return BottomNavigationBarItem(
          icon: isCart
              ? Badge(isLabelVisible: totalCartItems > 0, label: Text('$totalCartItems'), child: Icon(dest.icon))
              : Icon(dest.icon),
          activeIcon: isCart
              ? Badge(isLabelVisible: totalCartItems > 0, label: Text('$totalCartItems'), child: Icon(dest.activeIcon))
              : Icon(dest.activeIcon),
          label: dest.label,
        );
      }).toList(),
    );
  }
}