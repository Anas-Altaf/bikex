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
