import 'package:dartz/dartz.dart';
import 'package:izi_money/core/http/models/base.exception.dart';
import 'package:izi_money/features/latest_exchange/domain/entities/latest_exchange.entity.dart';
import 'package:izi_money/features/latest_exchange/domain/repositories/latest.repository.dart';

abstract class IGetRemoteLatestUseCase {
  Future<Either<BaseException, LatestExchange>> call(
    List<String> userCurrencies,
  );
}

class GetRemoteLatestUseCase extends IGetRemoteLatestUseCase {
  final ILatestRepository repository;

  GetRemoteLatestUseCase(this.repository);

  @override
  Future<Either<BaseException, LatestExchange>> call(
    List<String> userCurrencies,
  ) =>
      repository.getRemoteLatest(userCurrencies);
}
