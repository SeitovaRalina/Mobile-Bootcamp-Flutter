import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/product_model.dart';
import '../../domain/repositories/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

// Bloc
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository _repository;

  HomeBloc(this._repository) : super(HomeLoading()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<SelectCategory>(_onSelectCategory);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final products = await _repository.getProducts();
      final categories = await _repository.getCategories();
      emit(HomeLoaded(products: products, categories: categories));
    } catch (e) {
      emit(HomeError("Failed to load data: ${e.toString()}"));
    }
  }

  Future<void> _onSelectCategory(
    SelectCategory event,
    Emitter<HomeState> emit,
  ) async {
    final currentState = state;
    if (currentState is HomeLoaded) {
      emit(HomeLoading());
      try {
        final products = event.category == null
            ? await _repository.getProducts()
            : await _repository.getProductsByCategory(event.category!.id);

        emit(
          HomeLoaded(
            products: products,
            categories: currentState.categories,
            selectedCategory: event.category,
          ),
        );
      } catch (e) {
        emit(HomeError("Failed to load category: ${e.toString()}"));
      }
    }
  }
}
