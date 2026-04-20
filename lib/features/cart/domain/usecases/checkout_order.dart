import 'package:dartz/dartz.dart' hide Order;
import 'package:quick_mart/features/cart/domain/entities/order.dart';
import 'package:quick_mart/core/errors/failures/failures.dart';
import 'package:quick_mart/features/cart/domain/repositories/cart_repository.dart';

/// Use Case for finalizing the current cart and processing the transaction.
///
/// This is one of the most critical business operations in the application.
/// It encapsulates the transition of state from a mutable "Cart" into an
/// immutable "Order". By isolating checkout logic, we create a single point
/// to inject complex processes later, such as payment gateway integrations,
/// applying promo codes, or calculating delivery fees.
class CheckoutOrder {
  /// The abstract contract for cart data operations.
  final CartRepository repository;

  const CheckoutOrder({required this.repository});

  /// Executes the Use Case.
  ///
  /// Triggers the finalization process in the repository. Returns a [Future]
  /// containing either a [Failure] (e.g., network error, payment declined)
  /// or the finalized [Order] entity containing the receipt data.
  Future<Either<Failure, Order>> call() async {
    return await repository.checkout();
  }
}
