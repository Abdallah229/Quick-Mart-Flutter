import 'package:equatable/equatable.dart';

/// A Domain entity representing a single customer review.
///
/// This class contains the core business data for a review, independent of
/// any external APIs or JSON structures. It uses [Equatable] to allow for
/// value-based equality comparisons.
class Review extends Equatable {
  /// The display name of the user who left the review.
  final String reviewerName;

  /// The rating out of 5 stars.
  final double rating;

  /// The written text of the review. Can be null if the user only left a star rating.
  final String? comment;

  /// The exact date and time the review was posted.
  final DateTime date;

  const Review({
    required this.reviewerName,
    required this.rating,
    required this.comment,
    required this.date,
  });

  @override
  List<Object?> get props => [reviewerName, rating, comment, date];
}