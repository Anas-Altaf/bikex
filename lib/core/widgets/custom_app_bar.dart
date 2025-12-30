import 'dart:math';

import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/core/types/enums.dart';
import 'package:bikex/core/widgets/primary_icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Reusable custom app bar widget
/// Use this for all app bars across the app
///
///
///
///
/// Icon Types Enum
/// back, down, search, cross

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    required this.title,
    super.key,
    this.iconType = AppBarIconType.back,
    this.titleStyle,
    this.onTap,
    this.centerTitle = false,
    this.backgroundColor = AppTheme.backgroundColor,
    this.iconRoation = 0,
  });

  final String title;
  final VoidCallback? onTap;
  final AppBarIconType iconType;
  final Color? backgroundColor;
  final TextStyle? titleStyle;

  final bool centerTitle;
  final double? iconRoation;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          if (iconType != AppBarIconType.search) appBarIcon(),

          Text(
            title,
            style:
                titleStyle ??
                const TextStyle(
                  color: AppTheme.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      actions: iconType == .search
          ? [
              appBarIcon(),
            ]
          : null,
      backgroundColor: AppTheme.transparentColor,
      elevation: 0,
    );
  }

  Widget appBarIcon() {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: iconType == AppBarIconType.search
            ? const .symmetric(horizontal: 12, vertical: 12)
            : const .symmetric(horizontal: 17, vertical: 12),
        margin: iconType == AppBarIconType.search
            ? const EdgeInsets.only(right: 20)
            : EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: .circular(10),
          gradient: AppTheme.primaryGradient,
        ),

        child: Transform.rotate(
          angle: iconRoation! * pi / 180,
          child: SvgPicture.asset(
            'assets/icons/${iconType.name}.svg',
            width: 18,
            height: 18,
            colorFilter: const ColorFilter.mode(
              AppTheme.textColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
