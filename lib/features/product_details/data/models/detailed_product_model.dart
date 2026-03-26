import 'dart:convert';

import 'package:food_ordering_system/features/product_details/data/models/review_model.dart';
import 'package:food_ordering_system/features/product_details/domain/entities/detailed_product.dart';

/// The Data Layer representation of a [DetailedProduct].
///
/// Handles the complex JSON parsing required for rich data structures.
/// It uses defensive strategies to map raw dynamic lists into typed Dart lists,
/// ensuring the app remains crash-proof even if the backend API omits fields
/// or changes data types unexpectedly.
class DetailedProductModel extends DetailedProduct {
  const DetailedProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.rating,
    required super.thumbnailURL,
    required super.description,
    required super.images,
    required super.brand,
    required super.stock,
    required super.reviews,
    required super.tags,
  });

  /// Constructs a [DetailedProductModel] safely from a JSON payload.
  factory DetailedProductModel.fromJson(Map<String, dynamic> json) => DetailedProductModel(
    id: json['id']?.toString() ?? '0',
    title: json['title'] as String? ?? 'Unknown Item',
    price: (json['price'] as num?)?.toDouble() ?? 0.0,
    rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    thumbnailURL: json['thumbnail'] as String? ?? '',
    description: json['description'] as String? ?? '',

    // Safely mapping dynamic JSON arrays into strict Dart Lists
    images: (json['images'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    brand: json['brand'] as String? ?? 'Unknown Brand',
    stock: (json['stock'] as num?)?.toInt() ?? 0,

    // Iterates through the raw JSON review list and creates typed ReviewModels
    reviews: (json['reviews'] as List<dynamic>?)
        ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
        .toList() ?? [],

    tags: (json['tags'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
  );


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'rating': rating,
      'thumbnail': thumbnailURL,
      'description': description,
      'images': images,
      'brand': brand,
      'stock': stock,
      'reviews': reviews.map((e) => (e as ReviewModel).toJson()).toList(),
      'tags': tags,
    };
  }
}