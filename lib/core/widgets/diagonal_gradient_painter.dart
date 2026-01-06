import 'package:flutter/material.dart';

/// CustomPainter for diagonal gradient background shape
/// Replicates the SVG: M242.5 167.5L322 0L393.5 59.5V720.5L-20 705L242.5 167.5Z
class DiagonalGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF37B6E9), // primaryUpColor
          Color(0xFF4B4CED), // primaryDownColor
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Scale the SVG coordinates to screen size
    // Original SVG: 390x695, path starts from top-right corner
    final scaleX = size.width / 390;
    final scaleY = size.height / 695;

    // Offset to push down like original (transform: Matrix4.translationValues(0, 75, 0))
    const offsetY = 140.0;

    final path = Path()
      // Start point: 242.5, 167.5
      ..moveTo(242.5 * scaleX, 167.5 * scaleY + offsetY)
      // Line to: 322, 0
      ..lineTo(322 * scaleX, 0 * scaleY + offsetY)
      // Line to: 393.5, 59.5 (right edge)
      ..lineTo(393.5 * scaleX, 59.5 * scaleY + offsetY)
      // Line to: 393.5, 720.5 (bottom right)
      ..lineTo(393.5 * scaleX, 720.5 * scaleY + offsetY)
      // Line to: -20, 705 (bottom left)
      ..lineTo(-20 * scaleX, 600 * scaleY + offsetY)
      // Close back to start
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
