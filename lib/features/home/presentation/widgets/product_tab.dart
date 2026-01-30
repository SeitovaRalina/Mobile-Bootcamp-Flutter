import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../domain/entities/product_model.dart';
import 'product_card.dart';
import 'promo_carousel.dart';

class ProductTab extends StatelessWidget {
  final List<ProductModel> products;

  const ProductTab({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: PromoCarousel()),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          sliver: SliverToBoxAdapter(
            child: Text(
              context.l10n.homeRecommendedProducts,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  ProductCard(product: products[index], contextId: 'home'),
              childCount: products.length,
            ),
          ),
        ),
      ],
    );
  }
}
