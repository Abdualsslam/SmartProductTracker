import 'package:smart_product_tracker/featuers/alerts/data/models/price_alert_model.dart';

abstract class AlertRemoteDataSource {
  Future<void> addAlert(String userId, PriceAlertModel alert);
  Future<void> deleteAlert(String userId, String productId);
  Future<List<PriceAlertModel>> getAllAlerts(String userId);
}
