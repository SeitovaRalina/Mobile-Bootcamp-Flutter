import '../../../../core/network/rest_client.dart';
import '../dto/product_dto.dart';

abstract class IProductDataSource {
  Future<List<ProductDto>> getProducts();
  Future<ProductDto> getProduct(int id);
  Future<List<ProductDto>> getProductsByCategory(int categoryId);
}

class RemoteProductDataSource implements IProductDataSource {
  final RestClient _client;

  RemoteProductDataSource(this._client);

  @override
  Future<List<ProductDto>> getProducts() async {
    return await _client.getProducts();
  }

  @override
  Future<ProductDto> getProduct(int id) async {
    return await _client.getProduct(id);
  }

  @override
  Future<List<ProductDto>> getProductsByCategory(int categoryId) async {
    return await _client.getProductsByCategory(categoryId);
  }
}
