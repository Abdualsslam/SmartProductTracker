import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Product Tracker'), centerTitle: true),
      body: Center(child: Text('Welcome to Smart Product Tracker!', style: Theme.of(context).textTheme.displayLarge)),
    );
  }
}
