import 'package:commander/components/command_tab.dart';
import 'package:commander/components/products_tab.dart';
import 'package:commander/pages/auth/login/login_page.dart';
import 'package:commander/stores/account_store.dart';
import 'package:commander/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void toLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
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
          onPressed: () {},
          child: const Icon(
            Icons.qr_code_scanner,
            color: colorTitle,
          ),
        ),
      ),
    );
  }
}
