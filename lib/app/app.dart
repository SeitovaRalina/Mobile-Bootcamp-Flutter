import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/cubit/bottom_nav_cubit.dart';
import '../core/cubit/theme_cubit.dart';
import '../core/di/injection.dart';
import '../core/theme/app_theme.dart';
import '../features/cart/presentation/bloc/cart_bloc.dart';
import '../features/favorites/presentation/bloc/favorites_bloc.dart';
import '../features/home/presentation/bloc/home_bloc.dart';
import '../l10n/app_localizations.dart';
import 'main_wrapper.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ThemeCubit>()),
        BlocProvider(create: (_) => getIt<CartBloc>()),
        BlocProvider(create: (_) => getIt<FavoritesBloc>()),
        BlocProvider(create: (_) => getIt<HomeBloc>()..add(LoadHomeData())),
        BlocProvider(create: (_) => getIt<BottomNavCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'FakeStore',
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            home: const MainWrapper(),
          );
        },
      ),
    );
  }
}
