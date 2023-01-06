part of 'latest.bloc.dart';

@immutable
abstract class LatestEvent {}

class GetLatestExchangeEvent extends LatestEvent {}

class AddCurrencyEvent extends LatestEvent {
  final String newCurrency;

  AddCurrencyEvent(this.newCurrency);
}

class RemoveCurrencyEvent extends LatestEvent {
  final String newCurrency;

  RemoveCurrencyEvent(this.newCurrency);
}

class GetUserCurrenciesEvent extends LatestEvent {}
