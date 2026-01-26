part of 'favorites_bloc.dart';

class FavoritesState extends Equatable {
  final List<ProductModel> items;
  const FavoritesState({this.items = const []});

  @override
  List<Object> get props => [items];
}
