import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_bootcamp_example/features/home/presentation/widgets/category_tab.dart';
import 'package:mobile_bootcamp_example/features/home/presentation/widgets/product_tab.dart';

import 'bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("FakeStore"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Home"),
              Tab(text: "Category"),
            ],
          ),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<HomeBloc>().add(LoadHomeData()),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            } else if (state is HomeLoaded) {
              return TabBarView(
                children: [
                  ProductTab(products: state.products),
                  CategoryTab(categories: state.categories),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
