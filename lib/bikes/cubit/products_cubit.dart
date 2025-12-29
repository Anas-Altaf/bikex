import 'package:bikex/bikes/models/models.dart';
import 'package:bikex/bikes/repo/repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'products_state.dart';

/// Cubit for managing products state
class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit({required ProductsRepo productsRepo})
      : _productsRepo = productsRepo,
        super(const ProductsInitial());

  final ProductsRepo _productsRepo;

  /// Load all products
  void loadProducts() {
    emit(const ProductsLoading());
    try {
      final products = _productsRepo.getProducts();
      final categories = _productsRepo.getCategories();
      emit(ProductsLoaded(
        products: products,
        categories: categories,
        selectedCategory: 'All',
      ));
    } on Exception catch (e) {
      emit(ProductsError(message: e.toString()));
    }
  }

  /// Filter products by category
  void filterByCategory(String category) {
    switch (state) {
      case ProductsLoaded(:final products, :final categories):
        final filteredProducts = _productsRepo.getProductsByCategory(category);
        emit(ProductsLoaded(
          products: products,
          categories: categories,
          filteredProducts: filteredProducts,
          selectedCategory: category,
        ));
      default:
        // Do nothing if not in loaded state
        break;
    }
  }
}
