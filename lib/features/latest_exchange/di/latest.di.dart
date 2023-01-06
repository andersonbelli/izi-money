import 'package:izi_money/di/injector.di.dart';
import 'package:izi_money/dio/base.dio.dart';
import 'package:izi_money/features/latest_exchange/data/datasources/latest.local.datasource.dart';
import 'package:izi_money/features/latest_exchange/data/datasources/latest.remote.datasource.dart';
import 'package:izi_money/features/latest_exchange/data/repositories/latest.repository_impl.dart';
import 'package:izi_money/features/latest_exchange/domain/repositories/latest.repository.dart';
import 'package:izi_money/features/latest_exchange/domain/usecases/clear_local_currencies.use_case.dart';
import 'package:izi_money/features/latest_exchange/domain/usecases/get_local_currencies.use_case.dart';
import 'package:izi_money/features/latest_exchange/domain/usecases/get_new_currency.use_case.dart';
import 'package:izi_money/features/latest_exchange/domain/usecases/get_remote_latest.use_case.dart';
import 'package:izi_money/features/latest_exchange/domain/usecases/save_local_currencies.use_case.dart';
import 'package:izi_money/features/latest_exchange/presentation/pages/latest.bloc.dart';
import 'package:izi_money/features/latest_exchange/presentation/pages/latest/widgets/search/search.bloc.dart';

class LatestDI implements BaseDI {
  @override
  void registerAll() {
    final di = Injector.di;

    // Datasource
    di.registerFactory<ILatestRemoteDataSource>(
      () => LatestRemoteDataSource(
        http: di(),
      ),
    );
    di.registerFactory<ILatestLocalDataSource>(
      () => LatestLocalDataSource(
        storage: di(),
      ),
    );

    // Repositories
    di.registerFactory<ILatestRepository>(
      () => LatestRepository(di(), di()),
    );

    // UseCases
    di.registerFactory<IGetRemoteLatestUseCase>(
      () => GetRemoteLatestUseCase(di()),
    );
    di.registerFactory<IGetLocalCurrenciesUseCase>(
      () => GetLocalLatestUseCase(di()),
    );
    di.registerFactory<ISaveLocalCurrenciesUseCase>(
      () => SaveLatestUseCase(di()),
    );
    di.registerFactory<IGetNewCurrencyUseCase>(
      () => GetNewCurrencyUseCase(di()),
    );
    di.registerFactory<IClearLocalCurrenciesUseCase>(
          () => ClearLocalCurrenciesUseCase(di()),
    );

    // Bloc
    di.registerSingleton<LatestBloc>(
      LatestBloc(di(), di(), di(), di(), di()),
    );
    di.registerSingleton<SearchBloc>(
      SearchBloc(di()),
    );
  }
}
