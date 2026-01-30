import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

import '../../../home/data/dto/product_dto.dart';

part 'favorite_dto.g.dart';

@JsonSerializable()
class FavoritesStateDto extends Equatable {
  final List<ProductDto> items;

  const FavoritesStateDto({this.items = const []});

  factory FavoritesStateDto.fromJson(Map<String, dynamic> json) =>
      _$FavoritesStateDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FavoritesStateDtoToJson(this);

  @override
  List<Object> get props => [items];
}
