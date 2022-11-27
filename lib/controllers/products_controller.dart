import 'package:commander/models/product.dart';
import 'package:commander/repositories/api_repository.dart';
import 'package:flutter/material.dart';

class ProductsController extends ChangeNotifier {
  final apiRepository = ApiRepository();
  ValueNotifier<List<Product>> products = ValueNotifier([]);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> fetchProducts() async {
    isLoading.value = true;
    var response = await apiRepository.getProducts();

    for (var product in response["data"]) {
      products.value.add(Product.fromJson(product));
    }

    isLoading.value = false;
    isLoading.notifyListeners();
    products.notifyListeners();
  }
}
