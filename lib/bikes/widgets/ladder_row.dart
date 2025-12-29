import 'package:bikex/bikes/bikes.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/core/widgets/primary_icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Category filter row widget
/// Accepts optional callback for category selection
class LadderRow extends StatelessWidget {
  const LadderRow({
    super.key,
    this.onCategorySelected,
  });

  /// Optional callback for category selection
  /// If not provided, defaults to calling ProductsCubit directly
  final void Function(String category)? onCategorySelected;

  // Category items with icons
  static const List<Map<String, String>> _categoryItems = [
    {'name': 'All', 'icon': ''},
    {'name': 'Electric', 'icon': 'bolt'},
    {'name': 'Road', 'icon': 'road'},
    {'name': 'Mountain', 'icon': 'rects'},
    {'name': 'Urban', 'icon': 'helmet'},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        final selectedCategory = switch (state) {
          ProductsLoaded(:final selectedCategory) => selectedCategory,
          _ => 'All',
        };

        return Container(
          transform: Matrix4.translationValues(0, -10, 0),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _categoryItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final categoryName = item['name']!;
              final iconName = item['icon']!;
              final isSelected = selectedCategory == categoryName;

              return Padding(
                padding: EdgeInsets.only(bottom: index * 12.0),
                child: _buildCategoryButton(
                  context: context,
                  categoryName: categoryName,
                  iconName: iconName,
                  isSelected: isSelected,
                  index: index,
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildCategoryButton({
    required BuildContext context,
    required String categoryName,
    required String iconName,
    required bool isSelected,
    required int index,
  }) {
    return PrimaryIconBtn(
      isSelected: isSelected,
      gradient: AppTheme.secondaryCardGradient,
      assetName: iconName.isNotEmpty ? 'assets/icons/$iconName.svg' : null,
      iconColor: isSelected ? Colors.white : AppTheme.textDescColor,
      iconWidth: 28,
      iconHeight: 28,
      replacedWidget: iconName.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(4),
              child: Text(
                categoryName,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppTheme.textDescColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
      onTap: () {
        // Use callback if provided, otherwise use BLoC directly
        if (onCategorySelected != null) {
          onCategorySelected!(categoryName);
        } else {
          context.read<ProductsCubit>().filterByCategory(categoryName);
        }
      },
    );
  }
}
