class Result {
  String? message;
  Exception? exception;

  Result({
    this.message,
    this.exception,
  });

  bool get isSuccess => (exception == null && message != null);
}
