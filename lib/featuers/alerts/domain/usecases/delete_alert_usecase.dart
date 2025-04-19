import 'package:smart_product_tracker/featuers/alerts/domain/repositories/alert_repository.dart';

class DeleteAlertUseCase {
  final AlertRepository repository;

  DeleteAlertUseCase(this.repository);

  Future<void> call(String productId) => repository.deleteAlert(productId);
}
