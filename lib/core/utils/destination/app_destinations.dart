import 'package:flutter/material.dart';
import 'destination.dart';

class AppDestinations {
  const AppDestinations._();

  static const List<Destination> items = [
    Destination(
      icon: Icons.storefront_outlined,
      label: 'Market',
      activeIcon: Icons.storefront,
    ),
    Destination(
      icon: Icons.search_outlined,
      label: 'Explore',
      activeIcon: Icons.search,
    ),
    Destination(
      icon: Icons.shopping_cart_outlined,
      label: 'Cart',
      activeIcon: Icons.shopping_cart,
    ),
    Destination(
      icon: Icons.person_outline,
      label: 'Profile',
      activeIcon: Icons.person,
    ),
  ];
}