import 'dart:developer';

import 'package:commander/models/result.dart';
import 'package:commander/stores/account_store.dart';
import 'package:commander/utils/check_internet.dart';
import 'package:commander/utils/urls.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class ApiRepository {
  final dio = Dio();

  Future<dynamic> getCommands() async {
    log("Get commands");

    if (!(await withInternet())) return Result();
    try {
      final jwt = JWT({
        "email": GetIt.I<AccountStore>().currentAuth.getEmail(),
      });

      var response = await dio.post(
        urlGetOpenedOrders,
        options: Options(contentType: Headers.jsonContentType),
        data: {
          "jwt": jwt.sign(
            SecretKey(GetIt.I<AccountStore>().currentAuth.getAuthToken()),
          ),
        },
      );

      if (response.statusCode == 200) {
        try {
          final jwt = JWT.verify(
            response.data,
            SecretKey(GetIt.I<AccountStore>().currentAuth.getAuthToken()),
          );

          log('Payload: ${jwt.payload}');

          /*Map<String, dynamic> charging = <String, dynamic>{
            "id": jwt.payload["id"],
            "charger": jwt.payload["charger"],
            "connector": jwt.payload["connector"],
          };*/

          return {};
        } on JWTExpiredError {
          log('jwt expired');
        } on JWTError catch (ex) {
          log(ex.message);
        }
      }
    } on DioError catch (e) {
      log("${e.message}");
      log("${e.response!.data["detail"]}");
      throw Exception("Problema em getOrders()");
    }

    return Result();
  }
}
