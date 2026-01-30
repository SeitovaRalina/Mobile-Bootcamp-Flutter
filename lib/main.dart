import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/cubit/bottom_nav_cubit.dart';
import 'core/di/injection.dart';
import 'core/storage/local_storage.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/cart/presentation/cart_screen.dart';
import 'features/favorites/presentation/bloc/favorites_bloc.dart';
import 'features/favorites/presentation/favorites_screen.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/home/presentation/home_screen.dart';
import 'features/onboarding/presentation/onboarding_screen.dart';
import 'core/cubit/theme_cubit.dart';
import 'features/profile/presentation/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

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
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              textTheme: GoogleFonts.poppinsTextTheme(),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(
                ThemeData.dark().textTheme,
              ),
            ),
            home: const InitialRouter(),
          );
        },
      ),
    );
  }
}

class InitialRouter extends StatelessWidget {
  const InitialRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = getIt<ILocalStorage>();
    return FutureBuilder<bool?>(
      future: storage.getBool('onboarding_completed'),
      builder: (context, snapshot) {
        final onboardingComplete = snapshot.data ?? false;
        return onboardingComplete
            ? const MainWrapper()
            : const OnboardingScreen();
      },
    );
  }
}

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key});

  final List<Widget> _screens = const [
    HomeScreen(),
    CartScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: IndexedStack(index: currentIndex, children: _screens),
          bottomNavigationBar: NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: (idx) {
              context.read<BottomNavCubit>().updateIndex(idx);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_cart_outlined),
                selectedIcon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_outline),
                selectedIcon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
