import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/core/widgets/primary_icon_btn.dart';
import 'package:flutter/material.dart';

class LadderRow extends StatelessWidget {
  LadderRow({super.key});

  // 1. You just provide the list of icons/widgets
  final items = [
    'all',
    'bolt',
    'road',
    'rects',
    'helmet',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          final index = items.indexOf(item);
          return Padding(
            padding: EdgeInsets.only(
              bottom: index * 15.0, // The "Step" height
              // left: 5, // Spacing between items
            ),
            child: index == 0
                ? PrimaryIconBtn(
                    // isSelected: true,
                    replacedWidget: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        'All',
                        style: TextStyle(
                          color: AppTheme.textDescColor,
                          // fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    gradient: AppTheme.secondaryCardGradient,
                  )
                : item == 'road'
                ? PrimaryIconBtn(
                    assetName: 'assets/icons/$item.svg',
                    gradient: AppTheme.secondaryCardGradient,
                    // Don't apply iconColor for road icon to preserve dots
                    iconWidth: 28,
                    iconHeight: 28,
                    onTap: () {},
                  )
                : PrimaryIconBtn(
                    assetName: 'assets/icons/$item.svg',
                    gradient: AppTheme.secondaryCardGradient,
                    iconColor: AppTheme.textDescColor,
                    iconWidth: 28,
                    iconHeight: 28,

                    onTap: () {},
                  ),
          );
        }).toList(),
      ),
    );
  }
}
