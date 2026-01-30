// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartDto _$CartDtoFromJson(Map<String, dynamic> json) => CartDto(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => CartItemDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$CartDtoToJson(CartDto instance) => <String, dynamic>{
  'items': instance.items,
};
