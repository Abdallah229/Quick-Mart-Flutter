import 'package:quick_mart/core/network/api_consumer.dart';
import 'package:quick_mart/core/utils/api_endpoints.dart';
import 'package:quick_mart/features/cart/data/datasources/remote/cart_remote_data_source.dart';
import 'package:quick_mart/features/cart/data/models/order_model.dart';

/// The concrete implementation of [CartRemoteDataSource].
///
/// Handles the actual network requests to the external API using the
/// globally injected [ApiConsumer]. It is responsible for fetching the raw
/// JSON data and passing it to our heavily typed Models for parsing.
class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiConsumer apiConsumer;

  CartRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<OrderModel> getRemoteCart() async {
    // 1. Make the GET request to the centralized endpoint
    final response = await apiConsumer.get(ApiEndpoints.cart);

    // 2. Cast the dynamic response to a Map and parse it into our Model
    return OrderModel.fromJson(response as Map<String, dynamic>);
  }
}
