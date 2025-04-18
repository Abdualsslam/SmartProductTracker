import 'package:firebase_auth/firebase_auth.dart';

void checkStateChanges(Function(bool) onStateChanged) {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      onStateChanged(false);
    } else {
      onStateChanged(true);
    }
  });
}
