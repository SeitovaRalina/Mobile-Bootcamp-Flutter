part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
  final ProductModel product;
  AddToCart(this.product);
}

class RemoveFromCart extends CartEvent {
  final ProductModel product;
  RemoveFromCart(this.product);
}

class ClearCart extends CartEvent {}
