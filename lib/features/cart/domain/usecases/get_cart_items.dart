import 'package:dartz/dartz.dart';
import 'package:food_ordering_system/core/errors/failures/failures.dart';
import 'package:food_ordering_system/features/cart/domain/entities/cart_item.dart';
import 'package:food_ordering_system/features/cart/domain/repositories/cart_repository.dart';

/// Use Case for retrieving all items currently in the user's shopping cart.
///
/// In Clean Architecture, this class encapsulates the single responsibility
/// of fetching the cart state. The Presentation layer (Cart BLoC) will call
/// this Use Case rather than interacting with the [CartRepository] directly,
/// keeping the business logic strictly isolated from state management.
class GetCartItems {
  /// The abstract contract for cart data operations.
  final CartRepository repository;

  /// Constructs the Use Case with necessary dependencies injected.
  ///
  /// Using a `const` constructor is highly recommended for Use Cases as they
  /// are stateless classes, which helps Dart optimize memory usage.
  const GetCartItems({required this.repository});

  /// Executes the Use Case.
  ///
  /// Invokes the repository to fetch the cart data. Returns a [Future]
  /// containing either a [Failure] (if the local cache or network fails)
  /// or a successful `List<CartItem>` representing the current cart.
  Future<Either<Failure, List<CartItem>>> call() async {
    return await repository.getCartItems();
  }
}