import 'package:equatable/equatable.dart';

class CategoryItem extends Equatable {
  final String slug; // The backend ID (e.g., 'smartphones')
  final String name; // The display name (e.g., 'Smartphones')
  final String? thumbnailURL; // Nullable, as the API might not have images for categories

  const CategoryItem({
    required this.slug,
    required this.name,
    this.thumbnailURL,
  });

  @override
  List<Object?> get props => [slug, name, thumbnailURL];
}