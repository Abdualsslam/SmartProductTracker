import 'package:dartz/dartz.dart';
import 'package:smart_product_tracker/core/errors/failure.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
}
