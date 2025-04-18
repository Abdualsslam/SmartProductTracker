import 'package:dartz/dartz.dart';
import 'package:smart_product_tracker/core/errors/failure.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetAllProductsUseCase {
  final ProductRepository repository;

  GetAllProductsUseCase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call() {
    return repository.getAllProducts();
  }
}
