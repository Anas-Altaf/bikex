import 'package:animate_do/animate_do.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/core/widgets/icon_circle.dart';
import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated map icon using reusable IconCircle
          const IconCircle(icon: Icons.location_on),
          const SizedBox(height: 32),
          // Title
          FadeInUp(
            delay: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 400),
            child: const Text(
              'Find Nearby',
              style: TextStyle(
                color: AppTheme.textColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Description
          FadeInUp(
            delay: const Duration(milliseconds: 400),
            duration: const Duration(milliseconds: 400),
            child: const Text(
              'Discover bikes and shops near you',
              style: TextStyle(
                color: AppTheme.textDescColor,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 32),
          // Coming soon badge
          FadeInUp(
            delay: const Duration(milliseconds: 500),
            duration: const Duration(milliseconds: 400),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.backgroundSurfaceColor,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppTheme.primaryUpColor.withAlpha(50),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Pulse(
                    infinite: true,
                    duration: const Duration(seconds: 2),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppTheme.primaryUpColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Coming Soon',
                    style: TextStyle(
                      color: AppTheme.primaryUpColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
