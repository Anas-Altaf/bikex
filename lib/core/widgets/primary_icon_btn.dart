import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PrimaryIconBtn extends StatelessWidget {
  const PrimaryIconBtn({
    this.assetName,
    super.key,
    this.onTap,
    this.backgroundColor,
    this.gradient,
    this.iconColor,
    this.iconWidth,
    this.iconHeight,
    this.replacedWidget,
    this.isSelected = false,
  });

  final VoidCallback? onTap;
  final String? assetName;
  final Color? backgroundColor;
  // gradient
  final LinearGradient? gradient;
  final Color? iconColor;
  final double? iconWidth;
  final double? iconHeight;
  final Widget? replacedWidget;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: ClipRRect(
        borderRadius: AppTheme.primaryRadius,
        // child: BackdropFilter(
        //   filter: AppTheme.primaryBlurFilter,
        child: Container(
          margin: const .symmetric(horizontal: 4),
          padding: const .all(12),
          decoration: BoxDecoration(
            color: backgroundColor,
            gradient: isSelected ? AppTheme.primaryGradient : gradient,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white.withAlpha(10),
            ),
            boxShadow: const [
              // BoxShadow(
              //   offset: Offset(0, 0.2),
              //   blurRadius: 10,
              //   color: Colors.black26,
              // ),
            ],
          ),
          child: assetName == null
              ? replacedWidget
              : SvgPicture.asset(
                  assetName!,
                  width: iconWidth ?? 24,
                  height: iconHeight ?? 24,
                  colorFilter: iconColor != null
                      ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
                      : null,
                ),
        ),
      ),
      // ),
    );
  }
}
