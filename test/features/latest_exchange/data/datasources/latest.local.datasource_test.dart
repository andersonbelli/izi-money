import 'package:flutter_test/flutter_test.dart';
import 'package:izi_money/features/latest_exchange/data/datasources/latest.local.datasource.dart';
import 'package:izi_money/features/latest_exchange/data/models/latest_exchange.model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mock_latest_exchange.model.dart';
import 'latest.local.datasource_test.mocks.dart';

@GenerateMocks([ILatestLocalDataSource])
void main() {
  late MockILatestLocalDataSource latestDataSource;

  setUp(() {
    latestDataSource = MockILatestLocalDataSource();
  });

  test(
      'Should save LatestExchange and'
      'verify it returns a instance of LatestExchangeModel', () async {
    // Arrange
    when(latestDataSource.saveLatestExchange(MockLatestExchangeModel.mock))
        .thenAnswer(
      (realInvocation) async => MockLatestExchangeModel.mock,
    );

    // Act
    var result =
        await latestDataSource.saveLatestExchange(MockLatestExchangeModel.mock);

    // Assert
    verify(latestDataSource.saveLatestExchange(MockLatestExchangeModel.mock))
        .called(1);
    expect(result, isInstanceOf<LatestExchangeModel>());
  });

  test(
      'Should recover local LatestExchange and'
      'verify it returns same data previous saved', () async {
    // Arrange
    when(latestDataSource.getLatestExchange()).thenAnswer(
      (realInvocation) async => MockLatestExchangeModel.mock,
    );

    // Act
    var result = await latestDataSource.getLatestExchange();

    // Assert
    verify(latestDataSource.getLatestExchange()).called(1);
    expect(result, isInstanceOf<LatestExchangeModel>());
    expect(result, equals(MockLatestExchangeModel.mock));
  });
}
