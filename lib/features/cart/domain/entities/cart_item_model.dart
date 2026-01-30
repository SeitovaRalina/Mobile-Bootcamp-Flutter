import 'package:equatable/equatable.dart';
import '../../../home/domain/entities/product_model.dart';

class CartItemModel extends Equatable {
  final ProductModel product;
  final int quantity;

  const CartItemModel({required this.product, required this.quantity});

  double get total => product.price * quantity;

  @override
  List<Object> get props => [product, quantity];
}
