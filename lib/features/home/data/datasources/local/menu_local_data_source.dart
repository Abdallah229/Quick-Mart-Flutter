import 'package:quick_mart/features/home/data/models/product_model.dart';

abstract class MenuLocalDataSource {
  Future<List<ProductModel>> getCachedMenuItems();
  Future<void> cacheMenuItems({required List<ProductModel> menuToCache});
}
