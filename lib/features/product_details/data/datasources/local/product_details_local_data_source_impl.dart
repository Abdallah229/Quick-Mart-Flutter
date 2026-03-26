import 'dart:convert';

import 'package:food_ordering_system/core/errors/exceptions/exceptions.dart';
import 'package:food_ordering_system/features/product_details/data/datasources/local/product_details_local_data_source.dart';
import 'package:food_ordering_system/features/product_details/data/models/detailed_product_model.dart';
import 'package:hive/hive.dart';

class ProductDetailsLocalDataSourceImpl
    implements ProductDetailsLocalDataSource {
  final Box<dynamic> box;

  ProductDetailsLocalDataSourceImpl(this.box);

  @override
  Future<void> cacheProductDetails(DetailedProductModel productToCache) async {
    try {
      await box.put(productToCache.id, jsonEncode(productToCache.toJson()));
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<DetailedProductModel> getCachedProductDetails(String id) async {
    try {
      final cachedData = await box.get(id);

      if (cachedData == null) {
        throw CacheException();
      }

      final jsonMap = jsonDecode(cachedData as String) as Map<String, dynamic>;

      return DetailedProductModel.fromJson(jsonMap);
    } catch (e) {
      throw CacheException();
    }
  }
}