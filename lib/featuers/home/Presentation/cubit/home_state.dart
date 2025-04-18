// HomeState
import 'package:smart_product_tracker/featuers/home/domain/entities/product_entity.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ProductEntity> products;
  HomeLoaded(this.products);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
