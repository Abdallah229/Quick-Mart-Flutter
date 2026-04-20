import 'package:flutter/material.dart';

/// A Presentation-layer utility to map pure Domain slugs to Flutter Icons.
class CategoryIconMapper {
  CategoryIconMapper._();

  static IconData getIcon(String slug) {
    switch (slug) {
      case 'all': return Icons.grid_view_rounded;
      case 'beauty': return Icons.face_retouching_natural;
      case 'fragrances': return Icons.air; // Using air/wind for scent
      case 'furniture': return Icons.chair_rounded;
      case 'groceries': return Icons.local_grocery_store_rounded;
      case 'home-decoration': return Icons.living_rounded;
      case 'kitchen-accessories': return Icons.kitchen_rounded;
      case 'laptops': return Icons.laptop_mac_rounded;
      case 'mens-shirts': return Icons.checkroom_rounded;
      case 'mens-shoes': return Icons.roller_skating_rounded; // Closest to shoes
      case 'mens-watches': return Icons.watch_rounded;
      case 'mobile-accessories': return Icons.headphones_rounded;
      case 'motorcycle': return Icons.two_wheeler_rounded;
      case 'skin-care': return Icons.spa_rounded;
      case 'smartphones': return Icons.smartphone_rounded;
      case 'sports-accessories': return Icons.sports_basketball_rounded;
      case 'sunglasses': return Icons.brightness_high_rounded;
      case 'tablets': return Icons.tablet_mac_rounded;
      case 'tops': return Icons.dry_cleaning_rounded;
      case 'vehicle': return Icons.directions_car_rounded;
      case 'womens-bags': return Icons.shopping_bag_rounded;
      case 'womens-dresses': return Icons.woman_rounded;
      case 'womens-jewellery': return Icons.diamond_rounded;
      case 'womens-shoes': return Icons.snowshoeing_rounded;
      case 'womens-watches': return Icons.watch_rounded;
      default: return Icons.category_rounded; // Fallback icon
    }
  }
}