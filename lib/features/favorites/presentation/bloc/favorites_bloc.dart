import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/error_handler.dart';
import '../../domain/entities/favorite_model.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../../../home/domain/entities/product_model.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final IFavoritesRepository _repository;

  FavoritesBloc(this._repository) : super(const FavoritesLoading()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesLoading());
    try {
      final favorites = await _repository.getFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(ErrorHandler.handle(e)));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    if (state is! FavoritesLoaded) return;
    try {
      await _repository.toggleFavorite(event.product);
      final favorites = await _repository.getFavorites();
      emit(FavoritesLoaded(favorites));
    } catch (e) {
      emit(FavoritesError(ErrorHandler.handle(e)));
    }
  }
}
