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
                            "${widget.command.client}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white,
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
                        Icons.shopping_cart,
                        color: Colors.deepPurple,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.shopping_cart_checkout,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      // cheecklist
                      ListView.builder(
                        itemCount: StringResource.items.length,
                        itemBuilder: (_, index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                StringResource.items[index],
                                style: const TextStyle(color: Colors.red),
                              ),
                              subtitle: Text(
                                'Preço: R\$${StringResource.price[index]}',
                                style: TextStyle(
                                  color: Colors.blue[450],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              leading: Image.network(
                                  "https://www.imagensempng.com.br/wp-content/uploads/2022/01/2442.png"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {},
                                  ),
                                  const Text("0"),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      // account settings
                      Container(
                        child: const Center(
                          child: Text(
                            "COMANDA ATUAL",
                          ),
                        ),
                      ),
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

class StringResource {
  static const List<String> items = [
    'Coca-Cola',
    'Heinken',
    'Cupcake',
    'Gingerbread',
    'JellyBean'
  ];

  static const List<int> price = [13, 12, 10, 10, 15];
}
