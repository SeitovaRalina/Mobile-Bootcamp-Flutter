// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoritesStateDto _$FavoritesStateDtoFromJson(Map<String, dynamic> json) =>
    FavoritesStateDto(
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$FavoritesStateDtoToJson(FavoritesStateDto instance) =>
    <String, dynamic>{'items': instance.items};
