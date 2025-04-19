import 'package:smart_product_tracker/featuers/alerts/data/datasources/alert_remote_data_source_impl.dart';
import 'package:smart_product_tracker/featuers/alerts/data/models/price_alert_model.dart';
import 'package:smart_product_tracker/featuers/alerts/domain/entities/alert_entity.dart';
import 'package:smart_product_tracker/featuers/alerts/domain/repositories/alert_repository.dart';

class AlertRepositoryImpl implements AlertRepository {
  final AlertRemoteDataSource remoteDataSource;
  final String userId;

  AlertRepositoryImpl({required this.remoteDataSource, required this.userId});

  @override
  Future<void> addAlert(PriceAlert alert) {
    final model = PriceAlertModel(productId: alert.productId, targetPrice: alert.targetPrice);
    return remoteDataSource.addAlert(userId, model);
  }

  @override
  Future<void> deleteAlert(String productId) {
    return remoteDataSource.deleteAlert(userId, productId);
  }

  @override
  Future<List<PriceAlert>> getAllAlerts() {
    return remoteDataSource.getAllAlerts(userId);
  }
}
