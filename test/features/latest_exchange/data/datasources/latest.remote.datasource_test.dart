import 'package:flutter_test/flutter_test.dart';
import 'package:izi_money/features/latest_exchange/data/datasources/latest.remote.datasource.dart';
import 'package:izi_money/features/latest_exchange/data/models/latest_exchange.model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mock_latest_exchange.model.dart';
import 'latest.remote.datasource_test.mocks.dart';

@GenerateMocks([LatestDataSource])
void main() {
  late MockILatestDataSource latestDataSource;

  setUp(() {
    latestDataSource = MockILatestDataSource();
  });

  test(
      'Should request getLatest and'
      'verify it returns a instance of LatestExchangeModel', () async {
    // Arrange
    when(latestDataSource.getLatest()).thenAnswer(
      (realInvocation) async => MockLatestExchangeModel.mock,
    );

    // Act
    var result = await latestDataSource.getLatest();

    // Assert
    verify(latestDataSource.getLatest()).called(1);
    expect(result, isInstanceOf<LatestExchangeModel>());
  });
}
