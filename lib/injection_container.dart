import 'package:dio/dio.dart';
import 'package:food_ordering_system/features/product_details/data/datasources/local/product_details_local_data_source.dart';
import 'package:food_ordering_system/features/product_details/data/datasources/local/product_details_local_data_source_impl.dart';
import 'package:food_ordering_system/features/product_details/data/datasources/remote/product_details_remote_data_source_impl.dart';
import 'package:food_ordering_system/features/product_details/data/repositories/product_details_repository_impl.dart';
import 'package:food_ordering_system/features/product_details/domain/repositories/product_details_repository.dart';
import 'package:food_ordering_system/features/product_details/domain/usecases/get_product_details.dart';
import 'package:food_ordering_system/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:food_ordering_system/core/network/api_consumer.dart';
import 'package:food_ordering_system/core/network/dio_consumer.dart';
import 'package:food_ordering_system/core/network/network_info.dart';
import 'package:food_ordering_system/core/utils/api_endpoints.dart';
import 'package:food_ordering_system/core/utils/hive_boxes.dart';
import 'package:food_ordering_system/features/menu/data/datasources/local/menu_local_data_source_imp.dart';
import 'package:food_ordering_system/features/menu/data/datasources/remote/menu_remote_data_source_imp.dart';
import 'package:food_ordering_system/features/menu/data/datasources/local/menu_local_data_source.dart';
import 'package:food_ordering_system/features/menu/data/datasources/remote/menu_remote_data_source.dart';
import 'package:food_ordering_system/features/menu/data/repositories/menu_repository_impl.dart';
import 'package:food_ordering_system/features/menu/domain/repositories/menu_repository.dart';
import 'package:food_ordering_system/features/menu/domain/usecases/get_menu_items.dart';
import 'package:food_ordering_system/features/menu/domain/usecases/search_menu_items.dart';
import 'package:food_ordering_system/features/menu/presentation/cubit/menu_cubit.dart';
import 'package:food_ordering_system/features/cart/data/datasources/local/cart_local_data_source_impl.dart';
import 'package:food_ordering_system/features/cart/data/datasources/remote/cart_remote_data_source_impl.dart';
import 'package:food_ordering_system/features/cart/data/datasources/local/cart_local_data_source.dart';
import 'package:food_ordering_system/features/cart/data/datasources/remote/cart_remote_data_source.dart';
import 'package:food_ordering_system/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:food_ordering_system/features/cart/domain/repositories/cart_repository.dart';
import 'package:food_ordering_system/features/cart/domain/usecases/add_to_cart.dart';
import 'package:food_ordering_system/features/cart/domain/usecases/checkout_order.dart';
import 'package:food_ordering_system/features/cart/domain/usecases/get_cart_items.dart';
import 'package:food_ordering_system/features/cart/domain/usecases/remove_cart_item.dart';
import 'package:food_ordering_system/features/cart/domain/usecases/update_item_quantity.dart';
import 'package:food_ordering_system/features/cart/presentation/cubit/cart_cubit.dart';

import 'features/product_details/data/datasources/remote/product_details_remote_data_source.dart';

final sl = GetIt.instance; // Service Locator

Future<void> init() async {
  // ===========================================================================
  // ! FEATURES - MENU
  // ===========================================================================

  // 1. Cubit
  sl.registerFactory(
    () => MenuCubit(getMenuItemsUseCase: sl(), searchMenuItemsUseCase: sl()),
  );

  // 2. Use Cases
  sl.registerLazySingleton(() => GetMenuItems(repository: sl()));
  sl.registerLazySingleton(() => SearchMenuItems(repository: sl()));

  // 3. Repository (Bind Implementation to Abstract Contract)
  sl.registerLazySingleton<MenuRepository>(
    () => MenuRepositoryImpl(
      networkInfo: sl(),
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );

  // 4. Data Sources (Bind Implementation to Abstract Contract)
  sl.registerLazySingleton<MenuRemoteDataSource>(
    () => MenuRemoteDataSourceImp(apiConsumer: sl()),
  );

  // FIX: Explicitly request the specific MenuBox instance!
  sl.registerLazySingleton<MenuLocalDataSource>(
    () => MenuLocalDataSourceImp(
      box: sl(instanceName: HiveBoxes.menuBoxInstanceName),
    ),
  );

  // ===========================================================================
  // ! FEATURES - CART
  // ===========================================================================

  // 1. Cubit
  sl.registerFactory(
    () => CartCubit(
      getCartItemsUseCase: sl(),
      addToCartUseCase: sl(),
      removeCartItemUseCase: sl(),
      updateItemQuantityUseCase: sl(),
      checkoutUseCase: sl(),
    ),
  );

  // 2. Use Cases
  sl.registerLazySingleton(() => GetCartItems(repository: sl()));
  sl.registerLazySingleton(() => AddToCart(repository: sl()));
  sl.registerLazySingleton(() => RemoveCartItem(repository: sl()));
  sl.registerLazySingleton(() => UpdateItemQuantity(repository: sl()));
  sl.registerLazySingleton(() => CheckoutOrder(repository: sl()));

  // 3. Repository (Bind Implementation to Abstract Contract)
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // 4. Data Sources (Bind Implementation to Abstract Contract)
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(apiConsumer: sl()),
  );

  // FIX: Explicitly request the specific CartBox instance!
  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(
      box: sl(instanceName: HiveBoxes.cartBoxInstanceName),
    ),
  );
  // ===========================================================================
  // ! FEATURES - PRODUCT DETAILS
  // ===========================================================================
  sl.registerFactory(() => ProductDetailsCubit(getProductDetailsUseCase: sl()));
  sl.registerLazySingleton(() => GetProductDetailsUseCase(repository: sl()));

  sl.registerLazySingleton<ProductDetailsRepository>(
    () => ProductDetailsRepositoryImpl(
      networkInfo: sl(),
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<ProductDetailsRemoteDataSource>(
    () => ProductDetailsRemoteDataSourceImpl(apiConsumer: sl()),
  );

  sl.registerLazySingleton<ProductDetailsLocalDataSource>(
    () => ProductDetailsLocalDataSourceImpl(
      sl(instanceName: HiveBoxes.detailedProductsInstanceName),
    ),
  );
  // ===========================================================================
  // ! CORE
  // ===========================================================================

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

  // ===========================================================================
  // ! EXTERNAL
  // ===========================================================================

  // sl.registerLazySingleton(() => InternetConnection());

  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        receiveDataWhenStatusError: true,
        // 10 seconds is a much safer baseline for varying mobile network speeds
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    return dio;
  });

  // Registering the specific Hive box for our Menu Cache
  final menuBox = Hive.box<dynamic>(HiveBoxes.menuBoxName);
  sl.registerLazySingleton<Box<dynamic>>(
    () => menuBox,
    instanceName: HiveBoxes.menuBoxInstanceName,
  );

  // Registering the specific Hive box for our Cart Cache
  final cartBox = Hive.box<dynamic>(HiveBoxes.cartBoxName);
  sl.registerLazySingleton<Box<dynamic>>(
    () => cartBox,
    instanceName: HiveBoxes.cartBoxInstanceName,
  );

  final detailedProductsBox = Hive.box<dynamic>(
    HiveBoxes.detailedProductsBoxName,
  );
  sl.registerLazySingleton<Box<dynamic>>(
    () => detailedProductsBox,
    instanceName: HiveBoxes.detailedProductsInstanceName,
  );
}
