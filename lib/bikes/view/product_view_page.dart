import 'package:bikex/bikes/bikes.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ProductViewPage extends StatelessWidget {
  const ProductViewPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    // TODO(dev): Implement product details view.
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          product.name,
          style: const TextStyle(color: AppTheme.textColor),
        ),
      ),
      body: Center(
        child: Hero(
          tag: 'product_image_${product.id}',
          child: Image.asset(
            product.imageAsset ?? 'assets/images/cycle_01.png',
          ),
        ),
      ),
    );
  }
}
