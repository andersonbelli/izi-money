part of 'search.bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchCurrencyEvent extends SearchEvent {
  final String searchCurrency;

  SearchCurrencyEvent(this.searchCurrency);
}

class AddCurrencyEvent extends SearchEvent {
  final String newCurrency;

  AddCurrencyEvent(this.newCurrency);
}
