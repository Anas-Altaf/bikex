import 'package:animate_do/animate_do.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Reusable animated icon circle widget with gradient and shadow
/// Used consistently across tab pages (Map, Orders, Profile)
class IconCircle extends StatelessWidget {
  const IconCircle({
    required this.icon,
    super.key,
    this.size = 120,
    this.iconSize = 64,
    this.useGradient = true,
    this.animate = true,
  });

  /// The icon to display
  final IconData icon;

  /// Size of the circle container
  final double size;

  /// Size of the icon
  final double iconSize;

  /// Whether to use primary gradient or just opacity color
  final bool useGradient;

  /// Whether to animate the icon on entry
  final bool animate;

  @override
  Widget build(BuildContext context) {
    final circle = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: useGradient ? AppTheme.primaryGradient : null,
        color: useGradient ? null : AppTheme.primaryUpColor.withAlpha(30),
        shape: BoxShape.circle,
        boxShadow: useGradient
            ? [
                BoxShadow(
                  color: AppTheme.primaryUpColor.withAlpha(80),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ]
            : null,
      ),
      child: Icon(
        icon,
        size: iconSize,
        color: useGradient ? Colors.white : AppTheme.primaryUpColor,
      ),
    );

    if (animate) {
      return ElasticIn(
        duration: const Duration(milliseconds: 800),
        child: circle,
      );
    }

    return circle;
  }
}
