abstract class HttpManager {
  final bool mock;

  HttpManager(this.mock);

  Future<dynamic> get(
    String endpoint,
  );
}
