import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_mart/core/enums/request_state.dart';
import 'package:quick_mart/core/widgets/loading_indicator.dart';
import 'package:quick_mart/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:quick_mart/features/product_details/presentation/cubit/product_details_state.dart';
import 'package:quick_mart/features/product_details/presentation/widgets/product_details_add_to_cart_button.dart';
import 'package:quick_mart/features/product_details/presentation/widgets/product_details_app_bar.dart';
import 'package:quick_mart/features/product_details/presentation/widgets/product_details_body.dart';
import 'package:quick_mart/features/product_details/presentation/widgets/product_details_image_part.dart';
import 'package:quick_mart/features/product_details/presentation/widgets/when_empty_product_details.dart';
import 'package:quick_mart/features/product_details/presentation/widgets/when_product_details_error.dart';

import '../../../../injection_container.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String productID;
  const ProductDetailsScreen({super.key, required this.productID});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          sl<ProductDetailsCubit>()..loadProductDetails(productID: productID),
      child: Scaffold(
        bottomNavigationBar: const ProductDetailsAddToCartButton(),
        appBar: const ProductDetailsAppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 8.0,
            ),
            child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, state) {
                switch (state.status) {
                  case RequestState.loading:
                    {
                      return const LoadingIndicator();
                    }
                  case RequestState.error:
                    {
                      return WhenProductDetailsError(
                        errorMessage: state.errorMessage,
                      );
                    }
                  case RequestState.success:
                    {
                      if (state.product == null) {
                        return const WhenEmptyProductDetails();
                      } else {
                        return ProductDetailsBody(product: state.product!);
                      }
                    }
                  case RequestState.initial:
                    {
                      return const WhenEmptyProductDetails();
                    }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
