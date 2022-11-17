import 'package:izi_money/dio/base.dio.dart';
import 'package:izi_money/dio/injector.di.dart';
import 'package:izi_money/features/latest_exchange/data/datasources/latest.remote.datasource.dart';
import 'package:izi_money/features/latest_exchange/data/repositories/latest.repository_impl.dart';
import 'package:izi_money/features/latest_exchange/domain/repositories/latest.repository.dart';
import 'package:izi_money/features/latest_exchange/domain/usecases/latest.use_case.dart';

class LatestDI implements BaseDI {
  @override
  void registerAll() {
    // Datasource
    Injector.di.registerFactory<ILatestDataSource>(
      () => LatestDataSource(
        http: Injector.di(),
      ),
    );

    // Repositories
    Injector.di.registerFactory<ILatestRepository>(
      () => LatestRepository(Injector.di()),
    );

    // UseCases
    Injector.di.registerFactory<ILatestUseCase>(
      () => LatestUseCase(Injector.di()),
    );
  }
}
