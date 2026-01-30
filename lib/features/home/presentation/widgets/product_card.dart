import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                ProductDetailsScreen(product: product, heroTag: heroTag),
          ),
        );
      },
      child: Card(
        elevation: 2,
        clipBehavior: Clip.antiAlias,
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
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (_, _, _) => const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
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
                            color: isFavorite ? Colors.red : Colors.grey,
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
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${product.price.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
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
