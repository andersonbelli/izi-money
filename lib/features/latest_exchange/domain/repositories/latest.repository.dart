import 'package:dartz/dartz.dart';
import 'package:izi_money/core/http/models/base.exception.dart';
import 'package:izi_money/features/latest_exchange/domain/entities/latest_exchange.entity.dart';

abstract class ILatestRepository {
  Future<Either<BaseException, LatestExchange>> getLatest();
}
