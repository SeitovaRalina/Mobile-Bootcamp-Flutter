part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;

  HomeLoaded({
    required this.products,
    required this.categories,
    this.selectedCategory,
  });

  @override
  List<Object?> get props => [products, categories, selectedCategory];
}

class HomeError extends HomeState {
  final Failure failure;
  HomeError(this.failure);
  @override
  List<Object> get props => [failure];
}
