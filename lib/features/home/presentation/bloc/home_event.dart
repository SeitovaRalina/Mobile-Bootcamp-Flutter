part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadHomeData extends HomeEvent {}

class SelectCategory extends HomeEvent {
  final CategoryModel? category; // null for "All"
  SelectCategory(this.category);

  @override
  List<Object?> get props => [category];
}
