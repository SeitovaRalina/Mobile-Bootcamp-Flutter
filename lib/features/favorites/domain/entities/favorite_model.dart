import 'package:equatable/equatable.dart';
import '../../../home/domain/entities/product_model.dart';

class FavoritesModel extends Equatable {
  final List<ProductModel> items;

  const FavoritesModel({this.items = const []});

  @override
  List<Object> get props => [items];
}
