import 'package:commander/components/command_card.dart';
import 'package:commander/models/command.dart';
import 'package:flutter/material.dart';

class ChecklistTab extends StatefulWidget {
  const ChecklistTab({super.key});

  @override
  State<ChecklistTab> createState() => _ChecklistTabState();
}

class _ChecklistTabState extends State<ChecklistTab> {
  List commands = [];

  @override
  void initState() {
    super.initState();
    commands = getCommands();
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
