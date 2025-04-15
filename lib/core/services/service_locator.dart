import 'package:get_it/get_it.dart';
import 'package:smart_product_tracker/core/database/cache/cache_helper.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  // getIt.registerSingleton<AuthCubit>(AuthCubit());
}
