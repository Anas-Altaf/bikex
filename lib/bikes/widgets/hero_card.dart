import 'dart:ui';
import 'package:bikex/bikes/widgets/diagonal_card_clipper.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: ClipPath(
        clipper: DiagonalCardClipper(),
        child: BackdropFilter(
          filter: AppTheme.primaryBlurFilter,
          child: Container(
            height: 260,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: AppTheme.primaryCardGradient,
              border: Border.all(
                color: Colors.white.withAlpha(40),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(89),
                  blurRadius: 25,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/cycle_01.png',
                    // width: 220,
                  ),
                  const Spacer(),
                  const Text(
                    '30% Off',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
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
