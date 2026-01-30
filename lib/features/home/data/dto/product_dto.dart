import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

import 'category_dto.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final CategoryDto category;
  final List<String> images;

  const ProductDto({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);

  @override
  List<Object?> get props => [id, title, price, category, images];
}
