import 'package:commander/components/command_card.dart';
import 'package:commander/controllers/command_controller.dart';
import 'package:commander/models/command.dart';
import 'package:flutter/material.dart';

class CommandTab extends StatefulWidget {
  const CommandTab({
    super.key,
  });

  @override
  State<CommandTab> createState() => _CommandTabState();
}

class _CommandTabState extends State<CommandTab> {
  List commands = [];
  CommandController commandController = CommandController();

  @override
  void initState() {
    super.initState();
    commands = getCommands();
    commandController.fetchCommands();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: commands.length,
      itemBuilder: (context, index) {
        return CommandCard(command: commands[index]);
      },
    );
  }
}

List getCommands() {
  return [
    Command(
      id: "4343",
      title: "#4343 - José Das Quantas",
      request: ["1x Coca-Cola Lata Zero", "2x Brahma"],
    ),
    Command(
      id: "4444",
      title: "#4444 - José Das Poucas",
      request: ["1x Batata Frita G", "1x Coca-Cola 1L", "3x Heinekens Long"],
    ),
  ];
}
