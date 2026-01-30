import '../entities/category_model.dart';

abstract class ICategoryRepository {
  Future<List<CategoryModel>> getCategories();
}
