import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/extensions/error_extension.dart';
import '../../domain/entities/category_model.dart';
import '../bloc/home_bloc.dart';
import '../widgets/product_card.dart';

class CategoryProductsScreen extends StatelessWidget {
  final CategoryModel category;

  const CategoryProductsScreen({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeBloc>()..add(SelectCategory(category)),
      child: Scaffold(
        appBar: AppBar(title: Text(category.name)),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: AppColors.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.failure.toMessage(context),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<HomeBloc>().add(
                        SelectCategory(category),
                      ),
                      child: Text(context.l10n.retry),
                    ),
                  ],
                ),
              );
            } else if (state is HomeLoaded) {
              if (state.products.isEmpty) {
                return Center(
                  child: Text(context.l10n.homeNoProductsInCategory),
                );
              }
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: state.products[index],
                    contextId: 'category_${category.id}',
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
