import 'package:equatable/equatable.dart';

import 'category_model.dart';

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

  @override
  List<Object?> get props => [id, title, price, category, images];
}
