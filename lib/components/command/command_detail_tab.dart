import 'package:commander/components/order/order_card.dart';
import 'package:commander/controllers/command_detail_controller.dart';
import 'package:commander/models/command.dart';
import 'package:flutter/material.dart';

class CommandDetailTab extends StatefulWidget {
  const CommandDetailTab({
    super.key,
    required this.command,
  });
  final Command command;

  @override
  State<CommandDetailTab> createState() => _CommandDetailTabState();
}

class _CommandDetailTabState extends State<CommandDetailTab> {
  CommandDetailController commandController = CommandDetailController();

  @override
  void initState() {
    super.initState();
    commandController.fetchCommandDetail(widget.command);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        commandController.order,
        commandController.isLoading,
      ]),
      builder: ((context, child) {
        if (commandController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return OrderCard(
            order: commandController.order.value,
          );
        }
      }),
    );
  }
}
