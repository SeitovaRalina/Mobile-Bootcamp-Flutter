import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../home/data/models/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final SharedPreferences _prefs;
  static const String _cartKey = 'cart_storage';

  CartBloc(this._prefs) : super(const CartState()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<IncrementItem>(_onIncrementItem);
    on<DecrementItem>(_onDecrementItem);
    on<ClearCart>(_onClearCart);
  }

  void _saveToPrefs(CartState state) {
    _prefs.setString(_cartKey, jsonEncode(state.toJson()));
  }

  void _onLoadCart(LoadCart event, Emitter<CartState> emit) {
    final jsonString = _prefs.getString(_cartKey);
    if (jsonString != null) {
      try {
        final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        emit(CartState.fromJson(jsonMap));
      } catch (e) {
        // Fallback if data is corrupted
        emit(const CartState());
      }
    }
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere(
      (item) => item.product.id == event.product.id,
    );

    if (index != -1) {
      items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
    } else {
      items.add(CartItem(product: event.product, quantity: 1));
    }
    final newState = CartState(items: items);
    emit(newState);
    _saveToPrefs(newState);
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final items = List<CartItem>.from(state.items);
    items.removeWhere((item) => item.product.id == event.product.id);
    final newState = CartState(items: items);
    emit(newState);
    _saveToPrefs(newState);
  }

  void _onIncrementItem(IncrementItem event, Emitter<CartState> emit) {
    add(AddToCart(event.product));
  }

  void _onDecrementItem(DecrementItem event, Emitter<CartState> emit) {
    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere(
      (item) => item.product.id == event.product.id,
    );

    if (index != -1) {
      if (items[index].quantity > 1) {
        items[index] = items[index].copyWith(
          quantity: items[index].quantity - 1,
        );
        final newState = CartState(items: items);
        emit(newState);
        _saveToPrefs(newState);
      } else {
        add(RemoveFromCart(event.product));
      }
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    const newState = CartState(items: []);
    emit(newState);
    _saveToPrefs(newState);
  }
}
