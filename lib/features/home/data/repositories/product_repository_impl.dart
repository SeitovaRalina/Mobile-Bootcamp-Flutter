import '../../domain/repositories/product_repository.dart';
import '../../domain/entities/product_model.dart';
import '../datasources/product_data_source.dart';
import '../mappers/product_mapper.dart';

class ProductRepositoryImpl implements IProductRepository {
  final IProductDataSource _remoteDataSource;

  ProductRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<ProductModel>> getProducts() async {
    final dtos = await _remoteDataSource.getProducts();
    return ProductMapper.toModelList(dtos);
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(int categoryId) async {
    final dtos = await _remoteDataSource.getProductsByCategory(categoryId);
    return ProductMapper.toModelList(dtos);
  }

  @override
  Future<ProductModel> getProductDetails(int id) async {
    final dto = await _remoteDataSource.getProduct(id);
    return ProductMapper.toModel(dto);
  }
}
