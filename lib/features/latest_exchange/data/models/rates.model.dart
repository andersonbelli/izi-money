import 'package:izi_money/features/latest_exchange/domain/entities/rates.entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rates.model.g.dart';

@JsonSerializable()
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

  factory RatesModel.fromJson(Map<String, dynamic> json) =>
      _$RatesModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatesModelToJson(this);

  factory RatesModel.fromRates(Rates rates) {
    return RatesModel(
      uSD: rates.uSD,
      mXN: rates.mXN,
      eUR: rates.eUR,
      cLP: rates.cLP,
      bTC: rates.bTC,
      bRL: rates.bRL,
    );
  }
}
