import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final CategoryModel category;
  final List<String> images;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  // Helper to get a valid image URL (clean brackets/quotes if API sends dirty data)
  String get firstImage {
    if (images.isEmpty) return 'https://i.imgur.com/6C9Q5d5.jpg'; // Placeholder
    String img = images.first;
    if (img.startsWith('["')) {
      img = img.replaceAll('["', '').replaceAll('"]', '').replaceAll('"', '');
    }
    return img;
  }

  @override
  List<Object?> get props => [id, title, price, category, images];
}

@JsonSerializable()
class CategoryModel extends Equatable {
  final int id;
  final String name;
  final String image;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  List<Object?> get props => [id, name, image];
}
