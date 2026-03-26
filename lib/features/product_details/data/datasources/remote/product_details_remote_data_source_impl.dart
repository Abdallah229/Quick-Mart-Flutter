import 'package:food_ordering_system/core/network/api_consumer.dart';
import 'package:food_ordering_system/core/utils/api_endpoints.dart';
import 'package:food_ordering_system/features/product_details/data/datasources/remote/product_details_remote_data_source.dart';
import 'package:food_ordering_system/features/product_details/data/models/detailed_product_model.dart';

class ProductDetailsRemoteDataSourceImpl
    implements ProductDetailsRemoteDataSource {
  final ApiConsumer apiConsumer;

  ProductDetailsRemoteDataSourceImpl({required this.apiConsumer});
  @override
  Future<DetailedProductModel> getProductDetails(String id) async {
    final response = await apiConsumer.get(
      '${ApiEndpoints.baseUrl}products/$id',
    );
    return DetailedProductModel.fromJson(response as Map<String, dynamic>);
  }
}
