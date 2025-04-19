import 'package:dartz/dartz.dart';
import 'package:smart_product_tracker/core/errors/failure.dart';
import 'package:smart_product_tracker/featuers/alerts/domain/entities/alert_entity.dart';

abstract class AlertRepository {
  Future<void> addAlert(PriceAlert alert);
  Future<void> deleteAlert(String productId);
  Future<Either<Failure, List<PriceAlert>>> getAllAlerts();
}
