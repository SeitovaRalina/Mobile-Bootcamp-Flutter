import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/cubit/bottom_nav_cubit.dart';
import '../../cart/presentation/bloc/cart_bloc.dart';
import '../../favorites/presentation/bloc/favorites_bloc.dart';
import '../../home/data/models/product_model.dart';

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
          BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
              final isFav = state.items.any((p) => p.id == widget.product.id);
              return IconButton(
                icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                color: isFav ? Colors.red : null,
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
            // Image Carousel
            SizedBox(
              height: 350,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    itemCount: widget.product.images.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentImageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      String imageUrl = widget.product.images[index];
                      // Clean URL if dirty
                      if (imageUrl.startsWith('["')) {
                        imageUrl = imageUrl
                            .replaceAll('["', '')
                            .replaceAll('"]', '')
                            .replaceAll('"', '');
                      }

                      Widget imageWidget = CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, _) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (_, _, _) => const Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      );

                      // Only apply Hero to the first image to avoid tag conflicts or weird behavior during scroll
                      if (index == 0 && widget.heroTag != null) {
                        return Hero(tag: widget.heroTag!, child: imageWidget);
                      }
                      return imageWidget;
                    },
                  ),
                  if (widget.product.images.length > 1)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          widget.product.images.length,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentImageIndex == index
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: Text(widget.product.category.name.toUpperCase()),
                      ),
                      const SizedBox(),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.product.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$${widget.product.price.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              final cartItem = state.items.firstWhere(
                (item) => item.product.id == widget.product.id,
                orElse: () => CartItem(product: widget.product, quantity: 0),
              );

              final isInCart = cartItem.quantity > 0;

              if (!isInCart) {
                return FilledButton.icon(
                  onPressed: () {
                    context.read<CartBloc>().add(AddToCart(widget.product));
                  },
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text("Add to Cart"),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                );
              } else {
                // Split Screen Layout
                return Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () {
                          // Close details screen and switch to Cart tab
                          Navigator.pop(context);
                          context.read<BottomNavCubit>().updateIndex(
                            1,
                          ); // 1 is Cart Index
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        child: const Text("View Cart"),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () => context.read<CartBloc>().add(
                                DecrementItem(widget.product),
                              ),
                              icon: const Icon(Icons.remove),
                            ),
                            SizedBox(
                              width: 30,
                              child: Center(
                                child: Text(
                                  "${cartItem.quantity}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => context.read<CartBloc>().add(
                                IncrementItem(widget.product),
                              ),
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
