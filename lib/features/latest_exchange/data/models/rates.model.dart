import 'package:izi_money/features/latest_exchange/domain/entities/rates.entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rates.model.g.dart';

@JsonSerializable()
class RatesModel extends Rates {
  RatesModel({
    double? BRL,
    double? BTC,
    double? CLP,
    int? EUR,
    double? MXN,
    double? USD,
  }) : super(
          BRL: BRL,
          BTC: BTC,
          CLP: CLP,
          EUR: EUR,
          MXN: MXN,
          USD: USD,
        );

  factory RatesModel.fromJson(Map<String, dynamic> json) =>
      _$RatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatesModelToJson(this);

  factory RatesModel.fromRates(Rates rates) {
    return RatesModel(
      USD: rates.USD,
      MXN: rates.MXN,
      EUR: rates.EUR,
      CLP: rates.CLP,
      BTC: rates.BTC,
      BRL: rates.BRL,
    );
  }
}
