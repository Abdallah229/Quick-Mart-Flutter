import 'package:equatable/equatable.dart';
import 'package:food_ordering_system/core/enums/cart_action.dart';
import 'package:food_ordering_system/core/enums/request_state.dart';
import 'package:food_ordering_system/features/cart/domain/entities/cart_item.dart';

/// The unified state object for the Cart feature.
///
/// This class dictates exactly what the Cart UI should render at any given moment.
/// It holds the user's selected meals, any error messages from the database,
/// and the current execution status of the Cubit.
class CartState extends Equatable {
  /// The current list of items residing in the user's shopping cart.
  final List<CartItem> items;

  /// The current execution status (e.g., loading, success, error) used to
  /// trigger loading spinners or error snack-bars in the UI.
  final RequestState status;

  /// A human-readable error message, populated only if [status] is [RequestState.error].
  final String errorMessage;

  final CartAction lastAction;

  /// Constructs the state with clean, sensible defaults.
  /// The cart starts completely empty and in an initial, idle status.
  const CartState({
    this.items = const [],
    this.status = RequestState.initial,
    this.errorMessage = '',
    this.lastAction = CartAction.none,
  });

  /// Dynamically calculates the total price of the cart.
  ///
  /// By computing this on the fly whenever the UI requests it, we eliminate
  /// the risk of the total price falling out of sync with the [items] list.
  double get totalPrice {
    return items.fold(
      0.0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  /// Creates a new instance of the state by copying existing values and
  /// overriding only the specific fields passed in.
  ///
  /// This is vital for BLoC/Cubit state management, as emitting a completely
  /// new object is required to trigger a UI rebuild via [Equatable].
  CartState copyWith({
    List<CartItem>? items,
    RequestState? status,
    String? errorMessage,
    CartAction? lastAction,
  }) {
    return CartState(
      items: items ?? this.items,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      lastAction: lastAction ?? CartAction.none,
    );
  }

  @override
  List<Object?> get props => [items, status, errorMessage, lastAction];
}
