import 'package:izi_money/features/latest_exchange/data/models/latest_exchange.model.dart';

import 'mock_rates.model.dart';

abstract class MockLatestExchangeModel {
  static final LatestExchangeModel mock = LatestExchangeModel(
    success: true,
    base: 'EUR',
    date: '2022-11-15',
    ratesModel: MockRatesModel.mock,
  );
}
