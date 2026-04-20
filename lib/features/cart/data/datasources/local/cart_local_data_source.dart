import 'package:quick_mart/features/cart/data/models/order_model.dart';

/// The contract for local data operations in the Cart feature.
///
/// This interface defines how the application interacts with local device storage
/// (e.g., a Hive database) to manage the user's active shopping cart.
/// By keeping the cart cached locally, the app ensures an "offline-first"
/// experience, preventing data loss if the app is closed or connectivity drops.
abstract class CartLocalDataSource {
  /// Retrieves the currently active cart from local storage.
  ///
  /// Returns a [Future] containing the locally cached [OrderModel].
  /// Throws a [CacheException] if the local storage is empty.
  Future<OrderModel> getCachedCart();

  /// Persists the current state of the cart to local storage.
  ///
  /// Takes the updated [order] and overwrites any previously saved cart data.
  Future<void> saveCart({required OrderModel order});

  /// Completely removes the cart data from local storage.
  ///
  /// This is typically triggered to wipe the database clean immediately
  /// after a successful checkout or when manually clearing the cart.
  Future<void> clearCart();
}
