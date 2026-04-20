import 'package:quick_mart/features/home/domain/entities/category_item.dart';

/// Localized cache of available market categories.
///
/// Used to populate the horizontal scrollable UI on the Home Screen.
class AppCategories {
  AppCategories._();
  static const CategoryItem allCategory = CategoryItem(
    slug: 'all',
    name: 'All',
  );
  static const List<CategoryItem> items = [
    // Our custom "All" category to fetch the root products endpoint
    CategoryItem(slug: 'all', name: 'All'),
    CategoryItem(slug: 'beauty', name: 'Beauty'),
    CategoryItem(slug: 'fragrances', name: 'Fragrances'),
    CategoryItem(slug: 'furniture', name: 'Furniture'),
    CategoryItem(slug: 'groceries', name: 'Groceries'),
    CategoryItem(slug: 'home-decoration', name: 'Home Decoration'),
    CategoryItem(slug: 'kitchen-accessories', name: 'Kitchen Accessories'),
    CategoryItem(slug: 'laptops', name: 'Laptops'),
    CategoryItem(slug: 'mens-shirts', name: 'Mens Shirts'),
    CategoryItem(slug: 'mens-shoes', name: 'Mens Shoes'),
    CategoryItem(slug: 'mens-watches', name: 'Mens Watches'),
    CategoryItem(slug: 'mobile-accessories', name: 'Mobile Accessories'),
    CategoryItem(slug: 'motorcycle', name: 'Motorcycle'),
    CategoryItem(slug: 'skin-care', name: 'Skin Care'),
    CategoryItem(slug: 'smartphones', name: 'Smartphones'),
    CategoryItem(slug: 'sports-accessories', name: 'Sports Accessories'),
    CategoryItem(slug: 'sunglasses', name: 'Sunglasses'),
    CategoryItem(slug: 'tablets', name: 'Tablets'),
    CategoryItem(slug: 'tops', name: 'Tops'),
    CategoryItem(slug: 'vehicle', name: 'Vehicle'),
    CategoryItem(slug: 'womens-bags', name: 'Womens Bags'),
    CategoryItem(slug: 'womens-dresses', name: 'Womens Dresses'),
    CategoryItem(slug: 'womens-jewellery', name: 'Womens Jewellery'),
    CategoryItem(slug: 'womens-shoes', name: 'Womens Shoes'),
    CategoryItem(slug: 'womens-watches', name: 'Womens Watches'),
  ];
}
