part of 'products_cubit.dart';

/// Base state for products
sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

/// Loading state
class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

/// Loaded state with products
class ProductsLoaded extends ProductsState {
  const ProductsLoaded({
    required this.products,
    required this.categories,
    this.filteredProducts,
    this.selectedCategory = 'All',
  });

  final List<Product> products;
  final List<String> categories;
  final List<Product>? filteredProducts;
  final String selectedCategory;

  /// Get display products (filtered or all)
  List<Product> get displayProducts => filteredProducts ?? products;

  ProductsLoaded copyWith({
    List<Product>? products,
    List<String>? categories,
    List<Product>? filteredProducts,
    String? selectedCategory,
  }) {
    return ProductsLoaded(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      filteredProducts: filteredProducts ?? this.filteredProducts,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  List<Object?> get props => [
        products,
        categories,
        filteredProducts,
        selectedCategory,
      ];
}

/// Error state
class ProductsError extends ProductsState {
  const ProductsError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
