import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryUpColor = Color(0xFF37B6E9);
  static const Color primaryDownColor = Color(0xFF4B4CED);
  static const Color secondaryColor = Color(0xFF07131F);
  static const Color backgroundColor = Color(0xFF242C3B);
  static const Color backgroundDeepColor = Color(0xFF222834);
  static const Color textColor = Color(0xFFFFFFFF);
  static const Color textDescColor = Color.fromARGB(153, 255, 255, 255);
  static const Color shadowColor = Color(0xFF10141C);
  //gradient colors
  static LinearGradient tabBarGradient = const LinearGradient(
    // The visual slider in the image suggests a Left-to-Right or Top-to-Bottom flow.
    // Adjust 'begin' and 'end' to match your specific layout direction.
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,

    // Stop positions (0% and 100%)
    stops: [0.0, 1.0],

    colors: [
      Color(0xFF363E51), // Hex: #363E51
      Color(0xFF181C24), // Hex: #181C24
    ],
  ).withOpacity(0.4);

  // primary gradient
  static LinearGradient primaryGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF34C8E8), // Hex: #37B6E9
      Color(0xFF4E4AF2), // Hex: #4B4CED
    ],
  ).withOpacity(0.6);

  // primary card gradient
  static LinearGradient primaryCardGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF363E51), // Hex: #37B6E9
      Color(0xFF191E26), // Hex: #4B4CED
    ],
  ).withOpacity(0.2);
}
