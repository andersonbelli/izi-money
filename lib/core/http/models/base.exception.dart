abstract class BaseException implements Exception {
  final int? statusCode;
  final String message;

  const BaseException(this.message, {this.statusCode});

  @override
  String toString() => message;
}
