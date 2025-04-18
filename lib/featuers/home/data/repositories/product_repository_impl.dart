import 'package:dartz/dartz.dart';
import 'package:smart_product_tracker/core/connection/network_info.dart';
import 'package:smart_product_tracker/core/errors/failure.dart';
import 'package:smart_product_tracker/featuers/home/data/datasources/products_remote_data_source.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({required this.remoteDataSource, required this.localDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<ProductEntity>>> fetchProducts() async {
    try {
      if (await networkInfo.isConnected ?? false) {
        final remoteProducts = await remoteDataSource.fetchProducts();
        await localDataSource.cacheProducts(remoteProducts);
        return Right(remoteProducts);
      } else {
        final localProducts = await localDataSource.getCachedProducts();
        return Right(localProducts);
      }
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
