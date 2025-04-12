import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:smart_product_tracker/core/utils/theme/theme.dart';
import 'package:smart_product_tracker/featuers/splash/view/splash_view.dart';

class SmartProductTracker extends StatelessWidget {
  const SmartProductTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: SplashView(),
    );
  }
}
