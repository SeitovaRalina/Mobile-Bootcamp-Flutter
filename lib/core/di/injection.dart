import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/favorites/data/datasources/favorites_data_source.dart';
import '../../features/home/data/datasources/category_data_source.dart';
import '../../features/home/data/repositories/category_repository_impl.dart';
import '../../features/home/domain/repositories/category_repository.dart';
import '../network/rest_client.dart';
import '../storage/local_storage.dart';
import '../network/api_client.dart';
import '../../features/home/data/datasources/product_data_source.dart';
import '../../features/home/data/repositories/product_repository_impl.dart';
import '../../features/home/domain/repositories/product_repository.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';
import '../../features/cart/data/datasources/cart_data_source.dart';
import '../../features/cart/data/repositories/cart_repository_impl.dart';
import '../../features/cart/domain/repositories/cart_repository.dart';
import '../../features/cart/presentation/bloc/cart_bloc.dart';
import '../../features/favorites/data/repositories/favorites_repository_impl.dart';
import '../../features/favorites/domain/repositories/favorites_repository.dart';
import '../../features/favorites/presentation/bloc/favorites_bloc.dart';
import '../cubit/theme_cubit.dart';
import '../cubit/bottom_nav_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // External dependencies
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // Core abstractions
  getIt.registerSingleton<ILocalStorage>(SharedPreferencesLocalStorage(prefs));

  // Network
  final dio = ApiModule.provideDio();
  getIt.registerSingleton<RestClient>(RestClient(dio));

  // Home feature - Data sources
  getIt.registerLazySingleton<ICategoryDataSource>(
    () => RemoteCategoryDataSource(getIt()),
  );
  getIt.registerLazySingleton<IProductDataSource>(
    () => RemoteProductDataSource(getIt()),
  );

  // Home feature - Repositories
  getIt.registerLazySingleton<ICategoryRepository>(
    () => CategoryRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<IProductRepository>(
    () => ProductRepositoryImpl(getIt()),
  );

  // Cart feature - Data sources
  getIt.registerLazySingleton<ICartDataSource>(
    () => LocalCartDataSource(getIt()),
  );

  // Cart feature - Repositories
  getIt.registerLazySingleton<ICartRepository>(
    () => CartRepositoryImpl(getIt()),
  );

  // Favorites feature - Data sources
  getIt.registerLazySingleton<IFavoritesDataSource>(
    () => LocalFavoritesDataSource(getIt()),
  );

  // Favorites feature - Repositories
  getIt.registerLazySingleton<IFavoritesRepository>(
    () => FavoritesRepositoryImpl(getIt()),
  );

  // Core Blocs/Cubits (Global)
  getIt.registerSingleton<ThemeCubit>(ThemeCubit(getIt()));
  getIt.registerSingleton<BottomNavCubit>(BottomNavCubit());

  // Feature Blocs (Singleton for state persistence)
  getIt.registerSingleton<CartBloc>(CartBloc(getIt())..add(LoadCart()));
  getIt.registerSingleton<FavoritesBloc>(
    FavoritesBloc(getIt())..add(LoadFavorites()),
  );

  // Feature Blocs (Factory)
  getIt.registerFactory<HomeBloc>(() => HomeBloc(getIt(), getIt()));
}
