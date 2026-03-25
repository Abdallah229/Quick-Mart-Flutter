import 'package:dartz/dartz.dart' hide Order;
import 'package:food_ordering_system/core/errors/exceptions/exceptions.dart';
import 'package:food_ordering_system/core/errors/failures/failures.dart';
import 'package:food_ordering_system/core/network/network_info.dart';
import 'package:food_ordering_system/features/cart/data/datasources/local/cart_local_data_source.dart';
import 'package:food_ordering_system/features/cart/data/datasources/remote/cart_remote_data_source.dart';
import 'package:food_ordering_system/features/cart/domain/entities/cart_item.dart';
import 'package:food_ordering_system/features/cart/domain/entities/order.dart';
import 'package:food_ordering_system/features/cart/domain/repositories/cart_repository.dart';
import 'package:food_ordering_system/features/menu/domain/entities/product.dart';
import 'package:food_ordering_system/features/cart/data/models/order_model.dart';
import 'package:food_ordering_system/features/cart/data/models/cart_item_model.dart';

/// The concrete implementation of [CartRepository].
///
/// This class acts as the single source of truth for the Cart feature.
/// It orchestrates an "offline-first" architecture: all daily cart mutations
/// (adding, updating, removing) are performed instantly against the local
/// Hive cache ([localDataSource]) so the UI never blocks or waits for a network.
/// The remote API ([remoteDataSource]) is only engaged for final operations
/// like [checkout] or fetching a lost cart.
class CartRepositoryImpl implements CartRepository {
  final NetworkInfo networkInfo;
  final CartRemoteDataSource remoteDataSource;
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  /// Helper method to safely grab the active local cart.
  ///
  /// If the user has not added anything yet (resulting in a [CacheException]),
  /// it dynamically generates a fresh, empty [OrderModel] to prevent null errors.
  Future<OrderModel> _getLocalCart() async {
    try {
      return await localDataSource.getCachedCart();
    } on CacheException {
      return OrderModel(
        id: 'local_cart',
        items: const [],
        totalPrice: 0.0,
        date: DateTime.now(),
      );
    }
  }

  /// Adds a new product to the cart or increments its quantity if it already exists.
  ///
  /// This operation runs entirely offline for maximum performance. It reads
  /// the current cart, runs the sorting/math algorithms locally, and overwrites
  /// the cache. Returns a [CacheFailure] if the local database write fails.
  @override
  Future<Either<Failure, Unit>> addToCart({
    required Product product,
    required int quantity,
  }) async {
    try {
      final currentCart = await _getLocalCart();
      final List<CartItem> updatedItems = List.from(currentCart.items);

      // Check if item already exists in the cart
      final existingIndex = updatedItems.indexWhere((item) => item.product.id == product.id);

      if (existingIndex >= 0) {
        // Increase quantity of existing item
        final existingItem = updatedItems[existingIndex];
        updatedItems[existingIndex] = CartItemModel(
          product: existingItem.product,
          quantity: existingItem.quantity + quantity,
        );
      } else {
        // Add brand new item
        updatedItems.add(CartItemModel(product: product, quantity: quantity));
      }

      // Recalculate the cart total
      final double newTotal = updatedItems.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));

      // Save the updated cart to Hive
      final updatedOrder = OrderModel(
        id: currentCart.id,
        items: updatedItems,
        totalPrice: newTotal,
        date: DateTime.now(),
      );
      await localDataSource.saveCart(order: updatedOrder);

      if (await networkInfo.isConnected) {
        // Future implementation: Silently sync with a remote cart API if needed.
      }

      return const Right(unit);
    } on CacheException {
      return const Left(CacheFailure(message: 'Failed to save current item to cart.'));
    }
  }

  /// Submits the final order to the server.
  ///
  /// Requires an active internet connection. It reads the finalized local cart,
  /// simulates sending it to the backend, and upon success, completely clears
  /// the local cache so the user can begin a new order.
  @override
  Future<Either<Failure, Order>> checkout() async {
    if (await networkInfo.isConnected) {
      try {
        final cart = await _getLocalCart();
        if (cart.items.isEmpty) {
          return const Left(CacheFailure(message: 'Cannot checkout an empty cart.'));
        }

        // Future implementation: await remoteDataSource.checkoutCart(cart);

        // Once successful, clear the local cache
        await localDataSource.clearCart();

        return Right(cart);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.errorModel.message));
      } on CacheException {
        return const Left(CacheFailure(message: 'Failed to process your cart.'));
      }
    } else {
      return const Left(NetworkFailure(message: 'You must be connected to the internet to checkout.'));
    }
  }

  /// Retrieves the current list of items in the user's cart.
  ///
  /// Currently relies STRICTLY on the local offline cache (Hive).
  /// We bypass the remote DummyJSON cart endpoint because it returns
  /// mock data that would overwrite the user's actual local selections.
  @override
  Future<Either<Failure, List<CartItem>>> getCartItems() async {
    try {
      // 1. Try to grab the user's saved cart from Hive
      final localCart = await localDataSource.getCachedCart();
      return Right(localCart.items);
    } on CacheException {
      // 2. If Hive throws a CacheException, it just means the box is empty.
      // The user hasn't added any food yet! Return an empty list.
      return const Right([]);
    } catch (e) {
      // 3. A safety net just in case something else goes horribly wrong reading the disk
      return const Left(CacheFailure(message: 'Failed to load your cart.'));
    }
  }

  /// Completely removes a specific product from the cart.
  ///
  /// Executes a local filter against the Hive cache to drop the specified
  /// [productId], recalculates the total price, and saves the new state.
  @override
  Future<Either<Failure, Unit>> removeCartItem({
    required String productId,
  }) async {
    try {
      final currentCart = await _getLocalCart();

      // Filter out the item we want to delete
      final List<CartItem> updatedItems = currentCart.items
          .where((item) => item.product.id != productId)
          .toList();

      final double newTotal = updatedItems.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));

      final updatedOrder = OrderModel(
        id: currentCart.id,
        items: updatedItems,
        totalPrice: newTotal,
        date: DateTime.now(),
      );

      await localDataSource.saveCart(order: updatedOrder);
      return const Right(unit);
    } on CacheException {
      return const Left(CacheFailure(message: 'Failed to remove current item from cart.'));
    }
  }

  /// Directly modifies the quantity of an existing cart item.
  ///
  /// If the [quantity] drops to 0 or below, the item is automatically removed
  /// from the cart. Recalculates the total price and saves offline.
  @override
  Future<Either<Failure, Unit>> updateItemQuantity({
    required Product product,
    required int quantity,
  }) async {
    try {
      final currentCart = await _getLocalCart();
      final List<CartItem> updatedItems = List.from(currentCart.items);

      final existingIndex = updatedItems.indexWhere((item) => item.product.id == product.id);

      if (existingIndex >= 0) {
        if (quantity <= 0) {
          // If they update quantity to 0, just remove it entirely
          updatedItems.removeAt(existingIndex);
        } else {
          updatedItems[existingIndex] = CartItemModel(
            product: product,
            quantity: quantity,
          );
        }
      }

      final double newTotal = updatedItems.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));

      final updatedOrder = OrderModel(
        id: currentCart.id,
        items: updatedItems,
        totalPrice: newTotal,
        date: DateTime.now(),
      );

      await localDataSource.saveCart(order: updatedOrder);
      return const Right(unit);
    } on CacheException {
      return const Left(CacheFailure(message: 'Failed to update item quantity.'));
    }
  }
}