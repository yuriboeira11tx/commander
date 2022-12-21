import 'package:commander/components/command/command_detail_tab.dart';
import 'package:commander/components/product/products_add_tab.dart';
import 'package:commander/models/command.dart';
import 'package:commander/utils/styles.dart';
import 'package:flutter/material.dart';

class CommandPage extends StatefulWidget {
  const CommandPage({
    super.key,
    required this.command,
  });
  final Command command;

  @override
  State<CommandPage> createState() => _CommandPageState();
}

class _CommandPageState extends State<CommandPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  color: colorPrimarySwatch,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "#${widget.command.commandIdentifier} - ${widget.command.client}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: colorTitle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.shopping_cart_checkout,
                        color: colorPrimarySwatch,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: colorPrimarySwatch,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      // account settings
                      CommandDetailTab(command: widget.command),

                      // produtos
                      ProductsAddTab(command: widget.command),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
