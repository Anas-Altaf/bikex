/// Core application constants
///
/// This file contains shared constants used across the application.
library;

/// Product detail sheet constants
class ProductDetailConstants {
  ProductDetailConstants._();

  // Sheet size constraints
  /// Minimum sheet size (collapsed state) - 13% of screen height
  static const double sheetMinSize = 0.13;
  
  /// Maximum sheet size (expanded state) - 50% of screen height
  static const double sheetMaxSize = 0.5;

  // Icon rotation calculation constants
  /// Base offset for rotation calculation
  static const double rotationBaseOffset = sheetMinSize;
  
  /// Range for rotation calculation (maxSize - minSize)
  static const double rotationRange = sheetMaxSize - sheetMinSize;
  
  /// Maximum rotation angle in degrees
  static const double maxRotationAngle = -90;
  
  /// Minimum rotation angle in degrees
  static const double minRotationAngle = 0;

  // Animation durations
  /// Duration for sheet expand animation
  static const Duration expandDuration = Duration(milliseconds: 100);
  
  /// Duration for sheet collapse animation
  static const Duration collapseDuration = Duration(milliseconds: 300);
  
  /// Duration for image carousel auto-play animation
  static const Duration carouselDuration = Duration(milliseconds: 1000);

  // Layout dimensions
  /// Height of the custom app bar
  static const double appBarHeight = 90;
  
  /// Padding between image and sheet
  static const double imageSheetPadding = 60;
  
  /// Minimum height for product image
  static const double imageMinHeight = 150;
  
  /// Maximum height ratio for product image (relative to available space)
  static const double imageMaxHeightRatio = 0.9;

  // Sheet tolerance for collapse detection
  /// Small tolerance value for comparing sheet positions
  static const double sheetPositionTolerance = 0.01;

  // Carousel dot indicator
  /// Width of carousel dot indicator
  static const double dotIndicatorSize = 6;
  
  /// Horizontal margin between dots
  static const double dotIndicatorMargin = 4;
  
  /// Spacing between carousel and dots
  static const double carouselDotsSpacing = 16;

  // Sheet styling
  /// Border radius for sheet top corners
  static const double sheetBorderRadius = 30;
  
  /// Sheet border width
  static const double sheetBorderWidth = 2;
  
  /// Sheet shadow blur radius
  static const double sheetShadowBlur = 60;
  
  /// Sheet shadow offset
  static const double sheetShadowOffsetY = -20;
  
  /// Sheet shadow alpha value (0-255)
  static const int sheetShadowAlpha = 63;

  // Toggle button styling
  /// Vertical padding for toggle buttons
  static const double toggleButtonPaddingVertical = 10;
  
  /// Toggle button border radius
  static const double toggleButtonBorderRadius = 10;
  
  /// Toggle button shadow blur
  static const double toggleButtonShadowBlur = 4;
  
  /// Toggle button shadow offset
  static const double toggleButtonShadowOffset = 4;
  
  /// Horizontal padding around toggle buttons
  static const double toggleButtonContainerPadding = 40;
  
  /// Spacing between toggle buttons
  static const double toggleButtonSpacing = 30;
  
  /// Top spacing before toggle buttons
  static const double toggleButtonTopSpacing = 35;
  
  /// Bottom spacing after toggle buttons
  static const double toggleButtonBottomSpacing = 35;

  /// Helper method to calculate icon rotation based on sheet size
  static double calculateIconRotation(double sheetSize) {
    return (((sheetSize - rotationBaseOffset) / rotationRange) * 
            maxRotationAngle).clamp(maxRotationAngle, minRotationAngle);
  }

  /// Helper method to calculate image height
  static double calculateImageHeight({
    required double screenHeight,
    required double statusBarHeight,
    required double sheetSize,
  }) {
    final availableHeight = screenHeight - statusBarHeight - appBarHeight;
    final sheetHeight = screenHeight * sheetSize;
    
    return (availableHeight - sheetHeight - imageSheetPadding).clamp(
      imageMinHeight,
      availableHeight * imageMaxHeightRatio,
    );
  }
}

/// Tab selection options for product detail sheet
enum ProductDetailTab {
  /// No tab selected (sheet collapsed)
  none,
  
  /// Description tab selected
  description,
  
  /// Specification tab selected
  specification,
}
