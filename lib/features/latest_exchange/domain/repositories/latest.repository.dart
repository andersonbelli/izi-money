import 'package:dartz/dartz.dart';
import 'package:izi_money/core/http/models/base.exception.dart';
import 'package:izi_money/features/latest_exchange/domain/entities/latest_exchange.entity.dart';

abstract class ILatestRepository {
  Future<Either<BaseException, LatestExchange>> getRemoteLatest(
    List<String> userCurrencies, {
    String base = 'USD',
  });

  Future<Either<BaseException, LatestExchange>> addNewCurrency(
    String base,
    List<String> newCurrencyList,
  );

  Future<Either<BaseException, LatestExchange?>> getLocalLatest();

  Future<LatestExchange> saveLatest(
    LatestExchange exchange,
  );
}
