import 'package:dartz/dartz.dart';
import 'package:quick_mart/features/home/domain/entities/product.dart';
import '../../../../core/errors/failures/failures.dart';

/// The contract for the Menu Feature's Data Layer.
///
/// By defining this abstract Repository in the Domain layer, we dictate
/// exactly what the app can do with Menu Items without caring *how* it happens.
/// The Presentation layer will call these methods, and the Data layer will
/// be forced to implement them.
abstract class MenuRepository {
  /// Fetches a paginated list of available food items.
  ///
  /// Requires a [page] parameter to handle infinite scrolling or pagination.
  /// Returns a [Future] because data fetching is asynchronous. The result is
  /// either a [Failure] (Server/Network/Cache) or a successful `List<Product>`.
  Future<Either<Failure, List<Product>>> getMenuItems({
    required int page,
    String? categorySlug,
  });

  /// Searches the home for items matching the specific text [query].
  ///
  /// Returns a [Future] containing either a [Failure] or a `List<Product>`
  /// containing all items that match the search string.
  Future<Either<Failure, List<Product>>> searchMenuItems({
    required String query,
    required String categorySlug,
  });
}
