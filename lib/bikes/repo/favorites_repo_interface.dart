/// Abstract repository interface for managing favorite products
/// This interface enables dependency inversion and makes testing easier
abstract class FavoritesRepo {
  /// Stream of favorite product IDs
  Stream<Set<String>> get favoritesStream;

  /// Get current favorite IDs
  Set<String> get favoriteIds;

  /// Check if a product is favorited
  bool isFavorite(String productId);

  /// Add a product to favorites
  void addFavorite(String productId);

  /// Remove a product from favorites
  void removeFavorite(String productId);

  /// Toggle favorite status
  void toggleFavorite(String productId);

  /// Dispose resources
  void dispose();
}
