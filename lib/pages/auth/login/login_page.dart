import 'dart:developer';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:commander/auth/login/login_credentials.dart';
import 'package:commander/pages/auth/register/register_page.dart';
import 'package:commander/pages/home_page.dart';
import 'package:commander/repositories/account_repository.dart';
import 'package:commander/utils/styles.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final credential = LoginCredential();
  final accountRepository = AccountRepository();
  bool isLoginLoading = false;

  void loginLoading(bool newValue) {
    if (!mounted) return;
    setState(() {
      isLoginLoading = newValue;
    });
  }

  Future<void> _login() async {
    loginLoading(true);

    await accountRepository
        .loginAccount(
      email: credential.email.value,
      pass: credential.password.value,
    )
        .then((value) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
        (route) => false,
      );
    }).catchError((onError) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Login',
        desc: 'Não foi possível fazer login\n${onError.toString()}',
        btnCancelOnPress: () {},
        btnCancelText: "OK",
      ).show();
    });

    loginLoading(false);
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
                  textInputAction: TextInputAction.next,
                  validator: (value) => credential.email.validate(),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail',
                  ),
                ),
                const SizedBox(height: 20),
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
                Visibility(
                  visible: isLoginLoading,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                Visibility(
                  visible: !isLoginLoading,
                  child: FilledButton(
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
        ),
      ),
    );
  }
}
