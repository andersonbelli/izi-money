import 'package:dartz/dartz.dart';
import 'package:izi_money/core/http/models/base.exception.dart';
import 'package:izi_money/core/http/models/generic.exception.dart';
import 'package:izi_money/core/http/models/request_fail.exception.dart';
import 'package:izi_money/features/latest_exchange/data/datasources/latest.remote.datasource.dart';
import 'package:izi_money/features/latest_exchange/domain/entities/latest_exchange.entity.dart';
import 'package:izi_money/features/latest_exchange/domain/repositories/latest.repository.dart';

class LatestRepository extends ILatestRepository {
  final ILatestDataSource remote;

  LatestRepository(this.remote);

  @override
  Future<Either<BaseException, LatestExchange>> getLatest() async {
    try {
      return Right(await remote.getLatest());
    } on RequestFailException catch (e) {
      return Left(e);
    } on GenericException catch (e) {
      return Left(e);
    }
  }
}
