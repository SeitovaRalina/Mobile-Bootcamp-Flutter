import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/error_handler.dart';
import '../../domain/entities/category_model.dart';
import '../../domain/repositories/category_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/entities/product_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IProductRepository _productRepository;
  final ICategoryRepository _categoryRepository;

  HomeBloc(this._productRepository, this._categoryRepository)
    : super(HomeLoading()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<SelectCategory>(_onSelectCategory);
  }

  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final products = await _productRepository.getProducts();
      final categories = await _categoryRepository.getCategories();
      emit(HomeLoaded(products: products, categories: categories));
    } catch (e) {
      emit(HomeError(ErrorHandler.handle(e)));
    }
  }

  Future<void> _onSelectCategory(
    SelectCategory event,
    Emitter<HomeState> emit,
  ) async {
    List<CategoryModel> currentCategories = [];
    if (state is HomeLoaded) {
      currentCategories = (state as HomeLoaded).categories;
    }

    emit(HomeLoading());
    try {
      final products = event.category == null
          ? await _productRepository.getProducts()
          : await _productRepository.getProductsByCategory(event.category!.id);

      emit(
        HomeLoaded(
          products: products,
          categories: currentCategories,
          selectedCategory: event.category,
        ),
      );
    } catch (e) {
      emit(HomeError(ErrorHandler.handle(e)));
    }
  }
}
