import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/home/data/dto/category_dto.dart';
import '../../features/home/data/dto/product_dto.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/products?offset=0&limit=50")
  Future<List<ProductDto>> getProducts();

  @GET("/products/{id}")
  Future<ProductDto> getProduct(@Path("id") int id);

  @GET("/categories")
  Future<List<CategoryDto>> getCategories();

  @GET("/categories/{id}/products")
  Future<List<ProductDto>> getProductsByCategory(@Path("id") int id);
}
