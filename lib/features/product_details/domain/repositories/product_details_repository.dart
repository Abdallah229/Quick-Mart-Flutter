import 'package:dartz/dartz.dart';
import 'package:quick_mart/core/errors/failures/failures.dart';
import 'package:quick_mart/features/product_details/domain/entities/detailed_product.dart';

/// Contract for the Product Details Repository.
///
/// This repository is responsible for fetching the rich details of a single product.
/// It orchestrates the flow of data between the remote API and the local cache
/// to ensure a smooth, offline-capable user experience.
abstract class ProductDetailsRepository {
  /// Fetches a [DetailedProduct] by its unique [id].
  ///
  /// Returns a [Right] containing the [DetailedProduct] on success,
  /// or a [Left] containing a [Failure] (like ServerFailure or CacheFailure) on error.
  Future<Either<Failure, DetailedProduct>> getProductDetails(String id);
}
