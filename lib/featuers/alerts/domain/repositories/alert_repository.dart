import 'package:smart_product_tracker/featuers/alerts/domain/entities/alert_entity.dart';

abstract class AlertRepository {
  Future<void> addAlert(PriceAlert alert);
  Future<void> deleteAlert(String productId);
  Future<List<PriceAlert>> getAllAlerts();
}
