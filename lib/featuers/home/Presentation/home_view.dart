import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_product_tracker/core/functions/navigation/navigation.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Product Tracker'), centerTitle: true, automaticallyImplyLeading: false),
      body: Column(
        children: [
          Center(child: Text('Welcome to Smart Product Tracker!', style: Theme.of(context).textTheme.displayLarge)),
          Center(
            child: ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                customNavigate(context, '/signIn');
              },
              child: Text('log out'),
            ),
          ),
        ],
      ),
    );
  }
}
