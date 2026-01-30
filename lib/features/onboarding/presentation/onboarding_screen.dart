import 'package:flutter/material.dart';

import '../../../main.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shopping_bag_outlined,
                size: 100,
                color: Colors.blue,
              ),
              const SizedBox(height: 32),
              Text(
                "Welcome to FakeStore",
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "Find the best products for the best prices. Explore our catalog now!",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              FilledButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const MainWrapper()),
                ),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Get Started"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
