import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_system/core/enums/request_state.dart';
import 'package:food_ordering_system/core/widgets/loading_indicator.dart';
import 'package:food_ordering_system/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:food_ordering_system/features/cart/presentation/cubit/cart_state.dart';
import 'package:food_ordering_system/features/cart/presentation/widgets/cart_app_bar.dart';
import 'package:food_ordering_system/features/cart/presentation/widgets/cart_checkout_button.dart';
import 'package:food_ordering_system/features/cart/presentation/widgets/cart_list.dart';
import 'package:food_ordering_system/features/cart/presentation/widgets/when_cart_error.dart';
import 'package:food_ordering_system/features/cart/presentation/widgets/when_empty_cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CartAppBar(),
      bottomNavigationBar: const CartCheckoutButton(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              switch (state.status) {
                case RequestState.initial:
                  {
                    return const SizedBox.shrink();
                  }
                case RequestState.loading:
                  {
                    return const LoadingIndicator();
                  }
                case RequestState.success:
                  {
                    if (state.items.isEmpty) {
                      return const WhenEmptyCart();
                    } else {
                      return CartList(items: state.items);
                    }
                  }
                case RequestState.error:
                  {
                    return WhenCartError(message: state.errorMessage);
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
