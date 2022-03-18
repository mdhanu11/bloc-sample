import 'package:bloc_example/bloc/product_bloc/product_event.dart';
import 'package:bloc_example/bloc/product_bloc/product_state.dart';
import 'package:bloc_example/data/repository/product_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/api_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ApiRepository _apiRepository = ApiRepository();

  ProductBloc() : super(ProductInitialState()) {
    on((event, emit) async {
      try {
        emit(ProductLoadingState());
        final products = await _apiRepository.getProducts();
        emit(ProductLoadedState(products));
      } catch (e) {
        ProductErrorState(message: e.toString());
      }
    });
  }
}
