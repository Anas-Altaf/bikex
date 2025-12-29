import 'package:bikex/bikes/bikes.dart';
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
        final product = context.read<ProductsCubit>().getProductById(productId);

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
      body: Stack(
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
                SizedBox(height: screenHeight * 0.4),
              ],
            ),
          ),

          // Persistent bottom sheet
          _ProductBottomSheet(product: product),
        ],
      ),
    );
  }
}

/// Diagonal split background
class _DiagonalBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DiagonalPainter(),
      size: Size.infinite,
    );
  }
}

class _DiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Left dark side
    final darkPaint = Paint()..color = AppTheme.backgroundColor;

    // Right gradient side
    final gradientPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF34C8E8),
          Color(0xFF4E4AF2),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Draw gradient on right
    final gradientPath = Path()
      ..moveTo(size.width * 1, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * 0.1, size.height)
      ..close();

    canvas
      ..drawRect(Rect.fromLTWH(0, 0, size.width, size.height), darkPaint)
      ..drawPath(gradientPath, gradientPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Persistent bottom sheet with tabs
class _ProductBottomSheet extends StatefulWidget {
  const _ProductBottomSheet({required this.product});

  final Product product;

  @override
  State<_ProductBottomSheet> createState() => _ProductBottomSheetState();
}

class _ProductBottomSheetState extends State<_ProductBottomSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: screenHeight * 0.45,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.backgroundDeepColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          border: Border.all(
            color: AppTheme.textDescColor.withAlpha(20),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Tab bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _ProductTabBar(controller: _tabController),
            ),
            const SizedBox(height: 16),
            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _DescriptionTab(product: widget.product),
                  _SpecificationTab(product: widget.product),
                ],
              ),
            ),
            // Price and Add to Cart
            _BottomPriceBar(product: widget.product),
          ],
        ),
      ),
    );
  }
}

/// Custom tab bar matching the design
class _ProductTabBar extends StatelessWidget {
  const _ProductTabBar({required this.controller});

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          gradient: AppTheme.primaryGradient,
          borderRadius: BorderRadius.circular(30),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: AppTheme.textDescColor,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Description'),
          Tab(text: 'Specification'),
        ],
      ),
    );
  }
}

/// Description tab content
class _DescriptionTab extends StatelessWidget {
  const _DescriptionTab({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
        ],
      ),
    );
  }
}

/// Specification tab content
class _SpecificationTab extends StatelessWidget {
  const _SpecificationTab({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final entries = product.specifications.entries.toList();

    return ListView.separated(
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

/// Bottom bar with price and add to cart button
class _BottomPriceBar extends StatelessWidget {
  const _BottomPriceBar({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Price
          Expanded(
            child: Text(
              '\$ ${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                color: AppTheme.primaryUpColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Add to Cart button
          GestureDetector(
            onTap: () {
              // TODO(dev): Add to cart functionality.
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                'Add to Cart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
