import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:izi_money/core/http/http_manager.dart';
import 'package:izi_money/core/http/models/generic.exception.dart';
import 'package:izi_money/core/http/models/request_fail.exception.dart';
import 'package:izi_money/core/utils/server_config.dart';

class DioImpl extends HttpManager {
  final Dio _dio = Dio(BaseOptions(baseUrl: ServerConfig.BASE_URL));

  @override
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);

      print('response --> ${response.data}');

      if (response.statusCode == 200) {
        return jsonDecode(jsonEncode(response.data));
      }

      throw GenericException(response.data.toString());
    } on DioError catch (e) {
      throw RequestFailException(message: e.message);
    }
  }
}
