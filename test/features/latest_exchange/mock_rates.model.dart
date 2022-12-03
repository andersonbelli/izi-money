import 'package:izi_money/features/latest_exchange/data/models/rates.model.dart';

abstract class MockRatesModel {
  static final RatesModel mock = RatesModel(
    BRL: 5.506377,
    BTC: 0.000062,
    CLP: 920.346155,
    EUR: 1,
    MXN: 19.954985,
    USD: 1.033599,
  );
}
