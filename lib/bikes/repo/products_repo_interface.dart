import 'package:bikex/bikes/models/models.dart';

/// Abstract repository interface for managing bike products
/// This interface enables dependency inversion and makes testing easier
abstract class ProductsRepo {
  /// Get all products
  List<Product> getProducts();

  /// Get product by ID
  Product? getProductById(String id);

  /// Get products by category
  List<Product> getProductsByCategory(String category);

  /// Get unique categories
  List<String> getCategories();
}
