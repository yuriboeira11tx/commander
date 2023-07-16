import 'dart:developer';
import 'package:commander/models/command.dart';
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

          return jwt.payload;
        } on JWTExpiredException {
          log('jwt expired');
        } on JWTException catch (ex) {
          log(ex.message);
        }
      }
    } on DioException catch (e) {
      log(e.message!);
      log("${e.response!.data["detail"]}");
      throw Exception("Problema em getOrders()");
    }

    return Result();
  }

  Future<dynamic> getProducts() async {
    log("Get products");

    if (!(await withInternet())) return Result();
    try {
      final jwt = JWT({
        "email": GetIt.I<AccountStore>().currentAuth.getEmail(),
      });

      var response = await dio.post(
        urlGetProducts,
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

          return jwt.payload;
        } on JWTExpiredException {
          log('jwt expired');
        } on JWTException catch (ex) {
          log(ex.message);
        }
      }
    } on DioException catch (e) {
      log(e.message!);
      log("${e.response!.data["detail"]}");
      throw Exception("Problema em getProducts()");
    }

    return Result();
  }

  Future<dynamic> getCommandDetail({
    required Command command,
  }) async {
    log("Get command detail");

    if (!(await withInternet())) return Result();
    try {
      final jwt = JWT({
        "email": GetIt.I<AccountStore>().currentAuth.getEmail(),
        "command_id": command.commandId,
      });

      var response = await dio.post(
        urlCommandDetail,
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

          return jwt.payload;
        } on JWTExpiredException {
          log('jwt expired');
        } on JWTException catch (ex) {
          log(ex.message);
        }
      }
    } on DioException catch (e) {
      log(e.message!);
      throw Exception("Problema em getCommandDetail()");
    }

    return Result();
  }

  Future<dynamic> commandExists({
    required int id,
  }) async {
    log("Get command detail");

    if (!(await withInternet())) return 0;
    try {
      final jwt = JWT({
        "email": GetIt.I<AccountStore>().currentAuth.getEmail(),
        "command_id": id,
      });

      var response = await dio.post(
        urlCommandDetail,
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

          return jwt.payload;
        } on JWTExpiredException {
          log('jwt expired');
        } on JWTException catch (ex) {
          log(ex.message);
        }
      }
    } on DioException catch (e) {
      log(e.message!);
      return e.response!.statusCode!;
    }

    return 0;
  }

  Future<dynamic> addOrder({
    required Command command,
    required List<Map<String, dynamic>> orders,
  }) async {
    log("Add order");

    if (!(await withInternet())) return Result();
    try {
      final jwt = JWT({
        "email": GetIt.I<AccountStore>().currentAuth.getEmail(),
        "command_id": command.commandId,
        "itens": orders,
      });

      var response = await dio.post(
        urlAddOrder,
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

          return jwt.payload;
        } on JWTExpiredException {
          log('jwt expired');
        } on JWTException catch (ex) {
          log(ex.message);
        }
      }
    } on DioException catch (e) {
      log(e.message!);
      log("${e.response!.data["detail"]}");
      throw Exception("Problema em getCommandDetail()");
    }

    return Result();
  }

  Future<int> createCommand({
    required int commandId,
    required String clientId,
  }) async {
    log("Create command");

    if (!(await withInternet())) return 0;
    try {
      final jwt = JWT({
        "email": GetIt.I<AccountStore>().currentAuth.getEmail(),
        "command_id": commandId,
        "client_id": clientId,
      });

      var response = await dio.post(
        urlCreateCommand,
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

          return 200;
        } on JWTExpiredException {
          log('jwt expired');
        } on JWTException catch (ex) {
          log(ex.message);
        }
      }
    } on DioException catch (e) {
      log(e.message!);
      log("${e.response!.data["detail"]}");
      return e.response!.statusCode!;
    }

    return 0;
  }
}
