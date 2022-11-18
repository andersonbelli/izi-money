part of 'latest.bloc.dart';

@immutable
abstract class LatestState {}

class LatestInitialState extends LatestState {}

class LatestLoadingState extends LatestState {}

class LatestGetLatestExchangesState extends LatestState {}

class LatestErrorState extends LatestState {
  final String message;

  LatestErrorState({required this.message});
}

class LatestExchangeState extends LatestState {
  final LatestExchange latestExchange;
  final List<MapEntry<String, dynamic>> rates;

  LatestExchangeState({required this.latestExchange, required this.rates});
}
