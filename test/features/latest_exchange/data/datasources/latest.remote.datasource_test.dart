import 'package:flutter_test/flutter_test.dart';
import 'package:izi_money/features/latest_exchange/data/datasources/latest.remote.datasource.dart';
import 'package:izi_money/features/latest_exchange/data/models/latest_exchange.model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mock_latest_exchange.model.dart';
import 'latest.remote.datasource_test.mocks.dart';

@GenerateMocks([ILatestRemoteDataSource])
void main() {
  const String base = 'USD';
  late MockILatestRemoteDataSource latestDataSource;

  setUp(() {
    latestDataSource = MockILatestRemoteDataSource();
  });

  test(
      'Should request getLatest and'
      'verify it returns a instance of LatestExchangeModel', () async {
    // Arrange
    when(latestDataSource.getLatestExchange(base)).thenAnswer(
      (realInvocation) async => MockLatestExchangeModel.mock,
    );

    // Act
    var result = await latestDataSource.getLatestExchange(base);

    // Assert
    verify(latestDataSource.getLatestExchange(base)).called(1);
    expect(result, isInstanceOf<LatestExchangeModel>());
  });
}
