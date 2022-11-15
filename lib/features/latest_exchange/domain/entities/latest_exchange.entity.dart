import 'package:izi_money/features/latest_exchange/domain/entities/rates.entity.dart';

class LatestExchange {
  bool? success;
  String? base;
  String? date;
  Rates? rates;

  LatestExchange({
    this.success,
    this.base,
    this.date,
    this.rates,
  });
}
