import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_bootcamp_example/core/theme/app_colors.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../favorites/presentation/bloc/favorites_bloc.dart';
import '../../../product_details/presentation/product_details_screen.dart';
import '../../domain/entities/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final String contextId;

  const ProductCard({
    required this.product,
    this.contextId = 'home',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final heroTag = 'product_${product.id}_$contextId';
    final colorScheme = context.colorScheme;

    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  ProductDetailsScreen(product: product, heroTag: heroTag),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: heroTag,
                    child: CachedNetworkImage(
                      imageUrl: product.images.first,
                      fit: BoxFit.cover,
                      placeholder: (_, _) =>
                          Container(color: colorScheme.surfaceContainerHighest),
                      errorWidget: (_, _, _) => Icon(Icons.image_outlined),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: BlocSelector<FavoritesBloc, FavoritesState, bool>(
                      selector: (state) {
                        if (state is! FavoritesLoaded) return false;
                        return state.favorites.items.any(
                          (p) => p.id == product.id,
                        );
                      },
                      builder: (context, isFavorite) {
                        return IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? AppColors.favorite : null,
                          ),
                          onPressed: () {
                            context.read<FavoritesBloc>().add(
                              ToggleFavorite(product),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${product.price.toStringAsFixed(2)}",
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
