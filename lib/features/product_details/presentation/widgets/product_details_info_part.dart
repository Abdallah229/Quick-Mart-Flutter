import 'package:flutter/material.dart';
import 'package:quick_mart/features/product_details/domain/entities/detailed_product.dart';

class ProductDetailsInfoPart extends StatelessWidget {
  final DetailedProduct product;
  const ProductDetailsInfoPart({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(theme),
          const SizedBox(height: 16),
          _buildRatingAndStock(theme),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Divider(height: 1),
          ),
          _buildDescription(theme),
          const SizedBox(height: 24),
          if (product.tags.isNotEmpty) ...[
            _buildTags(theme),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Divider(height: 1),
            ),
          ],

          _buildReviewsSection(theme),
          // Extra padding at the bottom so the content isn't hidden behind the Add To Cart button
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  /// Handles the Title, Brand, and Price
  Widget _buildHeader(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.brand.toUpperCase(),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                product.title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Text(
          '${product.price} \$',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  /// Groups the Star Rating and the Inventory Stock status
  Widget _buildRatingAndStock(ThemeData theme) {
    final bool inStock = product.stock > 0;

    return Row(
      children: [
        Icon(Icons.star_rounded, color: Colors.amber.shade600, size: 24),
        const SizedBox(width: 4),
        Text(
          product.rating.toString(),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '(${product.reviews.length} reviews)',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: inStock
                ? Colors.green.withValues(alpha: 0.1)
                : theme.colorScheme.error.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            inStock ? 'In Stock' : 'Out of Stock',
            style: theme.textTheme.labelMedium?.copyWith(
              color: inStock ? Colors.green.shade700 : theme.colorScheme.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  /// Displays the multiline product description
  Widget _buildDescription(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          product.description,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.6, // Increased line height for modern readability
          ),
        ),
      ],
    );
  }

  /// Displays tags as modern, interactive-looking chips
  Widget _buildTags(ThemeData theme) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: product.tags.map((tag) {
        return Chip(
          label: Text(tag),
          labelStyle: theme.textTheme.bodySmall,
          backgroundColor: theme.colorScheme.surfaceContainerHighest.withValues(
            alpha: 0.5,
          ),
          side: BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
      }).toList(),
    );
  }

  /// Displays the header for the reviews section
  Widget _buildReviewsSection(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Customer Reviews',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            // TODO: Navigate or open bottom sheet
          },
          child: const Text('See All'),
        ),
      ],
    );
  }
}
