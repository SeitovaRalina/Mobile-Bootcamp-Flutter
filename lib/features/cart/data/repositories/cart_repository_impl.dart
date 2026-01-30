import '../../domain/entities/cart_model.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_data_source.dart';
import '../mappers/cart_mapper.dart';

class CartRepositoryImpl implements ICartRepository {
  final ICartDataSource _localDataSource;

  CartRepositoryImpl(this._localDataSource);

  @override
  Future<CartModel> getCart() async {
    final dto = await _localDataSource.getCart();
    if (dto == null) {
      return const CartModel();
    }
    return CartMapper.toCartModel(dto);
  }

  @override
  Future<void> saveCart(CartModel cart) async {
    final dto = CartMapper.toCartDto(cart);
    await _localDataSource.saveCart(dto);
  }

  @override
  Future<void> clearCart() async {
    await _localDataSource.clearCart();
  }
}
