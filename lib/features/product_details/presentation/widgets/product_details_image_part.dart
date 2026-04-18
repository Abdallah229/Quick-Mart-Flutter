import 'package:flutter/material.dart';
import 'package:food_ordering_system/core/widgets/loading_indicator.dart';

class ProductDetailsImagePart extends StatefulWidget {
  final List<String> images;
  const ProductDetailsImagePart({super.key, required this.images});

  @override
  State<ProductDetailsImagePart> createState() =>
      _ProductDetailsImagePartState();
}

class _ProductDetailsImagePartState extends State<ProductDetailsImagePart> {
  int _currentIndex = 0;

  void _changeIndex(int index) {
    if (index < 0 || index >= widget.images.length) return;
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return const AspectRatio(
        aspectRatio: 4 / 3, // Maintains a nice rectangle on any screen
        child: Center(
          child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
        ),
      );
    }

    return Column(
      children: [
        // 1. Image Carousel with responsive AspectRatio
        AspectRatio(
          aspectRatio: 4 / 3, // Width is 4, Height is 3. Adjust as needed (e.g., 1/1 for squares)
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length,
            onPageChanged: _changeIndex,
            itemBuilder: (context, index) {
              return Image.network(
                widget.images[index], // Fixed: using index
                fit: BoxFit.contain, // Note: watch out if this crops your food images too much!
                matchTextDirection: true,
                loadingBuilder: (context, child, loadingProgress) {
                  // Fixed: Return the actual image when done loading
                  if (loadingProgress == null) return child;
                  return const Center(child: LoadingIndicator());
                },
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 16),

        // 2. The Indicator Dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.images.length,
                (index) => _buildDot(index: index, ctx: context),
          ),
        ),
      ],
    );
  }

  Widget _buildDot({required int index, required BuildContext ctx}) {
    final theme = Theme.of(ctx);
    final isActive = _currentIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 16 : 8,
      decoration: BoxDecoration(
        color: isActive
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}