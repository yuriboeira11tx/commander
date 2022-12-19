import 'package:commander/components/command/command_card.dart';
import 'package:commander/controllers/command_controller.dart';
import 'package:flutter/material.dart';

class CommandTab extends StatefulWidget {
  const CommandTab({
    super.key,
  });

  @override
  State<CommandTab> createState() => _CommandTabState();
}

class _CommandTabState extends State<CommandTab> {
  CommandController commandController = CommandController();

  @override
  void initState() {
    super.initState();
    commandController.fetchCommands();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => await commandController.fetchCommands(),
      child: AnimatedBuilder(
        animation: Listenable.merge([
          commandController.commands,
          commandController.isLoading,
        ]),
        builder: ((context, child) {
          if (commandController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: commandController.commands.value.length,
              itemBuilder: (context, index) {
                return CommandCard(
                  command: commandController.commands.value[index],
                );
              },
            );
          }
        }),
      ),
    );
  }
}
