import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/theme_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("FakeStore User"),
            accountEmail: Text("user@fakestore.com"),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person, size: 40),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text("Theme"),
            trailing: DropdownButton<ThemeMode>(
              value: themeCubit.state,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text("System"),
                ),
                DropdownMenuItem(value: ThemeMode.light, child: Text("Light")),
                DropdownMenuItem(value: ThemeMode.dark, child: Text("Dark")),
              ],
              onChanged: (mode) {
                if (mode != null) context.read<ThemeCubit>().updateTheme(mode);
              },
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("About App"),
            subtitle: Text("Flutter E-commerce Demo v1.0"),
          ),
        ],
      ),
    );
  }
}
