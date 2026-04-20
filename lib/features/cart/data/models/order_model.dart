import 'package:quick_mart/features/cart/domain/entities/order.dart';
import 'package:quick_mart/features/cart/data/models/cart_item_model.dart';

/// The Data Layer representation of a finalized order.
///
/// Extends the pure Domain [Order] entity to handle the serialization and
/// deserialization of complex nested lists (like transforming raw JSON maps
/// into strict [CartItemModel] objects).
class OrderModel extends Order {
  const OrderModel({
    required super.id,
    required super.items,
    required super.totalPrice,
    required super.date,
  });

  /// Safely constructs an [OrderModel] from a raw JSON map.
  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json['id'].toString(),

    // Map the raw dynamic list into our strictly typed CartItemModels
    items: (json['products'] as List)
        .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
        .toList(),

    // Safely handle both ints and doubles from the API
    totalPrice: (json['total'] as num).toDouble(),

    // Placeholder since the DummyJSON carts API doesn't provide dates
    date: DateTime.now(),
  );

  /// Converts the [OrderModel] back into a flattened JSON map.
  Map<String, dynamic> toJson() => {
    // DummyJSON expects the ID as a number, so we safely parse it back
    'id': int.tryParse(id) ?? 0,

    // Map our complex Dart objects back into primitive JSON maps
    'products': items.map((item) {
      // Cast the Domain entity back to our Model to access the toJson method
      return (item as CartItemModel).toJson();
    }).toList(),

    'total': totalPrice,
  };
}
