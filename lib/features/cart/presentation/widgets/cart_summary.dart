import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                const Text(
                  "Total:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "\$${totalAmount.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
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
                    title: const Text("Success"),
                    content: const Text("Order placed successfully!"),
                    actions: [
                      TextButton(
                        onPressed: () => navigator.pop(),
                        child: const Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Checkout"),
            ),
          ],
        ),
      ),
    );
  }
}
