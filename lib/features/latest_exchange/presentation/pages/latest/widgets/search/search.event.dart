part of 'search.bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchCurrencyEvent extends SearchEvent {
  final String searchCurrency;

  SearchCurrencyEvent(this.searchCurrency);
}

class LoadCurrencyEvent extends SearchEvent {}
