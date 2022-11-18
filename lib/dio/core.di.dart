import 'package:izi_money/core/http/dio_impl.dart';
import 'package:izi_money/core/http/http_manager.dart';
import 'package:izi_money/dio/base.dio.dart';
import 'package:izi_money/dio/injector.di.dart';
import 'package:izi_money/features/latest_exchange/di/latest.di.dart';

class CoreDI implements BaseDI {
  @override
  void registerAll() {
    // Http
    Injector.di.registerFactory<HttpManager>(
      () => DioImpl(mock: true),
    );

    /// Features DI
    // Latest
    LatestDI().registerAll();
  }
}
