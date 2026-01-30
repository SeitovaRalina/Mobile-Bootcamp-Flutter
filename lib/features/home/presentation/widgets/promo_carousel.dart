import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extension.dart';
import '../../../../resources/app_images.dart';

class PromoCarousel extends StatefulWidget {
  const PromoCarousel({super.key});

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> _promoImages = [
    AppImages.promo1,
    AppImages.promo2,
    AppImages.promo3,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _promoImages.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: context.colorScheme.surfaceContainerHighest,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    _promoImages[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, _, _) => Icon(
                      Icons.image_outlined,
                      size: 50,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _promoImages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == index ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentIndex == index
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
