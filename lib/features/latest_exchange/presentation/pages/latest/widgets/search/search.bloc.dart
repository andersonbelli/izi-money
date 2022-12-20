import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:izi_money/di/injector.di.dart';
import 'package:izi_money/features/latest_exchange/presentation/pages/latest.bloc.dart';
import 'package:meta/meta.dart';

part 'search.event.dart';
part 'search.state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<String> currencies = [];

  SearchBloc() : super(SearchInitialState()) {
    loadCurrencies().then((value) => currencies = value);

    on<SearchCurrencyEvent>((event, emit) {
      emit(LoadingState());

      final result = currencies
          .where((currency) => currency.contains(event.searchCurrency))
          .toList();

      emit(SearchResultsState(result));
    });
  }

  Future<List<String>> loadCurrencies() async {
    List<String> currencies = jsonDecode(
      await rootBundle.loadString('assets/currencies.json'),
    ).cast<String>();

    final List<MapEntry<String, dynamic>> userList =
        Injector.di<LatestBloc>().ratesList;

    for (var element in userList) {
      currencies
          .removeWhere((currencyElement) => currencyElement == element.key);
    }

    return currencies;
  }
}
