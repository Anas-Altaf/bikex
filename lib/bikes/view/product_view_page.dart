import 'package:flutter/material.dart';

class ProductViewPage extends StatelessWidget {
  const ProductViewPage({super.key, required this.productId});
  final productId;
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Product View Page'),
    );
  }
}
