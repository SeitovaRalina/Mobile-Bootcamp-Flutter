import '../entities/product_model.dart';

abstract class IProductRepository {
  Future<List<ProductModel>> getProducts();
  Future<List<ProductModel>> getProductsByCategory(int categoryId);
  Future<ProductModel> getProductDetails(int id);
}
