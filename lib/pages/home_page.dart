import 'dart:developer';

import 'package:commander/components/command/command_tab.dart';
import 'package:commander/components/product/products_tab.dart';
import 'package:commander/models/command.dart';
import 'package:commander/pages/auth/login/login_page.dart';
import 'package:commander/pages/command_page.dart';
import 'package:commander/repositories/api_repository.dart';
import 'package:commander/stores/account_store.dart';
import 'package:commander/utils/styles.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController modalController = TextEditingController();
  final apiRepository = ApiRepository();

  void toLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
      (route) => false,
    );
  }

  Future<void> scanQR() async {
    try {
      String result = await FlutterBarcodeScanner.scanBarcode(
        "#f2b936",
        "CANCELAR",
        false,
        ScanMode.QR,
      );

      log(result);

      if (result == "-1") return;
      var response = await apiRepository.commandExists(id: int.parse(result));
      if (response.runtimeType != int) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CommandPage(
              command: Command(
                commandId: response["data"]["id"],
                client: response["data"]["client_identification"],
                commandIdentifier: response["data"]["identifier"],
                orders: [],
              ),
            ),
          ),
        );
      } else {
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          builder: (context) {
            bool isLoading = false;
            String errorMessage = "";

            return StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20, left: 8),
                        child: Text(
                          "Nova Comanda",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: errorMessage.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, left: 8),
                          child: Text(
                            errorMessage,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Nome do cliente",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: !isLoading
                                ? () async {
                                    if (!mounted) return;
                                    setState(() {
                                      isLoading = true;
                                      errorMessage = "";
                                    });

                                    int response =
                                        await apiRepository.createCommand(
                                      commandId: 10,
                                      clientId: modalController.text,
                                    );

                                    if (response == 200) {
                                      Navigator.pop(context);

                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Comanda Criada'),
                                            content: const Text(
                                                'A comanda foi criada com sucesso!'),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      return;
                                    } else {
                                      if (!mounted) return;
                                      setState(() {
                                        errorMessage =
                                            "Não foi possível criar comanda no momento";
                                      });
                                    }

                                    if (!mounted) return;
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                : null,
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : const Text("Continuar"),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      }
    } catch (e) {
      log("$e");
    }
  }

  @override
  void dispose() {
    modalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Comandas Ativas",
            style: styleTextDefault,
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await GetIt.I<AccountStore>().logout();
                toLogin();
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
        body: Column(
          children: const [
            TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.checklist,
                    color: colorTitle,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: colorTitle,
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // commandlist
                  CommandTab(),

                  // productlist
                  ProductsTab(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => await scanQR(),
          child: const Icon(
            Icons.qr_code_scanner,
            color: colorTitle,
          ),
        ),
      ),
    );
  }
}
