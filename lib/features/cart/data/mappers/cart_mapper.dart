import '../../domain/entities/cart_model.dart';
import '../dto/cart_dto.dart';
import '../dto/cart_item_dto.dart';
import '../../domain/entities/cart_item_model.dart';
import '../../../home/data/mappers/product_mapper.dart';

class CartMapper {
  static CartItemModel toModel(CartItemDto dto) {
    return CartItemModel(
      product: ProductMapper.toModel(dto.product),
      quantity: dto.quantity,
    );
  }

  static List<CartItemModel> toModelList(List<CartItemDto> dtos) {
    return dtos.map((dto) => toModel(dto)).toList();
  }

  static CartModel toCartModel(CartDto dto) {
    return CartModel(items: toModelList(dto.items));
  }

  static CartItemDto toDto(CartItemModel model) {
    return CartItemDto(
      product: ProductMapper.toDto(model.product),
      quantity: model.quantity,
    );
  }

  static List<CartItemDto> toDtoList(List<CartItemModel> models) {
    return models.map((model) => toDto(model)).toList();
  }

  static CartDto toCartDto(CartModel model) {
    return CartDto(items: toDtoList(model.items));
  }
}
