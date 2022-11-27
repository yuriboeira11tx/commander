import 'dart:developer';
import 'package:commander/app.dart';
import 'package:commander/splash.dart';
import 'package:commander/stores/account_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void setupLocators() {
  GetIt.I.registerSingleton(AccountStore());
}

Future<Enum> getStatusAuth() async {
  final accountStore = GetIt.I<AccountStore>();

  // inicializar preferencias do usuario
  await accountStore.init();

  // verificar status do usuario
  Enum response = await accountStore.verifyAuth();
  log("$response");

  return response;
}

void main() async {
  // tela de carregamento
  runApp(const SplashPage());

  // preparando singletons antes da inicializacao do app
  setupLocators();

  // verificacao de autenticacao
  Enum statusAuth = await getStatusAuth();
  runApp(
    App(statusAuth: statusAuth),
  );
}
