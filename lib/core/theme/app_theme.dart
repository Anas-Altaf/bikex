import 'dart:ui';

import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryUpColor = Color(0xFF37B6E9);
  static const Color primaryDownColor = Color(0xFF4B4CED);
  static const Color secondaryColor = Color(0xFF07131F);
  static const Color backgroundColor = Color(0xFF242C3B);
  static const Color backgroundDeepColor = Color(0xFF222834);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color textDescColor = Color(
    0x99FFFFFF,
  ); // Hex #FFFFFF with 60% opacity
  static const Color shadowColor = Color(0xFF10141C);

  // transparent color
  static const Color transparentColor = Colors.transparent;
  //gradient colors
  static LinearGradient tabBarGradient = const LinearGradient(
    // Gradient flows from top-left to bottom-right.
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,

    // Stop positions (0% and 100%)
    stops: [0.0, 1.0, 1.0],

    colors: [
      Color(0xFF3B49A5),
      Color(0xFF363E51),
      Color(0xFF3B49A5),
    ],
  );

  // primary gradient
  static LinearGradient primaryGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF34C8E8),
      Color(0xFF4E4AF2),
    ],
  ).withOpacity(0.8);

  // primary card gradient
  static LinearGradient primaryCardGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF363E51),
      Color(0xFF191E26),
    ],
  ).withOpacity(0.6);

  // secondary card gradient
  static LinearGradient secondaryCardGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF353F54),
      Color(0xFF222834),
    ],
  ).withOpacity(0.8);

  // Image Blur
  static final ImageFilter primaryBlurFilter = ImageFilter.blur(
    sigmaX: 30,
    sigmaY: 30,
  );
}
