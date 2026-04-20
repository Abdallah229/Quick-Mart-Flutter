import 'package:equatable/equatable.dart';
import 'package:quick_mart/features/home/domain/entities/product.dart';

/// Represents a single food item added to the user's shopping cart.
///
/// This entity bridges the [Product] from the Menu feature with the specific
/// [quantity] the user intends to order. Extending [Equatable] ensures that
/// if the user adds the same item twice, the BLoC can accurately compare the
/// old cart state with the new cart state to trigger UI updates.
class CartItem extends Equatable {
  /// The specific food item being ordered.
  final Product product;

  /// The number of this specific item the user wishes to purchase.
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  @override
  List<Object?> get props => [product, quantity];
}
