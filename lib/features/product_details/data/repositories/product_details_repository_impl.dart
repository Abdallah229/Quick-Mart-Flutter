import 'package:dartz/dartz.dart';
import 'package:quick_mart/core/errors/exceptions/exceptions.dart';
import 'package:quick_mart/core/errors/failures/failures.dart';
import 'package:quick_mart/core/network/network_info.dart';
import 'package:quick_mart/features/product_details/data/datasources/local/product_details_local_data_source.dart';
import 'package:quick_mart/features/product_details/data/datasources/remote/product_details_remote_data_source.dart';
import 'package:quick_mart/features/product_details/domain/entities/detailed_product.dart';
import 'package:quick_mart/features/product_details/domain/repositories/product_details_repository.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  final NetworkInfo networkInfo;
  final ProductDetailsLocalDataSource localDataSource;
  final ProductDetailsRemoteDataSource remoteDataSource;

  ProductDetailsRepositoryImpl({
    required this.networkInfo,
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, DetailedProduct>> getProductDetails(String id) async {
    // If the user is connected to the internet fetch the remote source.
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getProductDetails(id);
        // cache the fetched data:
        await localDataSource.cacheProductDetails(result);
        return Right(result);
      } on ServerException catch (serverError) {
        // --- THE RESCUE MISSION ---
        // The API failed, but maybe we have it cached.
        try {
          final cachedResult = await localDataSource.getCachedProductDetails(
            id,
          );
          return Right(cachedResult);
        } on CacheException {
          // Both the API AND the Cache failed. Now we finally show the error.
          return Left(ServerFailure(message: serverError.errorModel.message));
        }
      }
    }
    // If the user has no internet connection fetch the cached data.
    else {
      try {
        final result = await localDataSource.getCachedProductDetails(id);
        return Right(result);
      } on CacheException {
        return const Left(
          CacheFailure(
            message: 'No local Data found. Please connect to the internet',
          ),
        );
      }
    }
  }
}
