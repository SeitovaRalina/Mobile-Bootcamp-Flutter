import 'dart:convert';
import '../../../../core/storage/local_storage.dart';
import '../dto/favorite_dto.dart';

abstract class IFavoritesDataSource {
  Future<FavoritesStateDto?> getFavorites();
  Future<void> saveFavorites(FavoritesStateDto favorites);
  Future<void> clearFavorites();
}

class LocalFavoritesDataSource implements IFavoritesDataSource {
  final ILocalStorage _storage;
  static const String _favoritesKey = 'favorites_storage';

  LocalFavoritesDataSource(this._storage);

  @override
  Future<FavoritesStateDto?> getFavorites() async {
    final jsonString = await _storage.getString(_favoritesKey);
    if (jsonString == null) return null;
    try {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return FavoritesStateDto.fromJson(jsonMap);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveFavorites(FavoritesStateDto favorites) async {
    final jsonString = jsonEncode(favorites.toJson());
    await _storage.setString(_favoritesKey, jsonString);
  }

  @override
  Future<void> clearFavorites() async {
    await _storage.remove(_favoritesKey);
  }
}
