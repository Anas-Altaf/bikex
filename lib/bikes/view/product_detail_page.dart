import 'package:bikex/bikes/bikes.dart';
import 'package:bikex/bikes/cubit/product_detail_sheet_cubit.dart';
import 'package:bikex/bikes/widgets/diagonal_painter.dart';
import 'package:bikex/bikes/widgets/product_bottom_sheet.dart';
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

        // Provide sheet cubit for this page
        return BlocProvider(
          create: (_) => ProductDetailSheetCubit(),
          child: _ProductDetailContent(product: product),
        );
      },
    );
  }
}

class _ProductDetailContent extends StatelessWidget {
  const _ProductDetailContent({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailSheetCubit, ProductDetailSheetState>(
      builder: (context, sheetState) {
        final screenHeight = MediaQuery.of(context).size.height;
        final sheetSize = sheetState.sheetSize;

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

                      // Hero product image - dynamically sized based on sheet position
                      Builder(
                        builder: (context) {
                          // Get dimensions
                          final appBarHeight = 60.0;
                          final statusBarHeight = MediaQuery.of(
                            context,
                          ).padding.top;

                          // Calculate available height for image area
                          final availableHeight =
                              screenHeight - statusBarHeight - appBarHeight;

                          // Calculate how much space the sheet takes
                          final sheetHeight = screenHeight * sheetSize;

                          // Remaining space for image (with some padding)
                          final imageHeight =
                              (availableHeight - sheetHeight - 40).clamp(
                                150.0, // Minimum height
                                availableHeight * 0.9, // Maximum height
                              );

                          return SizedBox(
                            height: imageHeight,
                            width: double.infinity,
                            child: Center(
                              child: Hero(
                                tag: 'product_image_${product.id}',
                                child: Image.asset(
                                  product.imageAsset ??
                                      'assets/images/cycle_01.png',
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      // Spacer to push everything up
                      const Spacer(),
                    ],
                  ),
                ),

                // Draggable bottom sheet
                ProductBottomSheet(
                  product: product,
                  onSizeChanged: (size) {
                    context.read<ProductDetailSheetCubit>().updateSheetSize(
                      size,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
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
