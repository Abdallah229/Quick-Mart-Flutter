import 'package:flutter/cupertino.dart';
import 'package:food_ordering_system/features/product_details/domain/entities/detailed_product.dart';
import 'package:food_ordering_system/features/product_details/presentation/widgets/product_details_image_part.dart';
import 'package:food_ordering_system/features/product_details/presentation/widgets/product_details_info_part.dart';

class ProductDetailsBody extends StatelessWidget {
  final DetailedProduct product;

  const ProductDetailsBody({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
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
