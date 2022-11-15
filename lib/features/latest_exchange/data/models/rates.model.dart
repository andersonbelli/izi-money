import 'package:izi_money/features/latest_exchange/domain/entities/rates.entity.dart';

class RatesModel extends Rates {
  RatesModel({
    double? bRL,
    double? bTC,
    double? cLP,
    int? eUR,
    double? mXN,
    double? uSD,
  }) : super(
          bRL: bRL,
          bTC: bTC,
          cLP: cLP,
          eUR: eUR,
          mXN: mXN,
          uSD: uSD,
        );

  RatesModel.fromJson(Map<String, dynamic> json) {
    bRL = double.tryParse(json['BRL'].toString());
    bTC = double.tryParse(json['BTC'].toString());
    cLP = double.tryParse(json['CLP'].toString());
    eUR = json['EUR'];
    mXN = double.tryParse(json['MXN'].toString());
    uSD = double.tryParse(json['USD'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['BRL'] = bRL;
    data['BTC'] = bTC;
    data['CLP'] = cLP;
    data['EUR'] = eUR;
    data['MXN'] = mXN;
    data['USD'] = uSD;
    return data;
  }

  factory RatesModel.fromRates(Rates? rates) {
    return RatesModel();
  }
}
