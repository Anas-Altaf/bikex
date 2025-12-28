import 'package:bikex/bikes/bikes.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Shows product details in a bottom sheet with two tabs
void showProductDetailsSheet(BuildContext context, Product product) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ProductDetailsSheet(product: product),
  );
}

class ProductDetailsSheet extends StatelessWidget {
  const ProductDetailsSheet({
    required this.product,
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: AppTheme.backgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.textDescColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Product image with Hero
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Hero(
                        tag: 'product_image_${product.id}',
                        child: Image.asset(
                          product.imageAsset ?? 'assets/images/cycle_01.png',
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    // Favorite button
                    BlocBuilder<FavoritesCubit, FavoritesState>(
                      builder: (context, state) {
                        final isFavorite = state.isFavorite(product.id);
                        return IconButton(
                          onPressed: () {
                            context
                                .read<FavoritesCubit>()
                                .toggleFavorite(product.id);
                          },
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavorite ? Colors.red : AppTheme.textColor,
                            size: 32,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Title and price
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.category.toUpperCase(),
                      style: const TextStyle(
                        color: AppTheme.primaryUpColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.name,
                      style: const TextStyle(
                        color: AppTheme.textColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppTheme.primaryUpColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Tabs
              Expanded(
                child: _ProductDetailsTabs(
                  product: product,
                  scrollController: scrollController,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProductDetailsTabs extends StatefulWidget {
  const _ProductDetailsTabs({
    required this.product,
    required this.scrollController,
  });

  final Product product;
  final ScrollController scrollController;

  @override
  State<_ProductDetailsTabs> createState() => _ProductDetailsTabsState();
}

class _ProductDetailsTabsState extends State<_ProductDetailsTabs>
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
    return Column(
      children: [
        // Tab bar
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: AppTheme.backgroundDeepColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            unselectedLabelColor: AppTheme.textDescColor,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(text: 'Description'),
              Tab(text: 'Specifications'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Tab content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Description tab
              _DescriptionTab(
                description: widget.product.description,
                scrollController: widget.scrollController,
              ),
              // Specifications tab
              _SpecificationsTab(
                specifications: widget.product.specifications,
                scrollController: widget.scrollController,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DescriptionTab extends StatelessWidget {
  const _DescriptionTab({
    required this.description,
    required this.scrollController,
  });

  final String description;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        description,
        style: const TextStyle(
          color: AppTheme.textDescColor,
          fontSize: 16,
          height: 1.6,
        ),
      ),
    );
  }
}

class _SpecificationsTab extends StatelessWidget {
  const _SpecificationsTab({
    required this.specifications,
    required this.scrollController,
  });

  final Map<String, String> specifications;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final entries = specifications.entries.toList();

    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: entries.length,
      separatorBuilder: (context, index) => Divider(
        color: AppTheme.textDescColor.withAlpha(30),
        height: 1,
      ),
      itemBuilder: (context, index) {
        final entry = entries[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                entry.key,
                style: const TextStyle(
                  color: AppTheme.textDescColor,
                  fontSize: 16,
                ),
              ),
              Text(
                entry.value,
                style: const TextStyle(
                  color: AppTheme.textColor,
                  fontSize: 16,
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
