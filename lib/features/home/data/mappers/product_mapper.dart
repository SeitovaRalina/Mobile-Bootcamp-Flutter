import '../dto/product_dto.dart';
import '../../domain/entities/product_model.dart';
import 'category_mapper.dart';

class ProductMapper {
  static ProductModel toModel(ProductDto dto) {
    return ProductModel(
      id: dto.id,
      title: dto.title,
      price: dto.price,
      description: dto.description,
      category: CategoryMapper.toModel(dto.category),
      images: dto.images,
    );
  }

  static List<ProductModel> toModelList(List<ProductDto> dtos) {
    return dtos.map((dto) => toModel(dto)).toList();
  }

  static ProductDto toDto(ProductModel model) {
    return ProductDto(
      id: model.id,
      title: model.title,
      price: model.price,
      description: model.description,
      category: CategoryMapper.toDto(model.category),
      images: model.images,
    );
  }

  static List<ProductDto> toDtoList(List<ProductModel> models) {
    return models.map((model) => toDto(model)).toList();
  }
}
