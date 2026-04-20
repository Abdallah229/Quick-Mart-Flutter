import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_mart/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:quick_mart/features/cart/presentation/pages/cart_screen.dart';
import 'package:quick_mart/features/explore/presentation/pages/explore_screen.dart';
import 'package:quick_mart/features/home/presentation/cubit/menu_cubit.dart';
import 'package:quick_mart/features/home/presentation/pages/home_screen.dart';
import 'package:quick_mart/features/profile/presentation/pages/profile_screen.dart';

import '../../../../injection_container.dart';
import '../../../cart/presentation/cubit/cart_state.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => sl<MenuCubit>()..getMenu(page: 1),
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            const MenuScreen(),
            ExploreScreen(onNavigateToTab: _onTabTapped),
            const CartScreen(),
            const ProfileScreen(),
          ],
        ),
        bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final totalCartItems = state.items.fold(
              0,
              (sum, item) => sum + item.quantity,
            );

            return BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onTabTapped,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: theme.colorScheme.primary,
              unselectedItemColor: theme.colorScheme.onSurfaceVariant,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.storefront_outlined),
                  label: 'Market',
                  activeIcon: Icon(Icons.storefront),
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined),
                  activeIcon: Icon(Icons.search),
                  label: 'Explore',
                ),

                BottomNavigationBarItem(
                  icon: Badge(
                    isLabelVisible: totalCartItems > 0,
                    label: Text(totalCartItems.toString()),
                    child: const Icon(Icons.shopping_cart_outlined),
                  ),
                  label: 'Cart',
                  activeIcon: Badge(
                    isLabelVisible: totalCartItems > 0,
                    label: Text(totalCartItems.toString()),
                    child: const Icon(Icons.shopping_cart),
                  ),
                ),

                const BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
