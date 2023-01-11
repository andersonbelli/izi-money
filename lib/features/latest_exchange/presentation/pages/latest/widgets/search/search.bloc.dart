import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:izi_money/features/latest_exchange/data/models/rates.model.dart';
import 'package:izi_money/features/latest_exchange/data/models/search_currency_item.dart';
import 'package:izi_money/features/latest_exchange/domain/usecases/get_local_currencies.use_case.dart';
import 'package:meta/meta.dart';

part 'search.event.dart';
part 'search.state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IGetLocalCurrenciesUseCase getLocalLatestUseCase;

  List<SearchCurrencyItem> searchCurrencyItems = [];

  String currentLoadingCurrencyItem = '';

  SearchBloc(
    this.getLocalLatestUseCase,
  ) : super(SearchInitialState()) {
    on<LoadCurrencyEvent>((event, emit) {
      emit(SearchLoadingState());

      loadCurrencies().then((value) => searchCurrencyItems = value);

      emit(CurrenciesLoadedState());
    });
    on<SearchCurrencyEvent>((event, emit) {
      emit(SearchLoadingState());

      final result = searchCurrencyItems
          .where((currency) => currency.name.contains(event.searchCurrency))
          .toList();

      emit(SearchResultsState(result));
    });
    add(LoadCurrencyEvent());
  }

  Future<String> showSnackBar(String currencyName, bool currencyStatus) async {
    String? message;

    if (currencyStatus) {
      message = '$currencyName removed from list';
    } else {
      message = '$currencyName added to list';
    }
    return message;
  }

  Future<List<SearchCurrencyItem>> loadCurrencies() async {
    searchCurrencyItems.clear();

    final getLocalLatestResult = await getLocalLatestUseCase();

    List<String> currencies = jsonDecode(
      await rootBundle.loadString('assets/currencies.json'),
    ).cast<String>();

    getLocalLatestResult.fold((_) => null, (r) {
      if (r != null) {
        for (var rate in RatesModel.fromRates(r.rates).toJson().entries) {
          if (rate.value != null) {
            searchCurrencyItems
                .add(SearchCurrencyItem(name: rate.key, status: true));
          } else {
            searchCurrencyItems.add(SearchCurrencyItem(name: rate.key));
          }
        }
      } else {
        for (var currency in currencies) {
          searchCurrencyItems.add(SearchCurrencyItem(name: currency));
        }
      }
    });

    return searchCurrencyItems;
  }
}
