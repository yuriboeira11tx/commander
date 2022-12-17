import 'dart:developer';
import 'package:commander/auth/login/login_credentials.dart';
import 'package:commander/pages/auth/register/register_page.dart';
import 'package:commander/pages/home_page.dart';
import 'package:commander/repositories/account_repository.dart';
import 'package:commander/utils/styles.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final credential = LoginCredential();
  final accountRepository = AccountRepository();

  Future<void> _login() async {
    var response = await accountRepository.loginAccount(
      email: credential.email.value,
      pass: credential.password.value,
    );

    log(response.message ?? response.toString());

    if (response.isSuccess) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Image.asset("assets/logo/logotipo.jpg"),
                  ),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: credential.setEmail,
                  validator: (value) => credential.email.validate(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: credential.setPassword,
                  validator: (value) => credential.password.validate(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Senha',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final validate = credential.validate();

                    if (validate == null) {
                      await _login();
                    } else {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      final snackBar = SnackBar(
                        content: Text(
                          validate,
                          style: styleTextSnackbar,
                        ),
                        backgroundColor: colorPrimarySwatch,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text(
                    "ENTRAR",
                    style: styleTextButton,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const RegisterPage(),
            ),
          );
        },
        child: const Icon(
          Icons.person_add,
          color: colorTitle,
        ),
      ),
    );
  }
}
