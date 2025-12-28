part of 'favorites_cubit.dart';

/// State for favorites
class FavoritesState extends Equatable {
  const FavoritesState({
    this.favoriteIds = const {},
  });

  final Set<String> favoriteIds;

  /// Check if a product is favorited
  bool isFavorite(String productId) => favoriteIds.contains(productId);

  FavoritesState copyWith({
    Set<String>? favoriteIds,
  }) {
    return FavoritesState(
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }

  @override
  List<Object?> get props => [favoriteIds];
}
