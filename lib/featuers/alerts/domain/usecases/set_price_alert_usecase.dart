import 'package:smart_product_tracker/featuers/alerts/domain/entities/alert_entity.dart';
import 'package:smart_product_tracker/featuers/alerts/domain/repositories/alert_repository.dart';

class AddAlertUseCase {
  final AlertRepository repository;

  AddAlertUseCase(this.repository);

  Future<void> call(PriceAlert alert) => repository.addAlert(alert);
}
