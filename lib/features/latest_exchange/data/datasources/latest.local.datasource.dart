import 'dart:convert';

import 'package:izi_money/core/storage/local_storage.dart';
import 'package:izi_money/features/latest_exchange/data/models/latest_exchange.model.dart';

abstract class ILatestLocalDataSource {
  Future<LatestExchangeModel?> getLatestExchange();

  Future<LatestExchangeModel> saveLocalCurrencies(
    LatestExchangeModel latestExchangeModel,
  );

  Future<bool> clearLocalCurrencies();
}

class LatestLocalDataSource extends ILatestLocalDataSource {
  final String _latestKey = 'LATEST_CACHE_KEY';

  final LocalStorage storage;

  LatestLocalDataSource({required this.storage});

  @override
  Future<LatestExchangeModel?> getLatestExchange() async {
    final storageString = await storage.load(_latestKey);

    if (storageString == null) return null;

    final storageJson = jsonDecode(storageString);

    return LatestExchangeModel.fromJson(storageJson);
  }

  @override
  Future<LatestExchangeModel> saveLocalCurrencies(
      LatestExchangeModel latestExchangeModel) async {
    await storage.save(_latestKey, jsonEncode(latestExchangeModel));

    return latestExchangeModel;
  }

  @override
  Future<bool> clearLocalCurrencies() async => await storage.remove(_latestKey);
}
