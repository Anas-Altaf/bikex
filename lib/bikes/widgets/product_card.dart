import 'dart:ui';

import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final isLeft = index.isEven;
    return Transform.translate(
      offset: Offset(0, isLeft ? 25 : 0),
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
                  color: AppTheme.textDescColor.withAlpha(50),
                  width: 0.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(50),
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
                        const SizedBox(height: 10), // Space for the icon
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Hero(
                                  tag: 'product_image_$index',
                                  child: Image.asset(
                                    'assets/images/cycle_0${(index % 4) + 1}.png',
                                    fit: BoxFit.cover,
                                    height: 90,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'Category ${index % 4 + 1}',
                                style: const TextStyle(
                                  color: AppTheme.textDescColor,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                'Product Name '.toUpperCase(),
                                style: const TextStyle(
                                  color: AppTheme.textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '\$ ${(index % 4 + 1) * 10}.99',
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
                  Positioned(
                    top: 14,
                    right: 14,
                    child: Transform(
                      transform: Matrix4.skewY(0.15),
                      child: GestureDetector(
                        onTap: () {
                          //TODO: Implement favorite functionality
                        },
                        child: Icon(
                          Icons.favorite_border,
                          color: isLeft
                              ? AppTheme.primaryUpColor
                              : AppTheme.textColor,
                          size: 26,
                        ),
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
