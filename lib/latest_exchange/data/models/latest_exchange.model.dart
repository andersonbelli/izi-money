import 'package:izi_money/latest_exchange/data/models/rates.model.dart';
import 'package:izi_money/latest_exchange/domain/entities/latest_exchange.entity.dart';

class LatestExchangeModel {
  bool? success;
  String? base;
  String? date;
  RatesModel? rates;

  LatestExchangeModel({this.success, this.base, this.date, this.rates});

  LatestExchangeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    base = json['base'];
    date = json['date'];
    rates = json['rates'] != null ? RatesModel.fromJson(json['rates']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['base'] = base;
    data['date'] = date;
    if (rates != null) {
      data['rates'] = rates!.toJson();
    }
    return data;
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
