import 'package:dartz/dartz.dart';
import 'package:food_ordering_system/core/errors/failures/failures.dart';
import 'package:food_ordering_system/features/cart/domain/repositories/cart_repository.dart';

/// Use Case for completely removing a specific item from the user's shopping cart.
///
/// Encapsulating this action ensures that the UI (BLoC) does not directly
/// manipulate the cart data. By requiring only the `productId` rather than
/// the entire `Product` entity, we optimize memory usage and make the
/// deletion query against the local database (e.g., Hive) much faster.
class RemoveCartItem {
  /// The abstract contract for cart data operations.
  final CartRepository repository;

  const RemoveCartItem({required this.repository});

  /// Executes the Use Case.
  ///
  /// Forwards the targeted [productId] to the repository for deletion.
  /// Returns a [Future] containing either a [Failure] (if the database operation
  /// fails) or a successful [Unit] representing completion.
  Future<Either<Failure, Unit>> call({required String productId}) async {
    return await repository.removeCartItem(productId: productId);
  }
}