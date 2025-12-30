import 'dart:async';

import 'package:bikex/bikes/cubit/product_detail_sheet_cubit.dart';
import 'package:bikex/bikes/models/product.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';

/// Draggable bottom sheet for product details with tabbed content
class ProductBottomSheet extends StatefulWidget {
  const ProductBottomSheet({
    required this.product,
    required this.onSizeChanged,
    super.key,
  });

  final Product product;
  final ValueChanged<double> onSizeChanged;

  @override
  State<ProductBottomSheet> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<ProductBottomSheet> {
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();

  // Track which content to show: 'description' or 'specification'
  String _selectedContent = 'none';
  static const double _maxSize = 0.5;
  // minimum size
  static const double _minSize = 0.13;

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  // function to Full Expand to _maxSize
  void _expandSheet() {
    unawaited(
      _sheetController.animateTo(
        _maxSize,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      ),
    );
  }

  // function to collapse to _minSize
  void _collapseSheet() {
    unawaited(
      _sheetController.animateTo(
        _minSize,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductDetailSheetCubit, ProductDetailSheetState>(
      listener: (context, state) {
        // If cubit requests collapse and controller is attached
        if (state.sheetSize == _minSize && _sheetController.isAttached) {
          // Check if the current sheet position is NOT at minimum
          final currentSize = _sheetController.size;
          if (currentSize > _minSize + 0.01) {
            // Sheet is expanded, so collapse it
            _collapseSheet();
          }
        }
      },
      child: DraggableScrollableSheet(
        controller: _sheetController,
        initialChildSize: _minSize, // Just show buttons initially
        minChildSize: _minSize, // Minimum just buttons
        maxChildSize: _maxSize, // Maximum when expanded
        snap: true,
        snapSizes: const [_minSize, _maxSize],
        builder: (context, scrollController) {
          return NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              widget.onSizeChanged(notification.extent);

              if (notification.extent == _minSize) {
                setState(() {
                  _selectedContent = 'none';
                });
            } else if (notification.extent > _minSize &&
                _selectedContent == 'none') {
              // set select content to description
              setState(() {
                _selectedContent = 'description';
              });
            }

            return true;
          },
          child: Container(
            decoration: BoxDecoration(
              // color: AppTheme.backgroundDeepColor,
              gradient: AppTheme.sheetGradient,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              border: Border.all(
                color: AppTheme.sheetBorderColor,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 60,
                  color: AppTheme.shadowColor.withAlpha(63),
                  offset: const Offset(0, -20),
                ),
              ],
            ),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                // Header with grab handle and buttons
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 35,
                      ),

                      // Toggle buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildToggleButton(
                                label: 'Description',
                                isSelected: _selectedContent == 'description',
                                onTap: () {
                                  _expandSheet();
                                  setState(() {
                                    _selectedContent = 'description';
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 30),
                            Expanded(
                              child: _buildToggleButton(
                                label: 'Specification',
                                isSelected: _selectedContent == 'specification',
                                onTap: () {
                                  _expandSheet();
                                  setState(() {
                                    _selectedContent = 'specification';
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 35),
                    ],
                  ),
                ),

                // Content area (scrollable)
                if (_selectedContent == 'specification')
                  _SpecificationTabSliver(product: widget.product)
                else
                  _DescriptionTabSliver(product: widget.product),
              ],
            ),
          ),
        );
      },
      ),
    );
  }

  // Widget _buildGrabHandle() {
  //   return Center(
  //     child: Container(
  //       width: 50,
  //       height: 5,
  //       decoration: BoxDecoration(
  //         color: AppTheme.textDescColor.withAlpha(100),
  //         borderRadius: BorderRadius.circular(3),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildToggleButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.backgroundSurfaceColor
              : AppTheme.backgroundDeepColor,
          borderRadius: BorderRadius.circular(10),

          boxShadow: !isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.textColor.withAlpha(25),
                    // blurStyle: .inner,
                    blurRadius: 4,
                    offset: const Offset(-4, -4),
                    inset: true,
                  ),

                  BoxShadow(
                    color: AppTheme.shadowColor.withAlpha(100),
                    // blurStyle: .inner,
                    blurRadius: 4,
                    offset: const Offset(4, 4),
                    inset: true,
                  ),
                ]
              : [
                  BoxShadow(
                    color: AppTheme.textColor.withAlpha(15),
                    // blurStyle: BlurStyle.outer,
                    blurRadius: 4,
                    offset: const Offset(-4, -4),
                    // inset: true,
                  ),
                  BoxShadow(
                    color: AppTheme.shadowColor.withAlpha(100),
                    // blurStyle: .inner,
                    blurRadius: 10,
                    offset: const Offset(4, 4),
                    // inset: true,
                  ),
                ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? AppTheme.primaryColor
                  : AppTheme.textDescColor,
              fontSize: 15,
              fontWeight: isSelected ? .bold : .normal,
            ),
          ),
        ),
      ),
    );
  }
}

/// Description tab content
class _DescriptionTabSliver extends StatelessWidget {
  const _DescriptionTabSliver({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Text(
            product.name.toUpperCase(),
            style: const TextStyle(
              color: AppTheme.textColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            product.description,
            style: const TextStyle(
              color: AppTheme.textDescColor,
              fontSize: 14,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}

/// Specification tab content
class _SpecificationTabSliver extends StatelessWidget {
  const _SpecificationTabSliver({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final entries = product.specifications.entries.toList();

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final entry = entries[index];
            return Column(
              children: [
                if (index > 0)
                  Divider(
                    color: AppTheme.textDescColor.withAlpha(20),
                    height: 1,
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        entry.key,
                        style: const TextStyle(
                          color: AppTheme.textDescColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        entry.value,
                        style: const TextStyle(
                          color: AppTheme.textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          childCount: entries.length,
        ),
      ),
    );
  }
}
