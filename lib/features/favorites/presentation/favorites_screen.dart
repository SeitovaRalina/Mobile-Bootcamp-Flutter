import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/presentation/widgets/product_card.dart';
import 'bloc/favorites_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FavoritesError) {
            return Center(child: Text(state.message));
          }
          if (state is! FavoritesLoaded || state.favorites.items.isEmpty) {
            return const Center(child: Text("No favorites yet"));
          }
          final items = state.favorites.items;
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ProductCard(product: items[index], contextId: 'favorites');
            },
          );
        },
      ),
    );
  }
}
