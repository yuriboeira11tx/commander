import 'dart:developer';
import 'dart:io';

Future<bool> withInternet() async {
  log("Check internet connection");

  try {
    final response = await InternetAddress.lookup('digitalli-iot.com.br');

    if (response.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException {
    log("Without internet");
    return false;
  }
}
