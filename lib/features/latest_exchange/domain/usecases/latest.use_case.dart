import 'package:dartz/dartz.dart';
import 'package:izi_money/core/http/models/base.exception.dart';
import 'package:izi_money/features/latest_exchange/domain/entities/latest_exchange.entity.dart';
import 'package:izi_money/features/latest_exchange/domain/repositories/latest.repository.dart';

abstract class ILatestUseCase {
  Future<Either<BaseException, LatestExchange>> call();
}

class LatestUseCase extends ILatestUseCase {
  final ILatestRepository repository;

  LatestUseCase(this.repository);

  @override
  Future<Either<BaseException, LatestExchange>> call() =>
      repository.getLatest();
}
