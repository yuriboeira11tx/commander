import 'dart:developer';

import 'package:commander/models/command.dart';
import 'package:commander/models/product.dart';
import 'package:commander/repositories/api_repository.dart';
import 'package:flutter/material.dart';

class ProductsAddController extends ChangeNotifier {
  final apiRepository = ApiRepository();
  ValueNotifier<List<Product>> products = ValueNotifier([]);
  ValueNotifier<List<Map<String, dynamic>>> productsToSend = ValueNotifier([]);
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<bool> isAdd = ValueNotifier(false);
  ValueNotifier<int> quantity = ValueNotifier(0);

  void updateProductsSelected(int id, int quantity, String obs) {
    // adicionando caso exista e adicionando
    final index = productsToSend.value.indexWhere((e) => e["product_id"] == id);
    if (index != -1) {
      productsToSend.value[index]["quantity"] = quantity;
      productsToSend.value[index]["obs"] = obs;
    } else {
      productsToSend.value.add(
        {
          "product_id": id,
          "quantity": quantity,
          "obs": obs,
        },
      );
    }

    // remover produtos com quantidade 0
    final indexToRemove =
        productsToSend.value.indexWhere((e) => e["quantity"] == 0);
    if (indexToRemove != -1) {
      productsToSend.value.removeAt(indexToRemove);
    }

    log("${productsToSend.value.toString()}");
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

  Future<void> sendOrders(Command command) async {
    isAdd.value = true;

    var response = await apiRepository.addOrder(
      command: command,
      orders: productsToSend.value,
    );

    isAdd.value = false;
    productsToSend.value.clear();
    
    isAdd.notifyListeners();
    productsToSend.notifyListeners();
  }
}
