import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'cart_item_dto.dart';

part 'cart_dto.g.dart';

@JsonSerializable()
class CartDto extends Equatable {
  final List<CartItemDto> items;

  const CartDto({this.items = const []});

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CartDtoToJson(this);

  @override
  List<Object> get props => [items];
}
