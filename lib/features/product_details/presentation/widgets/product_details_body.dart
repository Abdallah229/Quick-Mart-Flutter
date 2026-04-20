import 'package:flutter/material.dart';
import 'package:quick_mart/features/product_details/domain/entities/detailed_product.dart';
import 'package:quick_mart/features/product_details/presentation/widgets/product_details_image_part.dart';
import 'package:quick_mart/features/product_details/presentation/widgets/product_details_info_part.dart';
import '../../../../core/widgets/responsive_layout.dart';

class ProductDetailsBody extends StatelessWidget {
  final DetailedProduct product;

  const ProductDetailsBody({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isTablet = ResponsiveLayout.isTablet(context) || ResponsiveLayout.isDesktop(context);

    if (isTablet) {
      // TABLET DESIGN: Independent Scrolling
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: ProductDetailsImagePart(images: product.images),
            ),
            const SizedBox(width: 32),
            Expanded(
              flex: 6,
              child: SingleChildScrollView(
                child: ProductDetailsInfoPart(product: product),
              ),
            ),
          ],
        ),
      );
    } else {
      // MOBILE DESIGN
      return SingleChildScrollView(
        child: Column(
          children: [
            ProductDetailsImagePart(images: product.images),
            const SizedBox(height: 16),
            ProductDetailsInfoPart(product: product),
          ],
        ),
      );
    }
  }
}