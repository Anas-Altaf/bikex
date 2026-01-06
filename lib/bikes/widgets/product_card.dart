import 'package:bikex/bikes/bikes.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Pure, reusable product card widget
/// All state and interactions are passed via props and callbacks
class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteToggle,
    super.key,
  });

  final Product product;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Transform(
        alignment: Alignment.topCenter,
        transform: Matrix4.skewY(-0.15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: AppTheme.primaryBlurFilter,
            child: Container(
              decoration: BoxDecoration(
                gradient: AppTheme.primaryCardGradient,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppTheme.textDescColor.withAlpha(30),
                  width: 0.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.shadowColor.withAlpha(50),
                    blurRadius: 50,
                    offset: const Offset(0, 100),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Container(
                    transform: Matrix4.skewY(0.15),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Hero(
                                  tag: 'product_image_${product.id}',
                                  child: Image.asset(
                                    product.images.isNotEmpty
                                        ? product.images.first
                                        : 'assets/images/cycle_01.png',
                                    fit: BoxFit.contain,
                                    height: 90,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                product.category,
                                style: const TextStyle(
                                  color: AppTheme.textDescColor,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                product.name.toUpperCase(),
                                style: const TextStyle(
                                  color: AppTheme.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '\$${product.price.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: AppTheme.textDescColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Favorite button
                  Positioned(
                    top: 14,
                    right: 14,
                    child: Transform(
                      transform: Matrix4.skewY(0.15),
                      child: FavoriteButton(
                        isFavorite: isFavorite,
                        onTap: onFavoriteToggle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Reusable favorite button widget
class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    required this.isFavorite,
    required this.onTap,
    super.key,
    this.size = 26,
  });

  final bool isFavorite;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          key: ValueKey(isFavorite),
          color: isFavorite ? Colors.red : AppTheme.textColor,
          size: size,
        ),
      ),
    );
  }
}
