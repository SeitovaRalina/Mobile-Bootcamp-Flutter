import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex == index
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
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
