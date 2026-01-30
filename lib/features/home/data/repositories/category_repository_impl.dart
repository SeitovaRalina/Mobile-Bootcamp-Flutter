import '../../domain/entities/category_model.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_data_source.dart';
import '../mappers/category_mapper.dart';

class CategoryRepositoryImpl implements ICategoryRepository {
  final ICategoryDataSource _remoteDataSource;

  CategoryRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final dtos = await _remoteDataSource.getCategories();
    return CategoryMapper.toModelList(dtos);
  }
}
