import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

import '../../../home/data/dto/product_dto.dart';

part 'cart_item_dto.g.dart';

@JsonSerializable()
class CartItemDto extends Equatable {
  final ProductDto product;
  final int quantity;

  const CartItemDto({required this.product, required this.quantity});

  factory CartItemDto.fromJson(Map<String, dynamic> json) =>
      _$CartItemDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CartItemDtoToJson(this);

  @override
  List<Object> get props => [product, quantity];
}
