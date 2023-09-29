import 'package:flutter_test/flutter_test.dart';
import 'package:izi_money/features/latest_exchange/data/models/latest_exchange.model.dart';
import 'package:izi_money/features/latest_exchange/data/models/rates.model.dart';

import '../../mock_latest_exchange.model.dart';
import '../../mock_rates.model.dart';

void main() {
  final response = MockLatestExchangeModel.mock.toJson();

  group('LatestExchangeModel test', () {
    test('LatestExchangeModel parse test', () async {
      expect(
          LatestExchangeModel.fromJson(response), isA<LatestExchangeModel>());
    });

    test('LatestExchangeModel base is a String', () async {
      expect(LatestExchangeModel.fromJson(response).base, 'EUR');
      expect(LatestExchangeModel.fromJson(response).base, isA<String>);
    });

    test('LatestExchangeModel success is a bool', () async {
      expect(LatestExchangeModel.fromJson(response).success, true);
      expect(LatestExchangeModel.fromJson(response).success, isA<bool>);
    });

    test('LatestExchangeModel date is a String date', () async {
      expect(LatestExchangeModel.fromJson(response).date, '2022-11-15');
      expect(LatestExchangeModel.fromJson(response).date, isA<String>);
    });

    test('LatestExchangeModel rates is a RatesModel instance',
        () async {
      expect(LatestExchangeModel.fromJson(response).rates, MockRatesModel.mock);
      expect(LatestExchangeModel.fromJson(response).rates, isA<RatesModel>);
    });
  });
}
