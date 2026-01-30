import '../entities/favorite_model.dart';
import '../../../home/domain/entities/product_model.dart';

abstract class IFavoritesRepository {
  Future<FavoritesModel> getFavorites();
  Future<void> saveFavorites(FavoritesModel favorites);
  Future<void> toggleFavorite(ProductModel product);
}
