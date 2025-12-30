import 'package:bikex/bikes/models/product.dart';
import 'package:bikex/core/constants.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

/// Product image carousel with dots indicator
class ProductImageCarousel extends StatefulWidget {
  const ProductImageCarousel({
    required this.product,
    required this.imageHeight,
    super.key,
  });

  final Product product;
  final double imageHeight;

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.product.images.isNotEmpty
        ? widget.product.images
        : ['assets/images/cycle_01.png'];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Carousel
        SizedBox(
          height: widget.imageHeight,
          width: double.infinity,
          child: CarouselSlider.builder(
            itemCount: images.length,
            itemBuilder: (context, index, realIndex) {
              return Hero(
                tag: 'product_image_${widget.product.id}',
                child: Image.asset(
                  images[index],
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              );
            },
            options: CarouselOptions(
              height: widget.imageHeight,
              viewportFraction: 1,
              enableInfiniteScroll: images.length > 1,
              autoPlay: true,
              autoPlayAnimationDuration: ProductDetailConstants.carouselDuration,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ),

        // Dots indicator
        if (images.length > 1) ...[
          const SizedBox(
            height: ProductDetailConstants.carouselDotsSpacing,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              images.length,
              (index) => Container(
                width: ProductDetailConstants.dotIndicatorSize,
                height: ProductDetailConstants.dotIndicatorSize,
                margin: const EdgeInsets.symmetric(
                  horizontal: ProductDetailConstants.dotIndicatorMargin,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? AppTheme.textColor
                      : AppTheme.textDescColor.withAlpha(80),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
