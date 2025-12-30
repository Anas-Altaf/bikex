import 'dart:ui';

import 'package:flutter/material.dart';

class DiagonalCardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const radius = 20.0;
    const cut = 40.0; // how much the side is cut

    final path = Path();

    path.moveTo(radius, 0);

    // Top
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(
      size.width,
      0,
      size.width,
      radius,
    );

    // Right side (diagonal cut)
    path.lineTo(size.width, size.height - cut - radius);
    path.quadraticBezierTo(
      size.width,
      size.height - cut,
      size.width - radius,
      size.height - cut,
    );
    path.lineTo(radius, size.height);

    // Bottom
    path.quadraticBezierTo(
      0,
      size.height,
      0,
      size.height - radius,
    );

    // Left
    path.lineTo(0, radius);
    path.quadraticBezierTo(
      0,
      0,
      radius,
      0,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class DiagonalCardBorderPainter extends CustomPainter {
  final double borderWidth;

  DiagonalCardBorderPainter({this.borderWidth = 2.0});

  @override
  void paint(Canvas canvas, Size size) {
    const radius = 20.0;
    const cut = 40.0;

    // Create the path (same as clipper)
    final path = Path();

    path.moveTo(radius, 0);

    // Top
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(
      size.width,
      0,
      size.width,
      radius,
    );

    // Right side (diagonal cut)
    path.lineTo(size.width, size.height - cut - radius);
    path.quadraticBezierTo(
      size.width,
      size.height - cut,
      size.width - radius,
      size.height - cut,
    );
    path.lineTo(radius, size.height);

    // Bottom
    path.quadraticBezierTo(
      0,
      size.height,
      0,
      size.height - radius,
    );

    // Left
    path.lineTo(0, radius);
    path.quadraticBezierTo(
      0,
      0,
      radius,
      0,
    );

    path.close();

    // Create sweeping gradient for the border (top-left light, bottom-right dark)
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = SweepGradient(
      center: Alignment.center,
      startAngle: 0,
      endAngle: 3.14 * 2,
      colors: [
        Colors.black.withAlpha(120), // bottom right most
        Colors.black.withAlpha(20), // Top-right
        Colors.grey.withAlpha(20), // Right-bottom
        Colors.grey.withAlpha(100), // Bottom - dark
        Colors.grey.withAlpha(100), // Bottom-left
        Colors.grey.withAlpha(50), // top bottom
        Colors.black.withAlpha(110), // top right
      ],
      stops: const [0.0, 0.25, 0.4, 0.5, 0.6, 0.75, 1.0],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Widget that combines the clipper with the gradient border
class DiagonalCardWithBorder extends StatelessWidget {
  final Widget child;
  final double borderWidth;

  const DiagonalCardWithBorder({
    super.key,
    required this.child,
    this.borderWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DiagonalCardBorderPainter(borderWidth: borderWidth),
      child: ClipPath(
        clipper: DiagonalCardClipper(),
        child: child,
      ),
    );
  }
}
