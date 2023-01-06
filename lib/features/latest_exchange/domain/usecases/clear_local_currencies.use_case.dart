import 'package:izi_money/features/latest_exchange/domain/repositories/latest.repository.dart';

abstract class IClearLocalCurrenciesUseCase {
  Future<bool> call();
}

class ClearLocalCurrenciesUseCase extends IClearLocalCurrenciesUseCase {
  final ILatestRepository repository;

  ClearLocalCurrenciesUseCase(this.repository);

  @override
  Future<bool> call() => repository.clearLocalCurrencies();
}
