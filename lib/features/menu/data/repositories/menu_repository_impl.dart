import 'package:dartz/dartz.dart';
import 'package:food_ordering_system/core/errors/exceptions/exceptions.dart';
import 'package:food_ordering_system/core/errors/failures/failures.dart';
import 'package:food_ordering_system/core/network/network_info.dart';
import 'package:food_ordering_system/features/menu/data/datasources/local/menu_local_data_source.dart';
import 'package:food_ordering_system/features/menu/data/datasources/remote/menu_remote_data_source.dart';
import 'package:food_ordering_system/features/menu/domain/entities/product.dart';
import 'package:food_ordering_system/features/menu/domain/repositories/menu_repository.dart';

class MenuRepositoryImpl implements MenuRepository {
  final NetworkInfo networkInfo;
  final MenuLocalDataSource localDataSource;
  final MenuRemoteDataSource remoteDataSource;

  MenuRepositoryImpl({
    required this.networkInfo,
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Product>>> getMenuItems({
    required int page,
    String? categorySlug,
  }) async {
    if (await networkInfo.isConnected) {
      // ONLINE: Fetch from API, cache it, return it.
      try {
        final remoteData = await remoteDataSource.getMenuItems(
          page: page,
          categorySlug: categorySlug,
        );
        // Save the fresh data to Hive!
        await localDataSource.cacheMenuItems(menuToCache: remoteData);
        return Right(remoteData);
      } on ServerException catch (e) {
        // The server is throwing an error (e.g. 500)
        return Left(ServerFailure(message: e.errorModel.message));
      }
    } else {
      // OFFLINE: Fetch from Hive.
      try {
        final localData = await localDataSource.getCachedMenuItems();
        return Right(localData);
      } on CacheException {
        // Hive is empty and the user is offline
        return const Left(
          CacheFailure(
            message: 'No local data found. Please connect to the internet.',
          ),
        );
      }
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchMenuItems({
    required String query,
    required String categorySlug,
  }) async {
    if (await networkInfo.isConnected) {
      // ONLINE: Let the backend handle the search
      try {
        final remoteData = await remoteDataSource.searchMenuItems(query: query);
        final strictData = remoteData.where((product) {
          final matchesTitle = product.title.toLowerCase().contains(
            query.toLowerCase(),
          );
          final matchesCategory =
              categorySlug == 'all' || product.category == categorySlug;
          return matchesTitle && matchesCategory;
        }).toList();

        return Right(strictData);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.errorModel.message));
      }
    } else {
      // OFFLINE: Read the whole cache and filter it locally
      try {
        final localData = await localDataSource.getCachedMenuItems();

        // Ensure the offline search follows the exact same strict rules
        final strictData = localData.where((product) {
          final matchesTitle = product.title.toLowerCase().contains(
            query.toLowerCase(),
          );
          final matchesCategory =
              categorySlug == 'all' || product.category == categorySlug;

          return matchesTitle && matchesCategory;
        }).toList();
        return Right(strictData);
      } on CacheException {
        return const Left(
          CacheFailure(
            message: 'Cannot search while offline with an empty cache.',
          ),
        );
      }
    }
  }
}
