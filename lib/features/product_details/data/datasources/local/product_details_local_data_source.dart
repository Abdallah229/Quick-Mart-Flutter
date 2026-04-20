import 'package:quick_mart/features/product_details/data/models/detailed_product_model.dart';

/// Contract for managing the local offline cache of detailed products.
abstract class ProductDetailsLocalDataSource {
  /// Retrieves a specific [DetailedProductModel] from the local Hive box
  /// using its [id] as the key.
  ///
  /// Throws a [CacheException] if the item is not found in the local database.
  Future<DetailedProductModel> getCachedProductDetails(String id);

  /// Saves a [DetailedProductModel] to the local Hive box.
  ///
  /// The product's [id] should be used as the database key so it can be
  /// easily retrieved later.
  Future<void> cacheProductDetails(DetailedProductModel productToCache);
}
