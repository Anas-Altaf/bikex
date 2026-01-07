import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:bikex/bikes/bikes.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/core/widgets/primary_icon_btn.dart';
import 'package:bikex/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Animated search overlay with product filtering
class SearchOverlay extends StatefulWidget {
  const SearchOverlay({super.key});

  /// Show the search overlay as a full-screen modal
  static Future<void> show(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Search',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SearchOverlay();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position:
              Tween<Offset>(
                begin: const Offset(0, -1),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                ),
              ),
          child: child,
        );
      },
    );
  }

  @override
  State<SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  String _query = '';

  @override
  void initState() {
    super.initState();
    // Auto-focus search field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  List<Product> _filterProducts(List<Product> products) {
    if (_query.isEmpty) return products;

    final lowerQuery = _query.toLowerCase();
    return products.where((product) {
      return product.name.toLowerCase().contains(lowerQuery) ||
          product.category.toLowerCase().contains(lowerQuery) ||
          product.description.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            // Search header
            FadeInDown(
              duration: const Duration(milliseconds: 400),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Back button using PrimaryIconButton
                    PrimaryIconBtn(
                      assetName: 'assets/icons/back.svg',
                      gradient: AppTheme.primaryGradient,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 12),
                    // Search field
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.backgroundSurfaceColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppTheme.primaryUpColor.withAlpha(50),
                          ),
                        ),
                        child: TextField(
                          controller: _searchController,
                          focusNode: _focusNode,
                          style: const TextStyle(color: AppTheme.textColor),
                          decoration: InputDecoration(
                            hintText: 'Search bikes...',
                            hintStyle: TextStyle(
                              color: AppTheme.textDescColor.withAlpha(150),
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: AppTheme.primaryUpColor,
                            ),
                            suffixIcon: _query.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.clear,
                                      color: AppTheme.textDescColor,
                                    ),
                                    onPressed: () {
                                      _searchController.clear();
                                      setState(() => _query = '');
                                    },
                                  )
                                : null,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                          onChanged: (value) {
                            setState(() => _query = value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Results
            Expanded(
              child: BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  if (state is! ProductsLoaded) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryUpColor,
                      ),
                    );
                  }

                  final filteredProducts = _filterProducts(state.products);
                  final favorites = context
                      .watch<FavoritesCubit>()
                      .state
                      .favoriteIds;

                  if (filteredProducts.isEmpty) {
                    return FadeIn(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: AppTheme.textDescColor.withAlpha(100),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No bikes found for "$_query"',
                              style: const TextStyle(
                                color: AppTheme.textDescColor,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return FadeIn(
                    duration: const Duration(milliseconds: 300),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Results count
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(
                            '${filteredProducts.length} result(s)',
                            style: const TextStyle(
                              color: AppTheme.textDescColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        // Results grid using ProductCard
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.75,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                ),
                            itemCount: filteredProducts.length,
                            itemBuilder: (context, index) {
                              final product = filteredProducts[index];
                              final isFavorite = favorites.contains(product.id);
                              final isLeft = index.isEven;

                              return FadeInUp(
                                delay: Duration(milliseconds: 10 * index),
                                duration: const Duration(milliseconds: 300),
                                child: Transform.translate(
                                  offset: Offset(0, isLeft ? 25 : 0),
                                  child: ProductCard(
                                    product: product,
                                    isFavorite: isFavorite,
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      unawaited(context.push(
                                        AppRoutes.productDetailPath(product.id),
                                      ));
                                    },
                                    onFavoriteToggle: () => context
                                        .read<FavoritesCubit>()
                                        .toggleFavorite(product.id),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
