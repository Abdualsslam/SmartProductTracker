import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smart_product_tracker/app/smart_product_tracker.dart';
import 'package:smart_product_tracker/core/services/service_locator.dart';
import 'package:smart_product_tracker/featuers/home/data/models/product_model.dart';
import 'package:smart_product_tracker/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter(); // ✅ أول شيء بعد تهيئة الـ Widgets

  Hive.registerAdapter(ProductModelAdapter()); // ✅ سجل الـ TypeAdapter بعد التهيئة
  await Hive.openBox<ProductModel>('productsBox'); // ✅ بعدها افتح البوكس

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await setupLocator(); // ⛔ مهم: لا تستدعي setupLocator قبل فتح البوكس
  runApp(const SmartProductTracker());
}
