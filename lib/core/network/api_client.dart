import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/home/data/models/product_model.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://api.escuelajs.co/api/v1")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/products?offset=0&limit=50")
  Future<List<ProductModel>> getProducts();

  @GET("/products/{id}")
  Future<ProductModel> getProduct(@Path("id") int id);

  @GET("/categories")
  Future<List<CategoryModel>> getCategories();

  @GET("/categories/{id}/products")
  Future<List<ProductModel>> getProductsByCategory(@Path("id") int id);
}

class ApiModule {
  static Dio provideDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    return dio;
  }
}
