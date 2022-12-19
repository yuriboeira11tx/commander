import 'dart:developer';

import 'package:commander/components/command/command_tab.dart';
import 'package:commander/components/product/products_tab.dart';
import 'package:commander/models/command.dart';
import 'package:commander/pages/auth/login/login_page.dart';
import 'package:commander/repositories/api_repository.dart';
import 'package:commander/stores/account_store.dart';
import 'package:commander/utils/styles.dart';
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

      var response = await apiRepository.getCommandDetail(
          command: Command(
        commandId: int.parse(result),
        commandIdentifier: 0,
        client: "client",
        orders: [],
      ));

      log("${response.runtimeType}");
    } catch (e) {
      log("$e");
    }

    /*await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      builder: (context) {
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
                    onPressed: () {},
                    child: const Text("Continuar"),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );*/
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
