import 'dart:convert';

import 'package:bloc_example/data/model/product.dart';
import 'package:bloc_example/res/strings/strings.dart';
import 'package:http/http.dart' as http;

class ProductProvider {
  Future<List<Product>> getProducts() async {
    var url = Uri.parse(AppStrings.productsApi);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonArray = json.decode(response.body) as List;
      List<Product> products = [];
      for (var jsonObj in jsonArray) {
        Product product = Product.fromJson(jsonObj);
        products.add(product);
      }
      return products;
    } else {
      throw Exception();
    }
  }
}
