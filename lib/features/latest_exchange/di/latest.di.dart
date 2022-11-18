import 'package:izi_money/dio/base.dio.dart';
import 'package:izi_money/dio/injector.di.dart';
import 'package:izi_money/features/latest_exchange/data/datasources/latest.remote.datasource.dart';
import 'package:izi_money/features/latest_exchange/data/repositories/latest.repository_impl.dart';
import 'package:izi_money/features/latest_exchange/domain/repositories/latest.repository.dart';
import 'package:izi_money/features/latest_exchange/domain/usecases/latest.use_case.dart';
import 'package:izi_money/features/latest_exchange/presentation/pages/latest.bloc.dart';

class LatestDI implements BaseDI {
  @override
  void registerAll() {
    final di = Injector.di;

    // Datasource
    di.registerFactory<ILatestDataSource>(
      () => LatestDataSource(
        http: di(),
      ),
    );

    // Repositories
    di.registerFactory<ILatestRepository>(
      () => LatestRepository(di()),
    );

    // UseCases
    di.registerFactory<ILatestUseCase>(
      () => LatestUseCase(di()),
    );

    // Bloc
    di.registerSingleton<LatestBloc>(
      LatestBloc(di()),
    );
  }
}
