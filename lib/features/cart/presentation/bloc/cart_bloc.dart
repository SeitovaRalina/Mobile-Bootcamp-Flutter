import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_bootcamp_example/core/error/failures.dart';
import 'package:mobile_bootcamp_example/core/network/error_handler.dart';

import '../../domain/entities/cart_model.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/entities/cart_item_model.dart';
import '../../../home/domain/entities/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository _repository;

  CartBloc(this._repository) : super(CartLoading()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<ClearCart>(_onClearCart);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final cart = await _repository.getCart();
      emit(CartLoaded(cart));
    } catch (e) {
      emit(CartError(ErrorHandler.handle(e)));
    }
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    if (state is! CartLoaded) return;
    final current = (state as CartLoaded).cart;

    try {
      final items = List<CartItemModel>.from(current.items);
      final index = items.indexWhere(
        (item) => item.product.id == event.product.id,
      );

      if (index != -1) {
        items[index] = CartItemModel(
          product: items[index].product,
          quantity: items[index].quantity + 1,
        );
      } else {
        items.add(CartItemModel(product: event.product, quantity: 1));
      }
      final newCart = CartModel(items: items);
      await _repository.saveCart(newCart);
      emit(CartLoaded(newCart));
    } catch (e) {
      emit(CartError(ErrorHandler.handle(e)));
    }
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<CartState> emit,
  ) async {
    if (state is! CartLoaded) return;
    final current = (state as CartLoaded).cart;

    try {
      final items = List<CartItemModel>.from(current.items);
      final index = items.indexWhere(
        (item) => item.product.id == event.product.id,
      );

      if (index != -1) {
        if (items[index].quantity > 1) {
          items[index] = CartItemModel(
            product: items[index].product,
            quantity: items[index].quantity - 1,
          );
        } else {
          items.removeAt(index);
        }
      }

      final newCart = CartModel(items: items);
      await _repository.saveCart(newCart);
      emit(CartLoaded(newCart));
    } catch (e) {
      emit(CartError(ErrorHandler.handle(e)));
    }
  }

  Future<void> _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    const newCart = CartModel(items: []);
    try {
      await _repository.clearCart();
      emit(const CartLoaded(newCart));
    } catch (e) {
      emit(CartError(ErrorHandler.handle(e)));
    }
  }
}
