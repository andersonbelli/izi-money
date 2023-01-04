import 'package:dartz/dartz.dart';
import 'package:izi_money/core/http/models/base.exception.dart';
import 'package:izi_money/core/http/models/generic.exception.dart';
import 'package:izi_money/core/http/models/request_fail.exception.dart';
import 'package:izi_money/features/latest_exchange/data/datasources/latest.local.datasource.dart';
import 'package:izi_money/features/latest_exchange/data/datasources/latest.remote.datasource.dart';
import 'package:izi_money/features/latest_exchange/data/models/latest_exchange.model.dart';
import 'package:izi_money/features/latest_exchange/domain/entities/latest_exchange.entity.dart';
import 'package:izi_money/features/latest_exchange/domain/repositories/latest.repository.dart';

class LatestRepository extends ILatestRepository {
  final ILatestRemoteDataSource remote;
  final ILatestLocalDataSource local;

  LatestRepository(this.remote, this.local);

  @override
  Future<Either<BaseException, LatestExchange>> getRemoteLatest(
    List<String> userCurrencies, {
    String base = 'USD',
  }) async {
    try {
      return Right(await remote.getLatestExchange(
        base: base,
        userCurrencies,
      ));
    } on RequestFailException catch (e) {
      final localExchange = await local.getLatestExchange();

      if (localExchange != null) {
        return Right(localExchange);
      } else {
        return Left(e);
      }
    } on GenericException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<BaseException, LatestExchange?>> getLocalLatest({
    String base = 'USD',
  }) async {
    try {
      return Right(await local.getLatestExchange());
    } on RequestFailException catch (e) {
      return Left(e);
    } on GenericException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<BaseException, LatestExchange>> addNewCurrency(
    String base,
      List<String> newCurrencyList,
  ) async {
    try {
      return Right(await remote.getLatestExchange(
        base: base,
        newCurrencyList,
      ));
    } on RequestFailException catch (e) {
      return Left(e);
    } on GenericException catch (e) {
      return Left(e);
    }
  }

  @override
  Future<LatestExchange> saveLatest(LatestExchange exchange) async => await local
      .saveLatestExchange(LatestExchangeModel.fromLatestExchange(exchange));
}
