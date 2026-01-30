import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cubit/bottom_nav_cubit.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../cart/domain/entities/cart_item_model.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../home/domain/entities/product_model.dart';

class BottomCartBar extends StatelessWidget {
  final ProductModel product;

  const BottomCartBar({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocSelector<CartBloc, CartState, int>(
          selector: (state) {
            if (state is! CartLoaded) return 0;
            final cartItem = state.cart.items.firstWhere(
              (item) => item.product.id == product.id,
              orElse: () => CartItemModel(product: product, quantity: 0),
            );
            return cartItem.quantity;
          },
          builder: (context, quantity) {
            if (quantity == 0) {
              return FilledButton.icon(
                onPressed: () {
                  context.read<CartBloc>().add(AddToCart(product));
                },
                icon: const Icon(Icons.shopping_cart),
                label: Text(context.l10n.detailsAddToCart),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
              );
            } else {
              return Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).popUntil((route) => route.isFirst);
                        context.read<BottomNavCubit>().updateIndex(1);
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        side: BorderSide(color: context.colorScheme.primary),
                      ),
                      child: Text(context.l10n.detailsViewCart),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
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
                              RemoveFromCart(product),
                            ),
                            icon: const Icon(Icons.remove),
                          ),
                          SizedBox(
                            width: 30,
                            child: Center(
                              child: Text(
                                "$quantity",
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => context.read<CartBloc>().add(
                              AddToCart(product),
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
    );
  }
}
