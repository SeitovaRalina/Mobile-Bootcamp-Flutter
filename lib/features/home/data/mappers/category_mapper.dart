import '../../domain/entities/category_model.dart';
import '../dto/category_dto.dart';

class CategoryMapper {
  static CategoryModel toModel(CategoryDto dto) {
    return CategoryModel(id: dto.id, name: dto.name, image: dto.image);
  }

  static List<CategoryModel> toModelList(List<CategoryDto> dtos) {
    return dtos.map((dto) => toModel(dto)).toList();
  }

  static CategoryDto toDto(CategoryModel model) {
    return CategoryDto(id: model.id, name: model.name, image: model.image);
  }
}
