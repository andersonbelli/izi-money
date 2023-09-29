import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:izi_money/core/http/http_manager.dart';
import 'package:izi_money/core/http/models/generic.exception.dart';
import 'package:izi_money/core/http/models/request_fail.exception.dart';
import 'package:izi_money/core/utils/server_config.dart';

class DioImpl extends HttpManager {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ServerConfig.BASE_URL,
      connectTimeout: 600,
    ),
  );

  DioImpl({bool mock = false}) : super(mock);

  @override
  Future get(String endpoint) async {
    if (mock) {
      log(
        '''⚠️ WARNING: You're in mock HTTP and a real value was not provided for this request ⚠️''',
      );

      return Future.value();
    }

    try {
      final response = await _dio.get(endpoint);

      if (response.statusCode == 200) {
        return jsonDecode(jsonEncode(response.data));
      }

      log(response.data);
      throw GenericException(response.data.toString());
    } on DioError catch (e) {
      log('DioError - ${e.message}');
      throw RequestFailException(message: e.message);
    }
  }
}
