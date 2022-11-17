import 'package:flutter_test/flutter_test.dart';
import 'package:izi_money/features/latest_exchange/data/models/rates.model.dart';

import '../../mock_rates.model.dart';

void main() {
  final response = MockRatesModel.mock.toJson();

  group('RatesModel test', () {
    test('RatesModel parse test', () async {
      expect(RatesModel.fromJson(response), isA<RatesModel>());
    });

    test('RatesModel eUR have value 1 and is an integer', () async {
      expect(RatesModel.fromJson(response).eUR, 1);
      expect(RatesModel.fromJson(response).eUR, isA<int>);
    });

    test('RatesModel bRL have value 5.506377 and is a double', () async {
      expect(RatesModel.fromJson(response).bRL, 5.506377);
      expect(RatesModel.fromJson(response).bRL, isA<double>);
    });
  });
}
