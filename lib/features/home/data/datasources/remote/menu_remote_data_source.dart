import 'package:quick_mart/features/home/data/models/product_model.dart';

/// The contract for remote data operations in the Menu feature.
///
/// This interface ensures that the Repository implementation doesn't care
/// if we are using Dio, HTTP, or Firebase under the hood. It only cares
/// that it can call these methods and receive a List of models back.
abstract class MenuRemoteDataSource {
  /// Fetches a paginated list of products from the remote server.
  Future<List<ProductModel>> getMenuItems({
    required int page,
    String? categorySlug,
  });

  /// Queries the remote server for products matching a specific text string.
  Future<List<ProductModel>> searchMenuItems({required String query});
}
