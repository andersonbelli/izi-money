import 'package:get_it/get_it.dart';

class Injector {
  static final _singleton = Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  static final GetIt di = GetIt.instance;
}
