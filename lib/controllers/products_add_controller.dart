import 'dart:developer';

import 'package:commander/models/product.dart';
import 'package:commander/repositories/api_repository.dart';
import 'package:flutter/material.dart';

class ProductsAddController extends ChangeNotifier {
  final apiRepository = ApiRepository();
  ValueNotifier<List<Product>> products = ValueNotifier([]);
  ValueNotifier<List<Map<String, dynamic>>> productsToSend = ValueNotifier([]);
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<int> quantity = ValueNotifier(0);

  void updateProductsSelected(int id, int quantity, String obs) {
    log("$id $quantity");
    if (quantity == 0) return;

    productsToSend.value.add(
      {
        "product_id": id,
        "quantity": quantity,
        "obs": obs,
      },
    );
    
    productsToSend.notifyListeners();
  }

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
