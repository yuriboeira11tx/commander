import 'package:commander/auth/register/register_credential.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final credential = RegisterCredential();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conta"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                  const SizedBox(height: 20),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: credential.setLastname,
                    validator: (value) => credential.lastname.validate(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Último Nome',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: credential.setPhone,
                    validator: (value) => credential.phone.validate(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Telefone',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: credential.setEmail,
                    validator: (value) => credential.email.validate(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'E-mail',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: credential.setPassword,
                    validator: (value) => credential.password.validate(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Senha',
                    ),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        width: 1,
                        color: Colors.green,
                      ),
                    ),
                    onPressed: () async {
                      final validate = credential.validate();

                      if (validate == null) {
                        /*var response = await userRepository.editAccount(
                          User(
                            email: credential.email.value,
                            firstName: credential.firstname.value,
                            lastName: credential.lastname.value,
                            password: credential.password.value,
                            phone: credential.phone.value,
                          ),
                        );

                        print(response);*/
                      } else {
                        final snackBar = SnackBar(
                          content: Text(validate),
                          backgroundColor: Colors.green,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: const Text("Atualizar"),
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
