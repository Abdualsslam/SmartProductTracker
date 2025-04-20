import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_product_tracker/app/routes.dart';
import 'package:smart_product_tracker/core/services/service_locator.dart';
import 'package:smart_product_tracker/core/utils/theme/theme.dart';
import 'package:smart_product_tracker/featuers/alerts/presentation/cubit/alert_cubit.dart';

class SmartProductTracker extends StatelessWidget {
  const SmartProductTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlertCubit(addAlert: sl(), deleteAlert: sl(), getAllAlerts: sl())..fetchAlerts(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        routerConfig: router,
      ),
    );
  }
}
