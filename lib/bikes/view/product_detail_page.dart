import 'package:bikex/bikes/bikes.dart';
import 'package:bikex/bikes/cubit/product_detail_sheet_cubit.dart';
import 'package:bikex/bikes/widgets/diagonal_painter.dart';
import 'package:bikex/bikes/widgets/product_bottom_sheet.dart';
import 'package:bikex/bikes/widgets/product_image_carousel.dart';
import 'package:bikex/core/constants.dart';
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
    // Cache screen height to avoid repeated MediaQuery calls
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return BlocBuilder<ProductDetailSheetCubit, ProductDetailSheetState>(
      builder: (context, sheetState) {
        final sheetSize = sheetState.sheetSize;
        
        // Calculate icon rotation using helper method
        final iconRotation = ProductDetailConstants.calculateIconRotation(
          sheetSize,
        );

        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          body: SizedBox.expand(
            child: Stack(
              children: [
                // Diagonal gradient background
                const _DiagonalBackground(),

                // Main content
                SafeArea(
                  child: Column(
                    children: [
                      // App bar using CustomAppBar
                      CustomAppBar(
                        title: product.name.toUpperCase(),
                        onTap: () => iconRotation ==
                                ProductDetailConstants.minRotationAngle
                            ? context.pop()
                            : context
                                .read<ProductDetailSheetCubit>()
                                .collapseSheet(),
                        iconRoation: iconRotation,
                      ),

                      // Hero product images carousel - dynamically sized
                      ProductImageCarousel(
                        product: product,
                        imageHeight: ProductDetailConstants.calculateImageHeight(
                          screenHeight: screenHeight,
                          statusBarHeight: statusBarHeight,
                          sheetSize: sheetSize,
                        ),
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
  const _DiagonalBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DiagonalPainter(),
      size: Size.infinite,
    );
  }
}
