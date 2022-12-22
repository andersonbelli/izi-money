import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:izi_money/features/latest_exchange/data/models/rates.model.dart';
import 'package:izi_money/features/latest_exchange/domain/usecases/get_local_latest.use_case.dart';
import 'package:meta/meta.dart';

part 'search.event.dart';
part 'search.state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IGetLocalLatestUseCase getLocalLatestUseCase;

  List<String> currencies = [];

  SearchBloc(
    this.getLocalLatestUseCase,
  ) : super(SearchInitialState()) {
    on<LoadCurrencyEvent>((event, emit) {
      emit(LoadingState());

      loadCurrencies().then((value) => currencies = value);

      emit(CurrenciesLoadedState());
    });
    on<SearchCurrencyEvent>((event, emit) {
      emit(LoadingState());

      final result = currencies
          .where((currency) => currency.contains(event.searchCurrency))
          .toList();

      emit(SearchResultsState(result));
    });
    add(LoadCurrencyEvent());
  }

  Future<List<String>> loadCurrencies() async {
    final getLocalLatestResult = await getLocalLatestUseCase();

    List<String> currencies = jsonDecode(
      await rootBundle.loadString('assets/currencies.json'),
    ).cast<String>();

    getLocalLatestResult.fold((_) => null, (r) {
      if (r != null) {
        for (var rate in RatesModel.fromRates(r.rates).toJson().entries) {
          if (rate.value != null) {
            currencies.removeWhere((element) => element == rate.key);
          }
        }
      }
    });

    return currencies;
  }
}
