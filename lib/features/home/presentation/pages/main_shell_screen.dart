import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/responsive_layout.dart';
import '../../../../injection_container.dart';
import '../../../cart/presentation/pages/cart_screen.dart';
import '../../../explore/presentation/pages/explore_screen.dart';
import '../../../profile/presentation/pages/profile_screen.dart';
import '../cubit/menu_cubit.dart';
import 'home_screen.dart';
import '../widgets/home_page_bottom_nav_bar.dart';
import '../widgets/home_page_nav_rail.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = ResponsiveLayout.isTablet(context) || ResponsiveLayout.isDesktop(context);

    return BlocProvider(
      create: (context) => sl<MenuCubit>()..getMenu(page: 1),
      child: Scaffold(
        body: Row(
          children: [
            // Shows Side Rail on Tablets/Web
            if (isTablet)
              HomePageNavRail(currentIndex: _currentIndex, onTap: _onTabTapped),

            // The Main Content Area
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: [
                  const HomeScreen(), // Ensure your menu_screen was renamed to home_screen!
                  ExploreScreen(onNavigateToTab: _onTabTapped),
                  const CartScreen(),
                  const ProfileScreen(),
                ],
              ),
            ),
          ],
        ),
        // Shows Bottom Nav on Mobile
        bottomNavigationBar: isTablet
            ? null
            : HomePageBottomNavBar(currentIndex: _currentIndex, onTap: _onTabTapped),
      ),
    );
  }
}