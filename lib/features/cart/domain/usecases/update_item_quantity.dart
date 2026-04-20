import 'package:dartz/dartz.dart';
import 'package:quick_mart/core/errors/failures/failures.dart';
import 'package:quick_mart/features/cart/domain/repositories/cart_repository.dart';
import 'package:quick_mart/features/home/domain/entities/product.dart';

/// Use Case for modifying the quantity of a specific item already in the cart.
///
/// This class handles the exact business logic for quantity adjustments
/// (usually triggered by '+' or '-' buttons in the UI). Keeping this isolated
/// allows the system to easily add validation rules later (e.g., verifying
/// backend stock levels before allowing the quantity to increase).
class UpdateItemQuantity {
  /// The abstract contract for cart data operations.
  final CartRepository repository;

  const UpdateItemQuantity({required this.repository});

  /// Executes the Use Case.
  ///
  /// Forwards the specific [product] and its [newQuantity] to the repository.
  /// Returns a [Future] containing either a [Failure] or a successful [Unit].
  Future<Either<Failure, Unit>> call({
    required Product product,
    required int newQuantity,
  }) async {
    return await repository.updateItemQuantity(
      product: product,
      quantity: newQuantity,
    );
  }
}
