import 'package:izi_money/features/latest_exchange/data/models/rates.model.dart';

abstract class MockRatesModel {
  static final RatesModel mock = RatesModel(
    bRL: 5.506377,
    bTC: 0.000062,
    cLP: 920.346155,
    eUR: 1,
    mXN: 19.954985,
    uSD: 1.033599,
  );
}
