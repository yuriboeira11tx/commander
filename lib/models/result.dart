import 'package:dio/dio.dart';

class Result {
  String? message;
  DioError? exception;

  Result({
    this.message,
    this.exception,
  });

  bool get isSuccess => (exception == null && message != null);
}
