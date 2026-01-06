import 'dart:async';

import 'package:bikex/bikes/repo/repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorites_state.dart';

/// Cubit for managing favorites state
class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit({required FavoritesRepo favoritesRepo})
      : _favoritesRepo = favoritesRepo,
        super(const FavoritesState()) {
    _subscription = _favoritesRepo.favoritesStream.listen(_onFavoritesChanged);
  }

  final FavoritesRepo _favoritesRepo;
  StreamSubscription<Set<String>>? _subscription;

  void _onFavoritesChanged(Set<String> favoriteIds) {
    emit(state.copyWith(favoriteIds: favoriteIds));
  }

  /// Toggle favorite status for a product
  void toggleFavorite(String productId) {
    _favoritesRepo.toggleFavorite(productId);
  }

  /// Check if a product is favorited
  bool isFavorite(String productId) {
    return state.favoriteIds.contains(productId);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
