import 'dart:ui';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';

class AppTheme {
  // ------------------
  static const Color primaryUpColor = Color(0xFF37B6E9);
  static const Color primaryColor = Color(0xFF4091ED);
  static const Color primaryDownColor = Color(0xFF4B4CED);
  static const Color secondaryColor = Color(0xFF07131F);
  static const Color backgroundColor = Color(0xFF242C3B);
  static const Color backgroundDeepColor = Color(0xFF28303F);
  static const Color backgroundSurfaceColor = Color(0xFF323B4F);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color textDescColor = Color(0x99FFFFFF);
  static const Color borderColor01 = Color(0xFF2D3749);
  static const Color shadowColor = Color(0xFF10141C);
  static const Color sheetCardColor = Color(0xFF1F2633);
  // sheet border color
  static const Color sheetBorderColor = Color(0xFF3A455B);

  // transparent color
  static const Color transparentColor = Colors.transparent;
  //gradient colors
  static LinearGradient tabBarGradient = const LinearGradient(
    // Gradient flows from top-left to bottom-right.
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,

    // Stop positions (0% and 100%)
    stops: [0.0, 1.0],

    colors: [
      Color(0xFF3D476E),
      Color(0xFF2C3368),
      // Color(0xFF3B49A5),
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
  // primary gradient 2
  static LinearGradient primaryGradient2 = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF34C8E8),
      Color(0xFF4E4AF2),
    ],
  );
  // primary card gradient
  static LinearGradient primaryCardGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
    colors: [
      Color(0xFF3D4A64),
      Color(0xFF222834),
    ],
  ).withOpacity(0.6);
  // CartCardGradient
  static LinearGradient cartCardGradient = const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [0.0, 1.0],
    colors: [
      Color(0xFF4C5770),
      Color(0xFF363E51),
    ],
  );
  // secondary card gradient
  static LinearGradient secondaryCardGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF353F54),
      Color(0xFF222834),
    ],
  ).withOpacity(0.6);
  // sheet Gradient
  static LinearGradient sheetGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF353F54),
      Color(0xFF222834),
    ],
  );
  // Black and White Border Gradient
  static LinearGradient blackAndWhiteBorderGradient = const LinearGradient(
    stops: [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF000000),
      Color(0xFFFFFFFF),
    ],
  ).withOpacity(0.2);

  // Border gradient 01
  static LinearGradient borderGradient01 = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF34C8E8),
      Color(0xFF4E4AF2),
    ],
  );
  // Image Blur
  static final ImageFilter primaryBlurFilter = ImageFilter.blur(
    sigmaX: 40,
    sigmaY: 40,
  );

  // Radius
  static const BorderRadius primaryRadius = BorderRadius.all(
    Radius.circular(12),
  );

  // cart Page Box decorations with depth shadows
  static final boxDecoration01 = BoxDecoration(
    color: AppTheme.backgroundColor,
    borderRadius: BorderRadius.circular(8),
    boxShadow: const [
      BoxShadow(
        color: Color(0xFF191E29),
        offset: Offset(4, 10),
        blurRadius: 30,
        spreadRadius: 0,
        inset: true,
      ),
      BoxShadow(
        color: Color(0xFF191E29),
        offset: Offset(4, 4),
        blurRadius: 10,
        spreadRadius: 0,
        inset: true,
      ),
    ],
  );
}
