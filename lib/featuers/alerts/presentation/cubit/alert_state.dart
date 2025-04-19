import 'package:equatable/equatable.dart';
import 'package:smart_product_tracker/featuers/alerts/domain/entities/alert_entity.dart';

abstract class AlertState extends Equatable {
  const AlertState();

  @override
  List<Object> get props => [];
}

class AlertInitial extends AlertState {}

class AlertLoading extends AlertState {}

class AlertLoaded extends AlertState {
  final List<PriceAlert> alerts;

  const AlertLoaded(this.alerts);

  @override
  List<Object> get props => [alerts];
}

class AlertError extends AlertState {
  final String message;

  const AlertError(this.message);

  @override
  List<Object> get props => [message];
}
