import 'package:quick_mart/features/product_details/data/models/detailed_product_model.dart';

/// Contract for fetching rich product data from the backend.
abstract class ProductDetailsRemoteDataSource {
  /// Calls the https://dummyjson.com/products/{id} endpoint.
  ///
  /// Returns a [DetailedProductModel] if the call is successful.
  /// Throws a [ServerException] for all error codes or network failures.
  Future<DetailedProductModel> getProductDetails(String id);
}
