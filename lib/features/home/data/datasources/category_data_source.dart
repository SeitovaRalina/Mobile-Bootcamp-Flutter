import '../../../../core/network/rest_client.dart';
import '../dto/category_dto.dart';

abstract class ICategoryDataSource {
  Future<List<CategoryDto>> getCategories();
}

class RemoteCategoryDataSource implements ICategoryDataSource {
  final RestClient _client;

  RemoteCategoryDataSource(this._client);

  @override
  Future<List<CategoryDto>> getCategories() async {
    return await _client.getCategories();
  }
}
