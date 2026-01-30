import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/error_extension.dart';
import 'bloc/cart_bloc.dart';
import 'widgets/cart_summary.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.cartMyCart)),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CartError) {
            return Center(child: Text(state.failure.toMessage(context)));
          }
          if (state is! CartLoaded || state.cart.items.isEmpty) {
            return Center(child: Text(context.l10n.cartEmpty));
          }
          final cart = state.cart;
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: cart.items.length,
                  separatorBuilder: (_, _) => const Divider(),
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return ListTile(
                      leading: SizedBox(
                        width: 50,
                        height: 50,
                        child: CachedNetworkImage(
                          imageUrl: item.product.images.first,
                          fit: BoxFit.cover,
                          errorWidget: (_, _, _) =>
                              const Icon(Icons.image_not_supported_outlined),
                        ),
                      ),
                      title: Text(
                        item.product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        "\$${item.product.price} x ${item.quantity}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => context.read<CartBloc>().add(
                              RemoveFromCart(item.product),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                            child: Center(
                              child: Text(
                                "${item.quantity}",
                                style: context.textTheme.bodyMedium,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () => context.read<CartBloc>().add(
                              AddToCart(item.product),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              CartSummary(totalAmount: cart.totalAmount),
            ],
          );
        },
      ),
    );
  }
}
