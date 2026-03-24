import 'package:flutter/material.dart';
import 'package:food_ordering_system/features/cart/domain/entities/cart_item.dart';
import 'package:food_ordering_system/features/cart/presentation/widgets/cart_list_item.dart';

class CartList extends StatelessWidget {
  const CartList({super.key, required this.items});
  final List<CartItem> items;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context,  index) {
        return CartListItem(item: items[index]);
      },
    );
  }
}
