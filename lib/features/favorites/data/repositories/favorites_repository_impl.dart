import '../../domain/repositories/favorites_repository.dart';
import '../../domain/entities/favorite_model.dart';
import '../../../home/domain/entities/product_model.dart';
import '../datasources/favorites_data_source.dart';
import '../mappers/favorites_mapper.dart';

class FavoritesRepositoryImpl implements IFavoritesRepository {
  final IFavoritesDataSource _localDataSource;

  FavoritesRepositoryImpl(this._localDataSource);

  @override
  Future<FavoritesModel> getFavorites() async {
    final dto = await _localDataSource.getFavorites();
    if (dto == null) {
      return const FavoritesModel();
    }
    return FavoritesMapper.toModel(dto);
  }

  @override
  Future<void> saveFavorites(FavoritesModel favorites) async {
    final dto = FavoritesMapper.toDto(favorites);
    await _localDataSource.saveFavorites(dto);
  }

  @override
  Future<void> toggleFavorite(ProductModel product) async {
    final favorites = await getFavorites();
    final items = List<ProductModel>.from(favorites.items);
    final isFav = items.any((p) => p.id == product.id);

    if (isFav) {
      items.removeWhere((p) => p.id == product.id);
    } else {
      items.add(product);
    }

    await saveFavorites(FavoritesModel(items: items));
  }
}
