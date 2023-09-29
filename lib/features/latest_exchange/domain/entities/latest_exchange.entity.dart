import 'package:izi_money/features/latest_exchange/domain/entities/rates.entity.dart';

class LatestExchange {
  final bool success;
  final String base;
  final String date;
  final Rates rates;

  const LatestExchange({
    required this.success,
    required this.base,
    required this.date,
    required this.rates,
  });
}
