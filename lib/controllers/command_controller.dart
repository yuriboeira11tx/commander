import 'package:commander/repositories/api_repository.dart';
import 'package:flutter/material.dart';

class CommandController extends ChangeNotifier {
  final apiRepository = ApiRepository();

  Future<void> fetchCommands() async {
    await apiRepository.getCommands();
  }
}
