import 'package:food_ordering_system/features/menu/domain/entities/product.dart';

/// The Data Layer representation of a food item.
///
/// This model extends the pure Domain [Product] entity and adds the
/// framework-specific logic required to serialize and deserialize data
/// from external sources (like a REST API or a local Hive database).
///
/// By isolating this logic here, the Domain layer remains completely
/// ignorant of JSON structures or API key names.
class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.rating,
    required super.thumbnailURL,
    required super.description,
    required super.category,
  });

  /// Safely constructs a [ProductModel] from a raw JSON map.
  ///
  /// It includes defensive parsing strategies (like using `num?.toDouble()`)
  /// to prevent runtime crashes caused by unexpected type variations from
  /// the backend API.
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    // Safely use ?. to prevent crashes if id is entirely missing
    id: json['id']?.toString() ?? '0',
    // MUST use 'as String?' so it doesn't crash before hitting the ?? fallback
    title: json['title'] as String? ?? 'Unknown Item',
    description: json['description'] as String? ?? '',
    category: json['category'] as String? ?? 'general',

    // MUST use 'as num?' so it doesn't crash on null before converting to double
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    thumbnailURL: json['thumbnail'] as String? ?? '',
  );

  /// Converts the [ProductModel] back into a JSON map.
  ///
  /// Useful for caching the product into local storage or sending it
  /// in a POST request body.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'rating': rating,
      'thumbnail': thumbnailURL, // Mapping our variable back to the API's key
      'category':category,
    };
  }
}
