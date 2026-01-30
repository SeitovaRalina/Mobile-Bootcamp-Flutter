import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> images;
  final String? heroTag;
  final ValueChanged<int> onPageChanged;
  final int currentIndex;

  const ImageCarousel({
    super.key,
    required this.images,
    this.heroTag,
    required this.onPageChanged,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            itemCount: images.length,
            onPageChanged: onPageChanged,
            itemBuilder: (context, index) {
              Widget imageWidget = CachedNetworkImage(
                imageUrl: images[index],
                fit: BoxFit.cover,
                placeholder: (_, _) => Container(
                  color: context.colorScheme.surfaceContainerHighest,
                ),
                errorWidget: (_, _, _) =>
                    const Icon(Icons.broken_image, size: 50),
              );
              if (index == 0 && heroTag != null) {
                return Hero(tag: heroTag!, child: imageWidget);
              }
              return imageWidget;
            },
          ),
          if (images.length > 1)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: currentIndex == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: currentIndex == index
                          ? context.colorScheme.primary
                          : context.colorScheme.primary.withValues(alpha: 0.2),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
