import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Reusable custom app bar widget
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    required this.title,
    super.key,
    this.leftIcon,
    this.rightIcon,
    this.onLeftTap,
    this.onRightTap,
    this.iconDecoration,
    this.backgroundColor,
    this.titleStyle,
  });

  final String title;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final VoidCallback? onLeftTap;
  final VoidCallback? onRightTap;

  /// Shared decoration for both icons
  final BoxDecoration? iconDecoration;
  final Color? backgroundColor;
  final TextStyle? titleStyle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leftIcon != null
          ? _buildIconButton(
              icon: leftIcon!,
              onTap: onLeftTap,
            )
          : null,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: titleStyle ??
            const TextStyle(
              color: AppTheme.textColor,
              fontWeight: FontWeight.w700,
            ),
      ),
      actions: rightIcon != null
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: _buildIconButton(
                  icon: rightIcon!,
                  onTap: onRightTap,
                ),
              ),
            ]
          : null,
      backgroundColor: backgroundColor ?? AppTheme.backgroundColor,
      elevation: 0,
    );
  }

  Widget _buildIconButton({
    required Widget icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: iconDecoration,
        child: icon,
      ),
    );
  }
}
