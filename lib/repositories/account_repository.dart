import 'dart:developer';
import 'package:commander/models/account.dart';
import 'package:commander/models/auth.dart';
import 'package:commander/models/result.dart';
import 'package:commander/stores/account_store.dart';
import 'package:commander/utils/check_internet.dart';
import 'package:commander/utils/urls.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class AccountRepository {
  final dio = Dio();

  Future<Result> createAccount({
    required Account newAccount,
  }) async {
    log("[LOG] Create new account...");

    if (!(await withInternet())) return Result();
    try {
      var response = await dio.post(
        urlRegister,
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: {
          "first_name": newAccount.firstName,
          "last_name": newAccount.lastName,
          "email": newAccount.email,
          "password": newAccount.password,
          "phone": newAccount.phone,
        },
      );

      if (response.statusCode == 200) {
        return Result(message: "Conta criada com sucesso");
      }
    } on DioException catch (e) {
      log("[LOG] ${e.message}");
      return Result(
        message: e.response!.data["detail"],
        exception: e,
      );
    }

    return Result();
  }

  Future<Result> loginAccount({
    required String email,
    required String pass,
  }) async {
    log("[LOG] Signing...");

    if (!(await withInternet())) return Result();
    try {
      var response = await dio.post(
        urlLogin,
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: {
          "email": email,
          "password": pass,
        },
      );

      if (response.statusCode == 200) {
        Auth newAuth = Auth();
        newAuth.setFirstname(response.data["first_name"].toString());
        newAuth.setLastname(response.data["last_name"].toString());
        newAuth.setEmail(response.data["email"].toString());
        newAuth.setAuthToken(response.data["auth_token"].toString());
        newAuth.setRecoveryToken(response.data["recovery_token"].toString());
        newAuth.setExpiration(DateTime.now()
            .add(Duration(seconds: response.data["expiration"]))
            .toString());

        await GetIt.I<AccountStore>().login(newAuth);
        return Result(message: "Login efetuado");
      }
    } on DioException catch (e) {
      log("[LOG] ${e.message}");
      return Result(
        message: e.response!.data["detail"],
        exception: e,
      );
    }

    return Result();
  }

  Future<Map<String, dynamic>> renewTokens(Auth currentAuth) async {
    log("Get new tokens");

    if (!(await withInternet())) return <String, dynamic>{};
    try {
      final jwtSend = JWT({
        "email": currentAuth.getEmail(),
        "recovery_token": currentAuth.getRecoveryToken(),
      });

      var response = await dio.post(
        urlRenewTokens,
        options: Options(contentType: Headers.jsonContentType),
        data: {
          "jwt": jwtSend.sign(
            SecretKey(currentAuth.getAuthToken()),
            noIssueAt: true,
          ),
        },
      );

      if (response.statusCode == 200) {
        try {
          final jwt = JWT.verify(
            response.data,
            SecretKey(currentAuth.getAuthToken()),
          );

          log('Payload: ${jwt.payload}');

          Map<String, dynamic> newTokens = <String, dynamic>{
            "auth_token": jwt.payload["auth_token"].toString(),
            "recovery_token": jwt.payload["recovery_token"].toString(),
            "expiration": DateTime.now()
                .add(Duration(seconds: jwt.payload["expiration"]))
                .toString(),
          };

          return newTokens;
        } on JWTExpiredException {
          log('jwt expired');
        } on JWTException catch (ex) {
          log(ex.message);
        }
      }
    } on DioException catch (e) {
      log(e.message!);
      throw Exception("Problema em renewTokens()");
    }

    return <String, dynamic>{};
  }
}
