import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:bikex/bikes/widgets/diagonal_card_with_border.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 500),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: DiagonalCardWithBorder(
          borderWidth: 5,
          child: BackdropFilter(
            filter: AppTheme.primaryBlurFilter,
            child: Container(
              height: 260,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryCardGradient,
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
      ),
    );
  }
}
