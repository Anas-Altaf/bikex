import 'package:flutter/material.dart';

class ProductViewPage extends StatelessWidget {
  const ProductViewPage({super.key, required this.product});
  final product;

  @override
  Widget build(BuildContext context) {
    // TODO: Implement product details view
    return Center(
      // pending work
      child: Hero(
        tag: 'product_image_${product.id}',
        child: Image.asset('assets/images/cycle_0${(product.id % 4) + 1}.png'),
      ),
    );
  }
}
