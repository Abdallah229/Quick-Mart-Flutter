import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quick_mart/features/product_details/domain/entities/detailed_product.dart';
import 'package:quick_mart/features/product_details/domain/repositories/product_details_repository.dart';
import '../../../../core/errors/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';

/// Use case for retrieving the comprehensive details of a specific product.
///
/// This class encapsulates the business rule for fetching product details,
/// abstracting the data retrieval process away from the presentation layer.
class GetProductDetailsUseCase
    implements UseCase<DetailedProduct, GetProductDetailsParams> {
  final ProductDetailsRepository repository;

  /// Constructs the [GetProductDetailsUseCase] with a required [ProductDetailsRepository].
  const GetProductDetailsUseCase({required this.repository});

  /// Executes the use case to fetch product details.
  ///
  /// [params] encapsulates the required parameters, specifically the product ID.
  /// Returns an [Either] containing a [Failure] on the left if the operation
  /// fails, or the requested [DetailedProduct] on the right upon success.
  @override
  Future<Either<Failure, DetailedProduct>> call(
    GetProductDetailsParams params,
  ) async {
    return await repository.getProductDetails(params.id);
  }
}

/// Encapsulates the parameters required by [GetProductDetailsUseCase].
///
/// Utilizing a parameters class ensures that the [UseCase] signature remains
/// stable even if additional parameters (e.g., language code, caching flags)
/// are required in the future.
class GetProductDetailsParams extends Equatable {
  final String id;

  const GetProductDetailsParams({required this.id});

  @override
  List<Object?> get props => [id];
}
