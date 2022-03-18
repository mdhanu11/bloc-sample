import 'package:bloc_example/data/repository/product_provider.dart';

import '../model/product.dart';

class ApiRepository {
  final _productProvider = ProductProvider();

  Future<List<Product>> getProducts() async {
    return _productProvider.getProducts();
  }
}

class NetworkError extends Error {}
