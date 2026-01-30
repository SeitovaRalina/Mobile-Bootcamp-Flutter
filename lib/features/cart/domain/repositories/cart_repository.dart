import '../entities/cart_model.dart';

abstract class ICartRepository {
  Future<CartModel> getCart();
  Future<void> saveCart(CartModel cart);
  Future<void> clearCart();
}
