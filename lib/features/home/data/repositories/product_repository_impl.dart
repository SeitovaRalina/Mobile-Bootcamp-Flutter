import '../../../../core/network/api_client.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final RestClient _client;

  ProductRepositoryImpl(this._client);

  @override
  Future<List<ProductModel>> getProducts() async {
    return await _client.getProducts();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    return await _client.getCategories();
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(int categoryId) async {
    return await _client.getProductsByCategory(categoryId);
  }

  @override
  Future<ProductModel> getProductDetails(int id) async {
    return await _client.getProduct(id);
  }
}
