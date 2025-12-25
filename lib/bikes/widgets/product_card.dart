import 'dart:ui';

import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: 200,
        height: 400,
        decoration: BoxDecoration(
          gradient: AppTheme.primaryCardGradient,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
