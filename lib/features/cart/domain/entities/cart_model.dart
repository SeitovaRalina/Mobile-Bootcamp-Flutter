import 'package:equatable/equatable.dart';

import 'cart_item_model.dart';

class CartModel extends Equatable {
  final List<CartItemModel> items;

  const CartModel({this.items = const []});

  double get totalAmount => items.fold(0, (sum, item) => sum + item.total);
  int get totalItems => items.fold(0, (sum, item) => sum + item.quantity);

  @override
  List<Object> get props => [items];
}
