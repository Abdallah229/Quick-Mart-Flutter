import 'package:food_ordering_system/features/menu/data/models/product_model.dart';

abstract class MenuLocalDataSource {
  Future<List<ProductModel>> getCachedMenuItems();
  Future<void> cacheMenuItems({required List<ProductModel> menuToCache});
}
