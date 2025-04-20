import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:smart_product_tracker/app/smart_product_tracker.dart';
import 'package:smart_product_tracker/core/database/cache/cache_helper.dart';
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

  final cacheHelper = sl<CacheHelper>();
  // استدع دالة التهيئة وانتظر اكتمالها
  await cacheHelper.init();

  // uploadSampleProducts();
  runApp(const SmartProductTracker());
}

getIt() {}

void uploadSampleProducts() async {
  final firestore = FirebaseFirestore.instance;

  final products = [
    {
      "id": 3,
      "title": "Samsung Galaxy Watch 5",
      "imageUrl": "https://multimedia.bbycastatic.ca/multimedia/products/500x500/189/18923/18923006.png",
      "originalPrice": 129.99,
      "discountPrice": 109.99,
      "storeName": "Tech Store",
    },
    {
      "id": 4,
      "title": "HP 15.6\" Laptop - Ryzen 5",
      "imageUrl": "https://multimedia.bbycastatic.ca/multimedia/products/500x500/179/17935/17935299.jpg",
      "originalPrice": 649.99,
      "discountPrice": 579.99,
      "storeName": "HP Official",
    },
    {
      "id": 5,
      "title": "Lenovo IdeaPad 3 Laptop",
      "imageUrl": "https://multimedia.bbycastatic.ca/multimedia/products/500x500/177/17741/17741362.jpeg",
      "originalPrice": 599.99,
      "discountPrice": 499.99,
      "storeName": "Lenovo Store",
    },
    {
      "id": 6,
      "title": "Apple Watch SE (2nd Gen)",
      "imageUrl": "https://multimedia.bbycastatic.ca/multimedia/products/500x500/189/18925/18925575.jpg",
      "originalPrice": 329.99,
      "discountPrice": 279.99,
      "storeName": "Apple Shop",
    },
    {
      "id": 7,
      "title": "Samsung Galaxy Watch 4",
      "imageUrl": "https://multimedia.bbycastatic.ca/multimedia/products/500x500/183/18392/18392702.jpg",
      "originalPrice": 199.99,
      "discountPrice": 159.99,
      "storeName": "Samsung Store",
    },
    {
      "id": 8,
      "title": "ASUS VivoBook 15 Laptop",
      "imageUrl": "https://multimedia.bbycastatic.ca/multimedia/products/500x500/191/19196/19196024.jpeg",
      "originalPrice": 729.99,
      "discountPrice": 629.99,
      "storeName": "ASUS Official",
    },
    {
      "id": 9,
      "title": "Beats Studio3 Wireless",
      "imageUrl": "https://multimedia.bbycastatic.ca/multimedia/products/500x500/175/17543/17543652.jpeg",
      "originalPrice": 349.99,
      "discountPrice": 299.99,
      "storeName": "Beats by Dre",
    },
    {
      "id": 10,
      "title": "Garmin Venu Sq Smartwatch",
      "imageUrl": "https://multimedia.bbycastatic.ca/multimedia/products/500x500/181/18172/18172402.jpeg",
      "originalPrice": 249.99,
      "discountPrice": 199.99,
      "storeName": "Garmin",
    },
    {
      "id": 11,
      "title": "Garmin Forerunner 55",
      "imageUrl": "https://multimedia.bbycastatic.ca/multimedia/products/500x500/181/18172/18172431.jpeg",
      "originalPrice": 229.99,
      "discountPrice": 179.99,
      "storeName": "Garmin",
    },
    {
      "id": 12,
      "title": "JBL Tune 760NC Headphones",
      "imageUrl": "https://multimedia.bbycastatic.ca/multimedia/products/500x500/182/18249/18249078.jpg",
      "originalPrice": 149.99,
      "discountPrice": 129.99,
      "storeName": "JBL Store",
    },
  ];

  for (var product in products) {
    await firestore
        .collection("products")
        .doc(product["id"].toString()) // ✅ هنا التحويل الصحيح
        .set(product);
  }

  print("✅ تم رفع المنتجات بنجاح");
}
