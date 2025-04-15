import 'package:flutter/material.dart';
import 'package:smart_product_tracker/app/routes.dart';
import 'package:smart_product_tracker/core/utils/theme/theme.dart';

class SmartProductTracker extends StatelessWidget {
  const SmartProductTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
