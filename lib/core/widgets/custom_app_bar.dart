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
  });

  final String title;
  final VoidCallback? onTap;
  final AppBarIconType iconType;
  final Color? backgroundColor;
  final TextStyle? titleStyle;

  final bool centerTitle;

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
                  fontSize: 22,
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
        padding: const .symmetric(horizontal: 21, vertical: 15),
        margin: const .only(left: 0),
        decoration: BoxDecoration(
          borderRadius: AppTheme.primaryRadius,
          gradient: AppTheme.primaryGradient,
        ),

        // padding: const EdgeInsets.only(right: 14),
        child: SvgPicture.asset(
          'assets/icons/${iconType.name}.svg',
          width: 20,
          height: 20,
          colorFilter: const ColorFilter.mode(
            AppTheme.textColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
