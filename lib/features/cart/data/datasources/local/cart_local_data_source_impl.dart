import 'package:food_ordering_system/core/errors/exceptions/exceptions.dart';
import 'package:food_ordering_system/features/cart/data/datasources/local/cart_local_data_source.dart';
import 'package:food_ordering_system/features/cart/data/models/order_model.dart';
import 'package:hive/hive.dart';

/// The concrete implementation of [CartLocalDataSource] using Hive.
///
/// This acts as a dumb storage mechanism. It holds the user's active
/// cart state offline so they don't lose their selected meals if they
/// close the app or lose internet connection.
class CartLocalDataSourceImpl implements CartLocalDataSource {
  final Box<dynamic> box;

  CartLocalDataSourceImpl({required this.box});

  @override
  Future<void> clearCart() async {
    try {
      await box.clear();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<OrderModel> getCachedCart() {
    try {
      if (box.isEmpty) {
        throw CacheException();
      }

      // 1. Grab the single active cart from the box
      final cachedData = box.values.first;

      // 2. Safely cast the dynamic Hive map to a String map
      final jsonMap = Map<String, dynamic>.from(cachedData as Map);

      // 3. Return the parsed Model
      return Future.value(OrderModel.fromJson(jsonMap));
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> saveCart({required OrderModel order}) async {
    try {
      // 1. Clear the box to ensure we don't accidentally store multiple carts
      await box.clear();

      // 2. Save the primitive JSON map to Hive, NOT the Dart object!
      await box.put(order.id, order.toJson());
    } catch (e) {
      throw CacheException();
    }
  }
}