import 'package:izi_money/features/latest_exchange/domain/entities/latest_exchange.entity.dart';
import 'package:izi_money/features/latest_exchange/domain/repositories/latest.repository.dart';

abstract class ISaveLocalCurrenciesUseCase {
  Future<LatestExchange> call(LatestExchange exchange);
}

class SaveLatestUseCase extends ISaveLocalCurrenciesUseCase {
  final ILatestRepository repository;

  SaveLatestUseCase(this.repository);

  @override
  Future<LatestExchange> call(LatestExchange exchange) =>
      repository.saveLocalCurrencies(exchange);
}
