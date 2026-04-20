import 'package:equatable/equatable.dart';

/// Represents a single food item (Product) in the application's Domain layer.
///
/// As a pure Entity, this class contains only the core business data required by
/// the Presentation layer (UI) to display a product. It is intentionally stripped
/// of any framework-specific or API-specific fields (like `sku`, `stock`, or
/// `returnPolicy`) that the user does not need to see.
///
/// It extends [Equatable] to allow the BLoC state management to efficiently
/// compare lists of products and prevent unnecessary UI rebuilds.
class Product extends Equatable {
  /// The unique identifier for the food item.
  final String id;

  /// The display name of the food item.
  final String title;

  /// The cost of the food item.
  final double price;

  /// The average user rating (e.g., 4.5).
  final double rating;

  /// The network URL for the item's display image.
  final String thumbnailURL;

  /// The Category type of the item.
  final String category;

  /// The description of the food item
  final String description;

  /// Constructs a [Product] instance with all required fields.
  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.rating,
    required this.thumbnailURL,
    required this.description,
    required this.category,
  });

  @override
  List<Object?> get props => [id, title, description, rating, thumbnailURL ,category];
}
