import 'dart:async';

import 'package:bikex/bikes/cubit/product_detail_sheet_cubit.dart';
import 'package:bikex/bikes/models/product.dart';
import 'package:bikex/core/constants.dart';
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

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  /// Expand sheet to maximum size
  void _expandSheet() {
    unawaited(
      _sheetController.animateTo(
        ProductDetailConstants.sheetMaxSize,
        duration: ProductDetailConstants.expandDuration,
        curve: Curves.easeInOut,
      ),
    );
  }

  /// Collapse sheet to minimum size
  void _collapseSheet() {
    unawaited(
      _sheetController.animateTo(
        ProductDetailConstants.sheetMinSize,
        duration: ProductDetailConstants.collapseDuration,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductDetailSheetCubit, ProductDetailSheetState>(
      listener: (context, state) {
        // If cubit requests collapse and controller is attached
        if (state.sheetSize == ProductDetailConstants.sheetMinSize &&
            _sheetController.isAttached) {
          // Check if the current sheet position is NOT at minimum
          final currentSize = _sheetController.size;
          if (currentSize >
              ProductDetailConstants.sheetMinSize +
                  ProductDetailConstants.sheetPositionTolerance) {
            // Sheet is expanded, so collapse it
            _collapseSheet();
          }
        }
      },
      child: DraggableScrollableSheet(
        controller: _sheetController,
        initialChildSize: ProductDetailConstants.sheetMinSize,
        minChildSize: ProductDetailConstants.sheetMinSize,
        maxChildSize: ProductDetailConstants.sheetMaxSize,
        snap: true,
        snapSizes: const [
          ProductDetailConstants.sheetMinSize,
          ProductDetailConstants.sheetMaxSize,
        ],
        builder: (context, scrollController) {
          return NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              widget.onSizeChanged(notification.extent);
              return true;
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: AppTheme.sheetGradient,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(
                    ProductDetailConstants.sheetBorderRadius,
                  ),
                ),
                border: Border.all(
                  color: AppTheme.sheetBorderColor,
                  width: ProductDetailConstants.sheetBorderWidth,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: ProductDetailConstants.sheetShadowBlur,
                    color: AppTheme.shadowColor.withAlpha(
                      ProductDetailConstants.sheetShadowAlpha,
                    ),
                    offset: const Offset(
                      0,
                      ProductDetailConstants.sheetShadowOffsetY,
                    ),
                  ),
                ],
              ),
              child: BlocBuilder<ProductDetailSheetCubit, ProductDetailSheetState>(
                builder: (context, sheetState) {
                  return Column(
                    children: [
                      // Fixed header with toggle buttons (does not scroll)
                      // Wrapped with GestureDetector to allow dragging the sheet
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onVerticalDragUpdate: (details) {
                          if (_sheetController.isAttached) {
                            final screenHeight = MediaQuery.of(
                              context,
                            ).size.height;
                            final delta = -details.delta.dy / screenHeight;
                            final newSize = (_sheetController.size + delta)
                                .clamp(
                                  ProductDetailConstants.sheetMinSize,
                                  ProductDetailConstants.sheetMaxSize,
                                );
                            _sheetController.jumpTo(newSize);
                          }
                        },
                        onVerticalDragEnd: (details) {
                          if (_sheetController.isAttached) {
                            // Snap to nearest size
                            final currentSize = _sheetController.size;
                            final midPoint =
                                (ProductDetailConstants.sheetMinSize +
                                    ProductDetailConstants.sheetMaxSize) /
                                2;
                            if (currentSize > midPoint) {
                              _expandSheet();
                            } else {
                              _collapseSheet();
                            }
                          }
                        },
                        child: Column(
                          children: [
                            const SizedBox(
                              height:
                                  ProductDetailConstants.toggleButtonTopSpacing,
                            ),

                            // Toggle buttons
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: ProductDetailConstants
                                    .toggleButtonContainerPadding,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _buildToggleButton(
                                      context: context,
                                      label: 'Description',
                                      isSelected:
                                          sheetState.selectedTab ==
                                          ProductDetailTab.description,
                                      onTap: () {
                                        _expandSheet();
                                        context
                                            .read<ProductDetailSheetCubit>()
                                            .selectTab(
                                              ProductDetailTab.description,
                                            );
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: ProductDetailConstants
                                        .toggleButtonSpacing,
                                  ),
                                  Expanded(
                                    child: _buildToggleButton(
                                      context: context,
                                      label: 'Specification',
                                      isSelected:
                                          sheetState.selectedTab ==
                                          ProductDetailTab.specification,
                                      onTap: () {
                                        _expandSheet();
                                        context
                                            .read<ProductDetailSheetCubit>()
                                            .selectTab(
                                              ProductDetailTab.specification,
                                            );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: ProductDetailConstants
                                  .toggleButtonBottomSpacing,
                            ),
                          ],
                        ),
                      ),

                      // Scrollable content area
                      Expanded(
                        child: CustomScrollView(
                          controller: scrollController,
                          slivers: [
                            if (sheetState.selectedTab ==
                                ProductDetailTab.specification)
                              _SpecificationTabSliver(
                                product: widget.product,
                              )
                            else
                              _DescriptionTabSliver(
                                product: widget.product,
                              ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildToggleButton({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: ProductDetailConstants.toggleButtonPaddingVertical,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.backgroundSurfaceColor
              : AppTheme.backgroundDeepColor,
          borderRadius: BorderRadius.circular(
            ProductDetailConstants.toggleButtonBorderRadius,
          ),
          boxShadow: !isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.textColor.withAlpha(25),
                    blurRadius: ProductDetailConstants.toggleButtonShadowBlur,
                    offset: const Offset(
                      -ProductDetailConstants.toggleButtonShadowOffset,
                      -ProductDetailConstants.toggleButtonShadowOffset,
                    ),
                    inset: true,
                  ),
                  BoxShadow(
                    color: AppTheme.shadowColor.withAlpha(100),
                    blurRadius: ProductDetailConstants.toggleButtonShadowBlur,
                    offset: const Offset(
                      ProductDetailConstants.toggleButtonShadowOffset,
                      ProductDetailConstants.toggleButtonShadowOffset,
                    ),
                    inset: true,
                  ),
                ]
              : [
                  BoxShadow(
                    color: AppTheme.textColor.withAlpha(15),
                    blurRadius: ProductDetailConstants.toggleButtonShadowBlur,
                    offset: const Offset(
                      -ProductDetailConstants.toggleButtonShadowOffset,
                      -ProductDetailConstants.toggleButtonShadowOffset,
                    ),
                  ),
                  BoxShadow(
                    color: AppTheme.shadowColor.withAlpha(100),
                    blurRadius:
                        ProductDetailConstants.toggleButtonShadowBlur * 2.5,
                    offset: const Offset(
                      ProductDetailConstants.toggleButtonShadowOffset,
                      ProductDetailConstants.toggleButtonShadowOffset,
                    ),
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
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
              fontSize: 15,
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
