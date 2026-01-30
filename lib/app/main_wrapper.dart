import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/cubit/bottom_nav_cubit.dart';
import '../core/extensions/context_extension.dart';
import '../features/cart/presentation/cart_screen.dart';
import '../features/favorites/presentation/favorites_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/profile/presentation/profile_screen.dart';

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
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: context.l10n.navHome,
              ),
              NavigationDestination(
                icon: Icon(Icons.shopping_cart_outlined),
                selectedIcon: Icon(Icons.shopping_cart),
                label: context.l10n.navCart,
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_outline),
                selectedIcon: Icon(Icons.favorite),
                label: context.l10n.navFavorites,
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: context.l10n.navProfile,
              ),
            ],
          ),
        );
      },
    );
  }
}
