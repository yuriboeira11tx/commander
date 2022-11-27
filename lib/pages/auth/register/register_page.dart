import 'dart:developer';
import 'package:commander/auth/register/register_credential.dart';
import 'package:commander/models/account.dart';
import 'package:commander/repositories/account_repository.dart';
import 'package:commander/utils/styles.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final credential = RegisterCredential();
  final accountRepository = AccountRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cadastro",
          style: styleTextDefault,
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: credential.setFirstname,
                    validator: (value) => credential.firstname.validate(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Primeiro Nome',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: credential.setLastname,
                    validator: (value) => credential.lastname.validate(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Último Nome',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: credential.setPhone,
                    validator: (value) => credential.phone.validate(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Telefone',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                        var response = await accountRepository.createAccount(
                          newAccount: Account(
                            email: credential.email.value,
                            firstName: credential.firstname.value,
                            lastName: credential.lastname.value,
                            password: credential.password.value,
                            phone: credential.phone.value,
                          ),
                        );

                        log(response.message.toString());
                      } else {
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
                      "CADASTRAR",
                      style: styleTextButton,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
