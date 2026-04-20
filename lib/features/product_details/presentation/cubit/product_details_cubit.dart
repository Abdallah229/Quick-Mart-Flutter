import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_mart/core/enums/request_state.dart';
import 'package:quick_mart/features/product_details/domain/usecases/get_product_details.dart';
import 'package:quick_mart/features/product_details/presentation/cubit/product_details_state.dart';

/// State management controller for the Product Details screen.
///
/// This Cubit handles the business logic for fetching and displaying
/// a specific product's comprehensive details by orchestrating communication
/// between the UI and the domain layer.
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductDetailsUseCase getProductDetailsUseCase;

  /// Initializes the Cubit with the required [GetProductDetailsUseCase]
  /// and sets the initial state.
  ProductDetailsCubit({required this.getProductDetailsUseCase})
    : super(const ProductDetailsState());

  /// Fetches the details for a specific product and updates the state.
  ///
  /// Emits a [RequestState.loading] status initially. Upon completion,
  /// emits either [RequestState.success] with the [DetailedProduct] or
  /// [RequestState.error] with a failure message.
  Future<void> loadProductDetails({required String productID}) async {
    emit(state.copyWith(status: RequestState.loading));

    final result = await getProductDetailsUseCase(
      GetProductDetailsParams(id: productID),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: RequestState.error,
            errorMessage: failure.message,
          ),
        );
      },
      (success) {
        emit(state.copyWith(status: RequestState.success, product: success));
      },
    );
  }
}
