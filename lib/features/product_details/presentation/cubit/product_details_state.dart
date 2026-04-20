import 'package:equatable/equatable.dart';
import 'package:quick_mart/core/enums/request_state.dart';
import 'package:quick_mart/features/product_details/domain/entities/detailed_product.dart';

/// The state representation for the Product Details feature.
///
/// This class holds the data required to render the product details UI.
/// It tracks the current network [status], the fetched [product] data,
/// and any [errorMessage] that might occur during the fetching process.
class ProductDetailsState extends Equatable {
  /// The current execution status (e.g., loading, success, error).
  final RequestState status;

  /// The comprehensive details of the product.
  ///
  /// This is null initially and only populated upon a successful fetch.
  final DetailedProduct? product;

  /// A user-friendly error message. Populated only if [status] is [RequestState.error].
  final String errorMessage;

  /// Creates a [ProductDetailsState] with default idle values.
  const ProductDetailsState({
    this.status = RequestState.initial,
    this.product,
    this.errorMessage = '',
  });

  /// Creates a new instance of the state, copying existing values and
  /// overriding only the specific fields passed in.
  ProductDetailsState copyWith({
    DetailedProduct? product,
    RequestState? status,
    String? errorMessage,
  }) {
    return ProductDetailsState(
      product: product ?? this.product,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [product, status, errorMessage];
}
