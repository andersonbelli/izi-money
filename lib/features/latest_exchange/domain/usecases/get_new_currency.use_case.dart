import 'package:dartz/dartz.dart';
import 'package:izi_money/core/http/models/base.exception.dart';
import 'package:izi_money/features/latest_exchange/domain/entities/latest_exchange.entity.dart';
import 'package:izi_money/features/latest_exchange/domain/repositories/latest.repository.dart';

abstract class IGetNewCurrencyUseCase {
  Future<Either<BaseException, LatestExchange>> call(
    String base,
    List<String> newCurrencyList,
  );
}

class GetNewCurrencyUseCase extends IGetNewCurrencyUseCase {
  final ILatestRepository repository;

  GetNewCurrencyUseCase(this.repository);

  @override
  Future<Either<BaseException, LatestExchange>> call(
    String base,
    List<String> newCurrencyList,
  ) =>
      repository.addNewCurrency(base, newCurrencyList);
}
