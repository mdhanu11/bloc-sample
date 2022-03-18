import 'package:bloc_example/data/model/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ProductState extends Equatable {}

class ProductInitialState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoadedState extends ProductState {
  final List<Product> products;

  ProductLoadedState(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductErrorState extends ProductState {
  final String message;

  ProductErrorState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
