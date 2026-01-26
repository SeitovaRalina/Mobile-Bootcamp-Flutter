import '../../data/models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProducts();
  Future<List<CategoryModel>> getCategories();
  Future<List<ProductModel>> getProductsByCategory(int categoryId);
  Future<ProductModel> getProductDetails(int id);
}
