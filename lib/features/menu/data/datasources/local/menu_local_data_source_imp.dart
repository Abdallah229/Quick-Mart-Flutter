import 'package:food_ordering_system/core/errors/exceptions/exceptions.dart';
import 'package:food_ordering_system/features/menu/data/datasources/local/menu_local_data_source.dart';
import 'package:food_ordering_system/features/menu/data/models/product_model.dart';
import 'package:hive/hive.dart';

/// The concrete implementation of [MenuLocalDataSource] using Hive.
///
/// This acts as a local NoSQL database specifically for Menu Items.
/// It stores each product using its unique `id` as the database key,
/// and its JSON representation as the value.
class MenuLocalDataSourceImp implements MenuLocalDataSource {
  // We use a generic Box. Hive casts maps to Map<dynamic, dynamic> internally,
  // so we handle the strict typing during the read/write process.
  final Box <dynamic> box;

  const MenuLocalDataSourceImp({required this.box});

  @override
  Future<List<ProductModel>> getCachedMenuItems() {
    try {
      // 1. If the box is empty, throw an exception so the Repository
      // knows it MUST fetch from the remote API instead.
      if (box.isEmpty) {
        throw CacheException();
      }

      // 2. Grab all values from the box synchronously.
      final List<ProductModel> result = box.values.map((item) {
        // 3. Fix the Hive Map gotcha by safely casting dynamic to String keys
        final jsonMap = Map<String, dynamic>.from(item as Map);
        return ProductModel.fromJson(jsonMap);
      }).toList();

      // 4. Wrap the result in a Future to satisfy the interface
      return Future.value(result);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheMenuItems({required List<ProductModel> menuToCache}) async {
    try {
      // 1. Clear the old cache first to prevent stale items from persisting
      await box.clear();

      // 2. Prepare a Map where Key = Product ID, and Value = JSON
      final Map<String, Map<String, dynamic>> itemsMap = {};
      for (var item in menuToCache) {
        itemsMap[item.id] = item.toJson();
      }

      // 3. Save everything to the database in one single, efficient operation
      await box.putAll(itemsMap);
    } catch (e) {
      throw CacheException();
    }
  }
}