import 'package:izi_money/core/http/models/base.exception.dart';

class RequestFailException extends BaseException {
  RequestFailException({
    String message = 'Fail to request data :(',
    int? statusCode,
  }) : super(message, statusCode: statusCode);
}
