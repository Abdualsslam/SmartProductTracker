import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_product_tracker/core/functions/navigation/navigation.dart';

void navigateBasedOnAuth(BuildContext context) {
  final user = FirebaseAuth.instance.currentUser;
  final route = user == null ? '/signUp' : '/home';
  delayedNavagte(context, route);
}

void delayedNavagte(context, path) {
  Future.delayed(const Duration(seconds: 2), () {
    customReplacementNavigate(context, path);
  });
}
