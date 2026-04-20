import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_mart/core/enums/cart_action.dart';
import 'package:quick_mart/core/enums/request_state.dart';
import 'package:quick_mart/features/cart/domain/usecases/add_to_cart.dart';
import 'package:quick_mart/features/cart/domain/usecases/checkout_order.dart';
import 'package:quick_mart/features/cart/domain/usecases/get_cart_items.dart';
import 'package:quick_mart/features/cart/domain/usecases/remove_cart_item.dart';
import 'package:quick_mart/features/cart/domain/usecases/update_item_quantity.dart';
import 'package:quick_mart/features/cart/presentation/cubit/cart_state.dart';
import 'package:quick_mart/features/home/domain/entities/product.dart';

/// The State Management controller for the Cart feature.
///
/// This Cubit orchestrates the user's shopping experience. It listens to UI
/// interactions (adding, removing, checkout), routes them through the Domain
/// Use Cases to update the local Hive cache or remote backend, and then
/// seamlessly refreshes the UI state to reflect those changes.
class CartCubit extends Cubit<CartState> {
  final GetCartItems getCartItemsUseCase;
  final AddToCart addToCartUseCase;
  final RemoveCartItem removeCartItemUseCase;
  final UpdateItemQuantity updateItemQuantityUseCase;
  final CheckoutOrder checkoutUseCase;

  CartCubit({
    required this.getCartItemsUseCase,
    required this.addToCartUseCase,
    required this.removeCartItemUseCase,
    required this.updateItemQuantityUseCase,
    required this.checkoutUseCase,
  }) : super(const CartState());

  /// Fetches the current active cart from the database.
  ///
  /// This acts as the single source of truth synchronization method. It completely
  /// replaces the current UI state with the fresh data from the Use Case.
  Future<void> getCart() async {
    emit(state.copyWith(status: RequestState.loading));

    final result = await getCartItemsUseCase();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: RequestState.error,
            errorMessage: failure.message,
            lastAction: CartAction.fetch,
          ),
        );
      },
      (cartItems) {
        // Replaces the items entirely to stay perfectly synced with the database
        emit(state.copyWith(status: RequestState.success, items: cartItems));
      },
    );
  }

  /// Adds a new product to the cart or increases its quantity.
  ///
  /// Runs instantly without a loading spinner to keep the UI snappy.
  /// On success, it automatically triggers [getCart] to refresh the visual state.
  Future<void> add(Product product, int quantity) async {
    final result = await addToCartUseCase(product: product, quantity: quantity);

    await result.fold(
      (failure) async {
        // Ensure the fold handler is async to properly emit/await
        emit(
          state.copyWith(
            status: RequestState.error,
            errorMessage: failure.message,
            lastAction: CartAction.add,
          ),
        );
      },
      (_) async {
        // Silently pull the updated database state to refresh the UI
        await getCart();
      },
    );
  }

  /// Completely removes a specific product from the cart.
  Future<void> remove(String productId) async {
    final result = await removeCartItemUseCase(productId: productId);

    await result.fold(
      (failure) async {
        emit(
          state.copyWith(
            status: RequestState.error,
            errorMessage: failure.message,
            lastAction: CartAction.delete,
          ),
        );
      },
      (_) async {
        await getCart();
      },
    );
  }

  /// Directly adjusts the specific quantity of a cart item.
  ///
  /// If the quantity is updated to 0, the backend logic handles removing it entirely.
  Future<void> updateQuantity(Product product, int quantity) async {
    final result = await updateItemQuantityUseCase(
      product: product,
      newQuantity: quantity,
    );

    await result.fold(
      (failure) async {
        emit(
          state.copyWith(
            status: RequestState.error,
            errorMessage: failure.message,
            lastAction: CartAction.update,
          ),
        );
      },
      (_) async {
        await getCart();
      },
    );
  }

  /// Submits the final order to the server and clears the cart on success.
  Future<void> checkoutCart() async {
    emit(state.copyWith(status: RequestState.loading));

    final result = await checkoutUseCase();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: RequestState.error,
            errorMessage: failure.message,
          ),
        );
      },
      (_) {
        // On a successful checkout, we clear the cart items from the screen
        emit(
          state.copyWith(
            items: const [],
            status: RequestState.success,
            lastAction: CartAction.checkout,
          ),
        );
      },
    );
  }
}
