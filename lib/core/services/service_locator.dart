import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:hive/hive.dart';
import 'package:smart_product_tracker/core/connection/network_info.dart';
import 'package:smart_product_tracker/core/database/cache/cache_helper.dart';
import 'package:smart_product_tracker/featuers/home/Presentation/cubit/home_cubit.dart';
import 'package:smart_product_tracker/featuers/home/data/datasources/product_local_data_source.dart';
import 'package:smart_product_tracker/featuers/home/data/datasources/product_local_data_source_impl.dart';
import 'package:smart_product_tracker/featuers/home/data/datasources/product_remote_data_source_impl.dart';
import 'package:smart_product_tracker/featuers/home/data/datasources/products_remote_data_source.dart';
import 'package:smart_product_tracker/featuers/home/data/models/product_model.dart';
import 'package:smart_product_tracker/featuers/home/data/repositories/product_repository_impl.dart';
import 'package:smart_product_tracker/featuers/home/domain/repositories/product_repository.dart';
import 'package:smart_product_tracker/featuers/home/domain/usecases/fetch_products_usecase.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // ✅ تسجيل FirebaseFirestore مرة واحدة فقط
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // ✅ تسجيل Hive Box
  sl.registerLazySingleton<Box<ProductModel>>(() => Hive.box<ProductModel>('productsBox'));

  // ✅ تسجيل Network Info
  sl.registerLazySingleton<DataConnectionChecker>(() => DataConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // ✅ تسجيل DataSources
  sl.registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSourceImpl(sl<FirebaseFirestore>()));
  sl.registerLazySingleton<ProductLocalDataSource>(() => ProductLocalDataSourceImpl(sl<Box<ProductModel>>()));

  // ✅ تسجيل Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()),
  );

  // ✅ تسجيل UseCases
  sl.registerLazySingleton(() => FetchProductsUseCase(sl()));

  // ✅ تسجيل Cubits
  sl.registerFactory(() => HomeCubit(sl()));

  // ✅ تسجيل أي كاش Helper
  sl.registerSingleton<CacheHelper>(CacheHelper());
}
