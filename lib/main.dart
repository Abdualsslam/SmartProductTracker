import 'package:flutter/material.dart';

void main() {
  runApp(const SmartProductTracker());
}

class SmartProductTracker extends StatelessWidget {
  const SmartProductTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Smart Product Tracker')),
        body: const Center(child: Text('Welcome to Smart Product Tracker!')),
      ),
    );
  }
}
