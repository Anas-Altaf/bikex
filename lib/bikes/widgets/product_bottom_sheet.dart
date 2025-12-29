import 'package:bikex/bikes/models/product.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

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
  String _selectedContent = 'description';

  @override
  void dispose() {
    _sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _sheetController,
      initialChildSize: 0.15, // Just show buttons initially
      minChildSize: 0.15, // Minimum just buttons
      maxChildSize: 0.7, // Maximum when expanded
      snap: true,
      snapSizes: const [0.15, 0.7],
      builder: (context, scrollController) {
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            widget.onSizeChanged(notification.extent);
            return true;
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.backgroundDeepColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
              border: Border.all(
                color: AppTheme.textDescColor.withAlpha(20),
              ),
            ),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                // Header with grab handle and buttons
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // Grab handle
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 12, bottom: 8),
                        child: _buildGrabHandle(),
                      ),

                      // Toggle buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildToggleButton(
                                label: 'Description',
                                isSelected: _selectedContent == 'description',
                                onTap: () {
                                  setState(() {
                                    _selectedContent = 'description';
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildToggleButton(
                                label: 'Specification',
                                isSelected:
                                    _selectedContent == 'specification',
                                onTap: () {
                                  setState(() {
                                    _selectedContent = 'specification';
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),

                // Content area (scrollable)
                _selectedContent == 'description'
                    ? _DescriptionTabSliver(product: widget.product)
                    : _SpecificationTabSliver(product: widget.product),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGrabHandle() {
    return Center(
      child: Container(
        width: 50,
        height: 5,
        decoration: BoxDecoration(
          color: AppTheme.textDescColor.withAlpha(100),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: isSelected ? AppTheme.primaryGradient : null,
          color: isSelected ? null : AppTheme.backgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppTheme.textDescColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
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
              fontSize: 18,
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
