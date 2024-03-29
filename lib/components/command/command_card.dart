import 'package:commander/models/command.dart';
import 'package:commander/pages/command_page.dart';
import 'package:commander/utils/styles.dart';
import 'package:flutter/material.dart';

class CommandCard extends StatefulWidget {
  const CommandCard({
    super.key,
    required this.command,
  });
  final Command command;

  @override
  State<CommandCard> createState() => _CommandCardState();
}

class _CommandCardState extends State<CommandCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CommandPage(
              command: widget.command,
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 6,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xE4404B60),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            leading: Container(
              padding: const EdgeInsets.only(
                right: 12.0,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 1.0,
                    color: Colors.white24,
                  ),
                ),
              ),
              child: const Icon(
                Icons.notes,
                color: Colors.white,
              ),
            ),
            title: Text(
              "#${widget.command.commandIdentifier!} - ${widget.command.client!}",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              children: [
                Wrap(
                  children: widget.command.orders!.map((word) {
                    return Chip(
                      backgroundColor: Colors.white,
                      label: Row(
                        children: [
                          const Icon(
                            Icons.timer,
                          ),
                          Text(
                            "$word",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorPrimarySwatch,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                Wrap(
                  children: widget.command.delivered!.map((word) {
                    return Chip(
                      backgroundColor: Colors.white,
                      label: Row(
                        children: [
                          const Icon(
                            Icons.check_box,
                            color: Colors.green,
                          ),
                          Text(
                            "$word",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: colorPrimarySwatch,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ),
      ),
    );
  }
}
