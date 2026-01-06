import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class DiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Left dark side
    final darkPaint = Paint()..color = AppTheme.backgroundColor;

    // Right gradient side
    final gradientPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF34C8E8),
          Color(0xFF4E4AF2),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Draw gradient on right
    final gradientPath = Path()
      ..moveTo(size.width * 1, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * 0.1, size.height)
      ..close();

    canvas
      ..drawRect(Rect.fromLTWH(0, 0, size.width, size.height), darkPaint)
      ..drawPath(gradientPath, gradientPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
