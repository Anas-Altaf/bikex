import 'package:bikex/bikes/bikes.dart';
import 'package:bikex/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// Products list widget that handles BLoC interactions
/// and passes state/callbacks down to ProductCard children
class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, productsState) {
        return switch (productsState) {
          ProductsInitial() => const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          ),
          ProductsLoading() => const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
          ProductsError(:final message) => SliverFillRemaining(
            child: Center(child: Text('Error: $message')),
          ),
          ProductsLoaded(:final displayProducts) =>
            BlocBuilder<FavoritesCubit, FavoritesState>(
              // Only rebuild when favorites actually change
              buildWhen: (previous, current) =>
                  previous.favoriteIds != current.favoriteIds,
              builder: (context, favoritesState) {
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = displayProducts[index];
                        final isLeft = index.isEven;
                        final isFavorite = favoritesState.isFavorite(
                          product.id,
                        );

                        return Transform.translate(
                          offset: Offset(0, isLeft ? 25 : 0),
                          child: ProductCard(
                            product: product,
                            isFavorite: isFavorite,
                            onTap: () => context.push(
                              AppRoutes.productDetailPath(product.id),
                            ),
                            onFavoriteToggle: () => context
                                .read<FavoritesCubit>()
                                .toggleFavorite(product.id),
                          ),
                        );
                      },
                      childCount: displayProducts.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.80,
                        ),
                  ),
                );
              },
            ),
        };
      },
    );
  }
}
