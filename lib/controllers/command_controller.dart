import 'package:commander/models/command.dart';
import 'package:commander/repositories/api_repository.dart';
import 'package:flutter/material.dart';

class CommandController extends ChangeNotifier {
  final apiRepository = ApiRepository();
  ValueNotifier<List<Command>> commands = ValueNotifier([]);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> fetchCommands() async {
    isLoading.value = true;
    var response = await apiRepository.getCommands();

    for (var command in response["data"]) {
      commands.value.add(Command.fromJson(command));
    }

    isLoading.value = false;
    isLoading.notifyListeners();
    commands.notifyListeners();
  }
}
