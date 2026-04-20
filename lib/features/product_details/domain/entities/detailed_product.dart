import 'package:food_ordering_system/features/menu/domain/entities/product.dart';
import 'package:food_ordering_system/features/product_details/domain/entities/review.dart';

/// A Domain entity representing a fully detailed product.
///
/// Extends the base [Product] class to include rich, heavy data (like [images],
/// [brand], and [reviews]) specifically required for the Product Details screen.
/// By isolating these fields in this subclass, we strictly follow the Single
/// Responsibility Principle and prevent the base [Product] (used in the
/// lightweight Menu grid and Cart) from becoming bloated or causing memory issues.
class DetailedProduct extends Product {
  /// A gallery of high-resolution image URLs.
  final List<String> images;

  /// The manufacturer or creator of the item.
  final String brand;

  /// The current inventory count available for purchase.
  final int stock;

  /// A list of customer [Review] entities.
  final List<Review> reviews;

  /// Searchable keywords associated with the product.
  final List<String> tags;

  const DetailedProduct({
    required super.id,
    required super.title,
    required super.price,
    required super.rating,
    required super.thumbnailURL,
    required super.description,
    required this.images,
    required this.brand,
    required this.stock,
    required this.reviews,
    required this.tags,
    required super.category,
  });

  @override
  List<Object?> get props => [
    ...super.props, // Inherits id, title, price, etc. from base Product
    images,
    brand,
    stock,
    reviews,
    tags,
  ];
}
