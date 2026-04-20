import 'package:quick_mart/features/cart/data/models/order_model.dart';

/// The contract for remote data operations in the Cart feature.
///
/// Abstracting this allows the Data Layer to remain independent of the
/// specific HTTP client or backend structure.
abstract class CartRemoteDataSource {
  /// Fetches the current user's active cart from the remote server.
  ///
  /// Returns a [Future] containing the parsed [OrderModel].
  Future<OrderModel> getRemoteCart();
}
