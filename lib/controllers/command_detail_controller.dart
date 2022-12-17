import 'dart:developer';
import 'package:commander/models/command.dart';
import 'package:commander/models/order.dart';
import 'package:commander/repositories/api_repository.dart';
import 'package:flutter/material.dart';

class CommandDetailController extends ChangeNotifier {
  final apiRepository = ApiRepository();
  ValueNotifier<Order> order = ValueNotifier(
    Order(
      createdAt: DateTime.now(),
      id: 0,
      identifier: 0,
      orders: [],
    ),
  );
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> fetchCommandDetail(Command command) async {
    isLoading.value = true;

    try {
      var response = await apiRepository.getCommandDetail(command: command);
      order.value = Order.fromJson(response["data"]);
    } catch (e) {
      log("Error fetch command detail");
    }

    isLoading.value = false;
    isLoading.notifyListeners();
    order.notifyListeners();
  }
}
