import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../domain/entities/category_model.dart';
import '../screens/category_products_screen.dart';

class CategoryTab extends StatelessWidget {
  final List<CategoryModel> categories;

  const CategoryTab({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: categories.length,
      separatorBuilder: (_, _) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final category = categories[index];
        final colorScheme = context.colorScheme;

        return Card(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.8),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryProductsScreen(category: category),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 120,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            category.name,
                            style: context.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            context.l10n.homeExplore,
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: category.image,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        placeholder: (_, _) =>
                            Container(color: colorScheme.surface),
                        errorWidget: (_, _, _) => Icon(
                          Icons.error_outline,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
