import 'package:bikex/bikes/bikes.dart';
import 'package:bikex/bikes/widgets/diagonal_painter.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Product detail page with hero image and persistent bottom sheet
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    required this.productId,
    super.key,
  });

  final String productId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        // Get product from state using switch expression
        final product = switch (state) {
          ProductsLoaded() => state.getProductById(productId),
          _ => null,
        };

        if (product == null) {
          return Scaffold(
            backgroundColor: AppTheme.backgroundColor,
            appBar: CustomAppBar(
              title: '',
              onTap: () => context.pop(),
            ),
            body: const Center(
              child: Text(
                'Product not found',
                style: TextStyle(color: AppTheme.textColor),
              ),
            ),
          );
        }

        return _ProductDetailContent(product: product);
      },
    );
  }
}

class _ProductDetailContent extends StatelessWidget {
  const _ProductDetailContent({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SizedBox.expand(
        child: Stack(
          children: [
            // Diagonal gradient background
            _DiagonalBackground(),

            // Main content
            SafeArea(
              child: Column(
                children: [
                  // App bar using CustomAppBar
                  CustomAppBar(
                    title: product.name.toUpperCase(),
                    onTap: () => context.pop(),
                  ),

                  // Hero product image
                  Expanded(
                    child: Center(
                      child: Hero(
                        tag: 'product_image_${product.id}',
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Image.asset(
                            product.imageAsset ?? 'assets/images/cycle_01.png',
                            fit: BoxFit.contain,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Space for bottom sheet
                  SizedBox(height: screenHeight * 0.15),
                ],
              ),
            ),

            // Draggable bottom sheet
            _ProductBottomSheet(product: product),
          ],
        ),
      ),
    );
  }
}

/// Diagonal split background
class _DiagonalBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DiagonalPainter(),
      size: Size.infinite,
    );
  }
}

/// Persistent bottom sheet with toggle buttons (Draggable)
class _ProductBottomSheet extends StatefulWidget {
  const _ProductBottomSheet({required this.product});

  final Product product;

  @override
  State<_ProductBottomSheet> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<_ProductBottomSheet> {
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
      initialChildSize: 0.1, // Just show buttons initially
      minChildSize: 0.1, // Minimum just buttons
      maxChildSize: 0.5, // Maximum when expanded
      snap: true,
      snapSizes: const [0.1, 0.5],
      builder: (context, scrollController) {
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
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
                // Header with grab handle and buttons (not scrollable)
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // Grab handle
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 12, bottom: 8),
                        child: _buildGrabHandle(),
                      ),

                      // Two buttons in a row
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
                                isSelected: _selectedContent == 'specification',
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

                // Content area (scrollable within the sheet)
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

/// Description tab content (Sliver version)
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

/// Specification tab content (Sliver version)
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

/// Description tab content
class _DescriptionTab extends StatelessWidget {
  const _DescriptionTab({
    required this.product,
    required this.scrollController,
  });

  final Product product;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          const SizedBox(height: 20), // Extra space for scroll
        ],
      ),
    );
  }
}

/// Specification tab content
class _SpecificationTab extends StatelessWidget {
  const _SpecificationTab({
    required this.product,
    required this.scrollController,
  });

  final Product product;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final entries = product.specifications.entries.toList();

    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: entries.length,
      separatorBuilder: (context, index) => Divider(
        color: AppTheme.textDescColor.withAlpha(20),
        height: 1,
      ),
      itemBuilder: (context, index) {
        final entry = entries[index];
        return Padding(
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
        );
      },
    );
  }
}
