import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/theme/app_colors.dart';
import '../../favorites/presentation/bloc/favorites_bloc.dart';
import '../../home/domain/entities/product_model.dart';
import 'widgets/bottom_cart_bar.dart';
import 'widgets/image_carousel.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;
  final String? heroTag;

  const ProductDetailsScreen({required this.product, this.heroTag, super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocSelector<FavoritesBloc, FavoritesState, bool>(
            selector: (state) {
              if (state is! FavoritesLoaded) return false;
              return state.favorites.items.any(
                (p) => p.id == widget.product.id,
              );
            },
            builder: (context, isFavorite) {
              return IconButton(
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                color: isFavorite ? AppColors.favorite : null,
                onPressed: () {
                  context.read<FavoritesBloc>().add(
                    ToggleFavorite(widget.product),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageCarousel(
              images: widget.product.images,
              heroTag: widget.heroTag,
              onPageChanged: (index) =>
                  setState(() => _currentImageIndex = index),
              currentIndex: _currentImageIndex,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Chip(label: Text(widget.product.category.name.toUpperCase())),
                  const SizedBox(height: 16),
                  Text(
                    widget.product.title,
                    style: context.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$${widget.product.price.toStringAsFixed(2)}",
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    context.l10n.detailsDescription,
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: context.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomCartBar(product: widget.product),
    );
  }
}
