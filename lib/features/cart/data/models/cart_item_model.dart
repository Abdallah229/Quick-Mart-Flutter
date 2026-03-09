import 'package:food_ordering_system/features/cart/domain/entities/cart_item.dart';
import 'package:food_ordering_system/features/menu/data/models/product_model.dart';

/// The Data Layer representation of a single item in the shopping cart.
///
/// Extends the pure Domain [CartItem] entity to add JSON serialization.
/// Handles the specific quirk of the external API where product details
/// and cart details (like quantity) are flattened into a single JSON object.
class CartItemModel extends CartItem {
  const CartItemModel({
    required super.product,
    required super.quantity,
  });

  /// Safely constructs a [CartItemModel] from a raw JSON map.
  ///
  /// Extracts the cart-specific `quantity` and delegates the rest of the
  /// parsing to [ProductModel.fromJson] using the exact same JSON map.
  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
    product: ProductModel.fromJson(json),
    quantity: json['quantity'] as int,
  );

  /// Converts the [CartItemModel] back into a flattened JSON map.
  ///
  /// Flattens the nested [Product] entity properties back out to match
  /// the expected structure of the remote API and local Hive cache.
  Map<String, dynamic> toJson() => {
    'title': product.title,
    'price': product.price,
    'thumbnail': product.thumbnailURL,
    'id': product.id,
    'rating': product.rating,
    'quantity': quantity,
  };
}