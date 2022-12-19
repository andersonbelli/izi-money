part of 'search.bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitialState extends SearchState {}

class LoadingState extends SearchState {}

class CurrenciesLoadedState extends SearchState {}

class SearchResultsState extends SearchState {
  final List<String> results;

  SearchResultsState(this.results);
}
