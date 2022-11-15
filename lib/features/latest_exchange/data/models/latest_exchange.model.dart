import 'package:izi_money/features/latest_exchange/data/models/rates.model.dart';
import 'package:izi_money/features/latest_exchange/domain/entities/latest_exchange.entity.dart';

class LatestExchangeModel extends LatestExchange {
  LatestExchangeModel({
    bool? success,
    String? base,
    String? date,
    RatesModel? rates,
  }) : super(
          success: success,
          base: base,
          date: date,
          rates: rates,
        );

  LatestExchangeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    base = json['base'];
    date = json['date'];
    rates = json['rates'] != null
        ? RatesModel.fromJson(json['rates'])
        : RatesModel();
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'base': base,
      'date': date,
      'rates': rates,
    };
  }

  factory LatestExchangeModel.fromLatestExchange(
    LatestExchange latestExchange,
  ) {
    return LatestExchangeModel(
      success: latestExchange.success,
      base: latestExchange.base,
      date: latestExchange.date,
      rates: RatesModel.fromRates(latestExchange.rates),
    );
  }
}
