// HomeCubit
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_product_tracker/featuers/home/Presentation/cubit/home_state.dart';
import 'package:smart_product_tracker/featuers/home/domain/usecases/fetch_products_usecase.dart';

class HomeCubit extends Cubit<HomeState> {
  final FetchProductsUseCase fetchProductsUseCase;

  HomeCubit(this.fetchProductsUseCase) : super(HomeInitial());

  Future<void> fetchProducts() async {
    emit(HomeLoading());
    final result = await fetchProductsUseCase();
    result.fold((failure) => emit(HomeError(failure.toString())), (products) => emit(HomeLoaded(products)));
  }
}
