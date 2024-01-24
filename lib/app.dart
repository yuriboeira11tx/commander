import 'package:commander/pages/auth/login/login_page.dart';
import 'package:commander/pages/home_page.dart';
import 'package:commander/utils/styles.dart';
import 'package:commander/utils/enums.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.statusAuth,
  });
  final Enum statusAuth;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Commander',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: colorTitle,
          ),
        ),
      ),
      home: widget.statusAuth == StatusAuth.authenticated
          ? const HomePage()
          : const LoginPage(),
    );
  }
}
