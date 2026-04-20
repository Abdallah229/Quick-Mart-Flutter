import 'package:dartz/dartz.dart' hide Order;
import 'package:quick_mart/core/errors/failures/failures.dart';
import 'package:quick_mart/features/cart/domain/entities/cart_item.dart';
import 'package:quick_mart/features/cart/domain/entities/order.dart';
import 'package:quick_mart/features/home/domain/entities/product.dart';

/// The contract for the Cart Feature's Data Layer.
///
/// This abstract repository defines all the CRUD (Create, Read, Update, Delete)
/// operations required to manage a user's shopping cart and process their final
/// order. The Data Layer will implement this interface to interact with local
/// caching (like Hive) or remote APIs.
abstract class CartRepository {
  /// Retrieves the current list of items in the user's shopping cart.
  ///
  /// Returns a [Future] containing either a [Failure] or the current `List<CartItem>`.
  Future<Either<Failure, List<CartItem>>> getCartItems();

  /// Adds a specific [product] and its desired [quantity] to the cart.
  ///
  /// Uses [Unit] from the `dartz` package instead of `void`. In functional
  /// programming, `void` cannot be passed as a value, but [Unit] acts as an
  /// empty object representing a successful operation with no return data.
  Future<Either<Failure, Unit>> addToCart({
    required Product product,
    required int quantity,
  });

  /// Completely removes a specific item from the cart using its [productId].
  ///
  /// Returns a [Future] containing either a [Failure] or [Unit] on successful deletion.
  Future<Either<Failure, Unit>> removeCartItem({required String productId});

  /// Modifies the existing [quantity] of a specific [product] already in the cart.
  ///
  /// This is typically called when the user taps the '+' or '-' buttons
  /// in the Cart UI. Returns [Unit] upon successful update.
  Future<Either<Failure, Unit>> updateItemQuantity({
    required Product product,
    required int quantity,
  });

  /// Finalizes the current cart and submits it to the backend as an order.
  ///
  /// Returns a [Future] containing either a [Failure] (e.g., payment failed,
  /// item out of stock) or a finalized [Order] receipt entity upon success.
  Future<Either<Failure, Order>> checkout();
}
