import 'package:izi_money/features/latest_exchange/data/models/rates.model.dart';
import 'package:izi_money/features/latest_exchange/domain/entities/latest_exchange.entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'latest_exchange.model.g.dart';

@JsonSerializable(explicitToJson: true)
class LatestExchangeModel extends LatestExchange {
  final RatesModel ratesModel;

  LatestExchangeModel({
    required bool success,
    required String base,
    required String date,
    required this.ratesModel,
  }) : super(
          success: success,
          base: base,
          date: date,
          rates: ratesModel,
        );

  factory LatestExchangeModel.fromJson(Map<String, dynamic> json) =>
      _$LatestExchangeModelFromJson(json);

  Map<String, dynamic> toJson() => _$LatestExchangeModelToJson(this);

  factory LatestExchangeModel.fromLatestExchange(
    LatestExchange latestExchange,
  ) {
    return LatestExchangeModel(
      success: latestExchange.success,
      base: latestExchange.base,
      date: latestExchange.date,
      ratesModel: RatesModel.fromRates(latestExchange.rates),
    );
  }
}
