import 'package:food_ordering_system/features/product_details/domain/entities/review.dart';

/// The Data Layer representation of a [Review].
///
/// Extends the pure [Review] domain entity to add framework-specific logic
/// for serializing and deserializing data from external JSON sources.
class ReviewModel extends Review {
  const ReviewModel({
    required super.reviewerName,
    required super.rating,
    required super.comment,
    required super.date,
  });

  /// Safely constructs a [ReviewModel] from a raw JSON map.
  ///
  /// Includes defensive parsing, specifically for the [date] field,
  /// falling back to [DateTime.now()] if the API sends a malformed timestamp.
  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    reviewerName: json['reviewerName'] as String? ?? 'Unknown User',
    rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    comment: (json['comment'] as String? ?? ''),
    date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime.now(),
  );

  /// Converts the [ReviewModel] back into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'reviewerName': reviewerName,
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(),
    };
  }
}