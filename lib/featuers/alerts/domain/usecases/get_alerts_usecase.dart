import 'package:dartz/dartz.dart';
import 'package:smart_product_tracker/core/errors/failure.dart';
import 'package:smart_product_tracker/featuers/alerts/domain/entities/alert_entity.dart';
import 'package:smart_product_tracker/featuers/alerts/domain/repositories/alert_repository.dart';

class GetAllAlertsUseCase {
  final AlertRepository repository;

  GetAllAlertsUseCase(this.repository);

  Future<Either<Failure, List<PriceAlert>>> call() => repository.getAllAlerts();
}
