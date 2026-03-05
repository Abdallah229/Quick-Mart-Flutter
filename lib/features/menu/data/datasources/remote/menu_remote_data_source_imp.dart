import 'package:food_ordering_system/core/network/api_consumer.dart';
import 'package:food_ordering_system/core/utils/api_endpoints.dart';
import 'package:food_ordering_system/features/menu/data/datasources/remote/menu_remote_data_source.dart';
import 'package:food_ordering_system/features/menu/data/models/product_model.dart';

/// The concrete implementation of [MenuRemoteDataSource].
///
/// This class handles the actual communication with the `dummyjson` API.
/// It utilizes the globally injected [ApiConsumer] to make network calls,
/// extracts the nested `'products'` list from the JSON response, and
/// maps the raw data into our heavily typed [ProductModel]s.
class MenuRemoteDataSourceImp implements MenuRemoteDataSource {
  final ApiConsumer apiConsumer;

  MenuRemoteDataSourceImp({required this.apiConsumer});

  @override
  Future<List<ProductModel>> getMenuItems({required int page}) async {
    // 1. Calculate pagination logic for DummyJSON
    const int limit = 10;
    final int skip = (page - 1) * limit;

    // 2. Make the API call
    final response =
        await apiConsumer.get(
              ApiEndpoints.products,
              queryParameters: {'limit': limit, 'skip': skip},
            )
            as Map<String, dynamic>;

    // 3. Extract the nested list from the JSON map
    final List<dynamic> productsList =
        response[ApiEndpoints.products] as List<dynamic>;

    // 4. Map the raw JSON to our Models
    return productsList
        .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ProductModel>> searchMenuItems({required String query}) async {
    // 1. Make the API call to the specific search endpoint
    final response =
        await apiConsumer.get(
              ApiEndpoints.searchProducts,
              queryParameters: {'q': query},
            )
            as Map<String, dynamic>;

    // 2. Extract the nested list
    final List<dynamic> productsList =
        response[ApiEndpoints.products] as List<dynamic>;

    // 3. Map the raw JSON to our Models
    return productsList
        .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
