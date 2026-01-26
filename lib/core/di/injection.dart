import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/cart/presentation/bloc/cart_bloc.dart';
import '../../features/favorites/presentation/bloc/favorites_bloc.dart';
import '../../features/home/data/repositories/product_repository_impl.dart';
import '../../features/home/domain/repositories/product_repository.dart';
import '../../features/home/presentation/bloc/home_bloc.dart';
import '../../features/profile/presentation/cubit/theme_cubit.dart';
import '../cubit/bottom_nav_cubit.dart';
import '../network/api_client.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  final dio = ApiModule.provideDio();
  getIt.registerSingleton<RestClient>(RestClient(dio));

  // Repositories
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(getIt()),
  );

  // Core Blocs/Cubits (Global)
  getIt.registerSingleton<ThemeCubit>(ThemeCubit(getIt()));
  // Pass prefs to CartBloc for persistence
  getIt.registerSingleton<CartBloc>(CartBloc(getIt()));
  getIt.registerSingleton<FavoritesBloc>(FavoritesBloc());
  getIt.registerSingleton<BottomNavCubit>(BottomNavCubit());

  // Feature Blocs (Factory)
  getIt.registerFactory<HomeBloc>(() => HomeBloc(getIt()));
}
