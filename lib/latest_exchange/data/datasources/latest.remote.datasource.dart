import 'package:izi_money/core/http/http_manager.dart';
import 'package:izi_money/core/utils/server_config.dart';
import 'package:izi_money/latest_exchange/data/models/latest_exchange.model.dart';

abstract class ILatestDataSource {
  Future<LatestExchangeModel> getLatest();
}

class LatestDataSource extends ILatestDataSource {
  final HttpManager http;

  LatestDataSource({required this.http});

  @override
  Future<LatestExchangeModel> getLatest() async {
    final response = await http.get(ServerConfig.LATEST_ENDPOINT);

    return LatestExchangeModel.fromJson(response);
  }
}
