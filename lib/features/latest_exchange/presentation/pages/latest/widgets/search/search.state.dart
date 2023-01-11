part of 'search.bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class CurrenciesLoadedState extends SearchState {}

class SearchResultsState extends SearchState {
  final List<SearchCurrencyItem> results;

  SearchResultsState(this.results);
}
