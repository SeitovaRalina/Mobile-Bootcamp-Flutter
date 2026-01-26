import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../home/data/models/product_model.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(const FavoritesState()) {
    on<ToggleFavorite>((event, emit) {
      final currentFavorites = List<ProductModel>.from(state.items);
      final isFav = currentFavorites.any((p) => p.id == event.product.id);

      if (isFav) {
        currentFavorites.removeWhere((p) => p.id == event.product.id);
      } else {
        currentFavorites.add(event.product);
      }
      emit(FavoritesState(items: currentFavorites));
    });
  }
}
