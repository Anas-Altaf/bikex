import 'dart:async';

import 'package:bikex/bikes/repo/favorites_repo_interface.dart';

/// In-memory implementation of FavoritesRepo
/// Stores favorites in memory (not persisted)
class InMemoryFavoritesRepo implements FavoritesRepo {
  InMemoryFavoritesRepo();

  /// In-memory storage for favorites (would be persisted in real app)
  final Set<String> _favoriteIds = {};

  /// Stream controller for favorites changes
  final _favoritesController = StreamController<Set<String>>.broadcast();

  /// Stream of favorite product IDs
  Stream<Set<String>> get favoritesStream => _favoritesController.stream;

  /// Get current favorite IDs
  Set<String> get favoriteIds => Set.unmodifiable(_favoriteIds);

  /// Check if a product is favorited
  bool isFavorite(String productId) {
    return _favoriteIds.contains(productId);
  }

  /// Add a product to favorites
  void addFavorite(String productId) {
    _favoriteIds.add(productId);
    _favoritesController.add(Set.from(_favoriteIds));
  }

  /// Remove a product from favorites
  void removeFavorite(String productId) {
    _favoriteIds.remove(productId);
    _favoritesController.add(Set.from(_favoriteIds));
  }

  /// Toggle favorite status
  void toggleFavorite(String productId) {
    if (isFavorite(productId)) {
      removeFavorite(productId);
    } else {
      addFavorite(productId);
    }
  }

  /// Dispose the stream controller
  void dispose() {
    _favoritesController.close();
  }
}
