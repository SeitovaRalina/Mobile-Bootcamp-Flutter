part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final CartModel cart;

  const CartLoaded(this.cart);

  @override
  List<Object?> get props => [cart];
}

class CartError extends CartState {
  final Failure failure;

  const CartError(this.failure);

  @override
  List<Object?> get props => [failure];
}
