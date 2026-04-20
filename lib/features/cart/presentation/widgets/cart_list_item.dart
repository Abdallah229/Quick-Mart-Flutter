import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_mart/features/cart/domain/entities/cart_item.dart';
import 'package:quick_mart/features/cart/presentation/cubit/cart_cubit.dart';

import 'cart_quantity_updating_button.dart';

class CartListItem extends StatelessWidget {
  final CartItem item;
  const CartListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      title: Text(item.product.title),
      subtitle: Text('${item.product.price.toStringAsFixed(2)} \$'),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          item.product.thumbnailURL,
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CartQuantityUpdatingButton(
              icon: item.quantity == 1 ? Icons.delete : Icons.remove,
              iconColor: item.quantity == 1
                  ? theme.colorScheme.error
                  : theme.colorScheme.primary,
              onPress: () {
                if (item.quantity == 1) {
                  context.read<CartCubit>().remove(item.product.id.toString());
                } else {
                  context.read<CartCubit>().updateQuantity(
                    item.product,
                    item.quantity - 1,
                  );
                }
              },
            ),
            Text(
              item.quantity.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            CartQuantityUpdatingButton(
              icon: Icons.add,
              iconColor: theme.colorScheme.primary,
              onPress: () {
                context.read<CartCubit>().updateQuantity(
                  item.product,
                  item.quantity + 1,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
