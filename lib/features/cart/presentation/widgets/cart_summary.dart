import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/cart_bloc.dart';

class CartSummary extends StatelessWidget {
  final double totalAmount;

  const CartSummary({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.cartTotal,
                  style: context.textTheme.titleLarge,
                ),
                Text(
                  "\$${totalAmount.toStringAsFixed(2)}",
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                final navigator = Navigator.of(context, rootNavigator: true);
                context.read<CartBloc>().add(ClearCart());
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(context.l10n.success),
                    content: Text(context.l10n.cartOrderPlaced),
                    actions: [
                      TextButton(
                        onPressed: () => navigator.pop(),
                        child: Text(context.l10n.ok),
                      ),
                    ],
                  ),
                );
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(context.l10n.cartCheckout),
            ),
          ],
        ),
      ),
    );
  }
}
