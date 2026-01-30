import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_dto.g.dart';

@JsonSerializable()
class CategoryDto extends Equatable {
  final int id;
  final String name;
  final String image;

  const CategoryDto({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);

  @override
  List<Object?> get props => [id, name, image];
}
