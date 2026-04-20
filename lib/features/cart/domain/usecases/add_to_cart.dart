import 'package:dartz/dartz.dart';
import 'package:quick_mart/core/errors/failures/failures.dart';
import 'package:quick_mart/features/cart/domain/repositories/cart_repository.dart';
import 'package:quick_mart/features/home/domain/entities/product.dart';

/// Use Case for adding a specific food item to the user's shopping cart.
///
/// Encapsulating this action in its own class adheres to the Single Responsibility
/// Principle. If the business ever introduces complex logic before an item
/// can be added (e.g., checking if the item is currently in stock, or verifying
/// if the user has reached a maximum item limit), that logic would live entirely
/// inside this class without affecting the UI or the Data Layer.
class AddToCart {
  /// The abstract contract for cart data operations.
  final CartRepository repository;

  /// Constructs the Use Case with necessary dependencies injected.
  const AddToCart({required this.repository});

  /// Executes the Use Case.
  ///
  /// Forwards the [product] and its desired [quantity] to the repository.
  /// Returns a [Future] containing either a [Failure] (e.g., local storage full)
  /// or a successful [Unit] (representing a void return without data).
  Future<Either<Failure, Unit>> call({
    required Product product,
    required int quantity,
  }) async {
    return await repository.addToCart(product: product, quantity: quantity);
  }
}
