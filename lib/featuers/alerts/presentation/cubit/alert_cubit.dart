import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_product_tracker/featuers/alerts/domain/entities/alert_entity.dart';
import 'package:smart_product_tracker/featuers/alerts/domain/usecases/delete_alert_usecase.dart';
import 'package:smart_product_tracker/featuers/alerts/domain/usecases/get_alerts_usecase.dart';
import 'package:smart_product_tracker/featuers/alerts/domain/usecases/set_price_alert_usecase.dart';
import 'package:smart_product_tracker/featuers/alerts/presentation/cubit/alert_state.dart';

class AlertCubit extends Cubit<AlertState> {
  final AddAlertUseCase addAlert;
  final DeleteAlertUseCase deleteAlert;
  final GetAllAlertsUseCase getAllAlerts;

  AlertCubit({required this.addAlert, required this.deleteAlert, required this.getAllAlerts}) : super(AlertInitial());

  Future<void> fetchAlerts() async {
    emit(AlertLoading());
    final result = await getAllAlerts.call();

    result.fold((failure) => emit(AlertError("Failed to load alerts")), (alerts) => emit(AlertLoaded(alerts)));
  }

  Future<void> addPriceAlert(PriceAlert alert) async {
    await addAlert.call(alert);
    fetchAlerts();
  }

  Future<void> deletePriceAlert(String productId) async {
    await deleteAlert.call(productId);
    fetchAlerts();
  }
}
