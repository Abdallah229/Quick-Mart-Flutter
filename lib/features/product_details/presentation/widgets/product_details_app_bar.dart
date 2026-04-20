import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_mart/core/enums/request_state.dart';
import 'package:quick_mart/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:quick_mart/features/product_details/presentation/cubit/product_details_state.dart';

class ProductDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProductDetailsAppBar({super.key});

  Widget _buildAppBar({String? title, required BuildContext cxt}) {
    final theme = Theme.of(cxt);
    return AppBar(
      title: Text(
        title ?? '',
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        if (state.status == RequestState.success && state.product != null) {
          return _buildAppBar(title: state.product!.title, cxt: context);
        } else if (state.status == RequestState.error ||
            (state.status == RequestState.success && state.product == null)) {
          return _buildAppBar(title: 'Unknown Product', cxt: context);
        } else {
          return _buildAppBar(cxt: context);
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
