import 'dart:convert';
import '../../../../core/storage/local_storage.dart';
import '../dto/cart_dto.dart';

abstract class ICartDataSource {
  Future<CartDto?> getCart();
  Future<void> saveCart(CartDto cart);
  Future<void> clearCart();
}

class LocalCartDataSource implements ICartDataSource {
  final ILocalStorage _storage;
  static const String _cartKey = 'cart_storage';

  LocalCartDataSource(this._storage);

  @override
  Future<CartDto?> getCart() async {
    final jsonString = await _storage.getString(_cartKey);
    if (jsonString == null) return null;
    try {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return CartDto.fromJson(jsonMap);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveCart(CartDto cart) async {
    final jsonString = jsonEncode(cart.toJson());
    await _storage.setString(_cartKey, jsonString);
  }

  @override
  Future<void> clearCart() async {
    await _storage.remove(_cartKey);
  }
}
