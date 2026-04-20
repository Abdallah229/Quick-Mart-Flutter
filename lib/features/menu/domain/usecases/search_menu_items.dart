import 'package:dartz/dartz.dart';
import 'package:food_ordering_system/core/errors/failures/failures.dart';
import 'package:food_ordering_system/features/menu/domain/entities/product.dart';
import 'package:food_ordering_system/features/menu/domain/repositories/menu_repository.dart';

/// Use Case for querying the menu based on user search input.
///
/// Encapsulates the specific business logic for finding food items.
/// By keeping this separate from the `GetMenuItems` use case, we adhere
/// to the Single Responsibility Principle. If the search logic ever becomes
/// complex (e.g., adding filter parameters or search history caching),
/// those changes will be isolated entirely within this class.
class SearchMenuItems {
  final MenuRepository repository;

  SearchMenuItems({required this.repository});

  /// Executes the use case.
  ///
  /// Forwards the search [query] to the repository and returns a [Future]
  /// containing either a [Failure] or a successful `List<Product>` that
  /// match the search criteria.
  Future<Either<Failure, List<Product>>> call({
    required String query,
    required String categorySlug,
  }) async {
    return await repository.searchMenuItems(
      query: query,
      categorySlug: categorySlug,
    );
  }
}
