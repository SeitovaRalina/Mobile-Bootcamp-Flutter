import '../dto/favorite_dto.dart';
import '../../domain/entities/favorite_model.dart';
import '../../../home/data/mappers/product_mapper.dart';

class FavoritesMapper {
  static FavoritesModel toModel(FavoritesStateDto dto) {
    return FavoritesModel(items: ProductMapper.toModelList(dto.items));
  }

  static FavoritesStateDto toDto(FavoritesModel entity) {
    return FavoritesStateDto(items: ProductMapper.toDtoList(entity.items));
  }
}
