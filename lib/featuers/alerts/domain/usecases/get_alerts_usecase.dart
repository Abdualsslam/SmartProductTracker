import 'package:smart_product_tracker/featuers/alerts/domain/entities/alert_entity.dart';
import 'package:smart_product_tracker/featuers/alerts/domain/repositories/alert_repository.dart';

class GetAllAlertsUseCase {
  final AlertRepository repository;

  GetAllAlertsUseCase(this.repository);

  Future<List<PriceAlert>> call() => repository.getAllAlerts();
}
