import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_mart/core/enums/request_state.dart';
import 'package:quick_mart/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:quick_mart/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:quick_mart/features/product_details/presentation/cubit/product_details_state.dart';

import '../../../../core/utils/show_snack_bar.dart';
import '../../../home/domain/entities/product.dart';

class ProductDetailsAddToCartButton extends StatefulWidget {
  const ProductDetailsAddToCartButton({super.key});

  @override
  State<ProductDetailsAddToCartButton> createState() =>
      _ProductDetailsAddToCartButtonState();
}

class _ProductDetailsAddToCartButtonState
    extends State<ProductDetailsAddToCartButton> {
  int _quantity = 1;
  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        if (state.status == RequestState.success && state.product != null) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    border: Border.all(width: 0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: _quantity > 1 ? _decrementQuantity : null,
                        icon: Icon(
                          Icons.remove,
                          color: _quantity > 1
                              ? theme.colorScheme.primary
                              : null,
                        ),
                      ),
                      Text(
                        _quantity.toString(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      IconButton(
                        onPressed: _incrementQuantity,
                        icon: Icon(Icons.add, color: theme.colorScheme.primary),
                      ),
                    ],
                  ),
                ),
                FilledButton(
                  onPressed: () async {
                    if (context.read<CartCubit>().state.status ==
                        RequestState.loading) {
                      return;
                    }
                    showSnackBar(
                      context: context,
                      description:
                          'Added $_quantity ${state.product!.title} to cart',
                    );
                    await context.read<CartCubit>().add(
                      state.product as Product,
                      1,
                    );
                  },
                  // TODO : implement the styling.
                  style: FilledButton.styleFrom(
                    foregroundColor: theme.colorScheme.onPrimary,
                    backgroundColor: theme.colorScheme.primary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Add'),
                      Text('${_quantity * state.product!.price} EGP'),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
