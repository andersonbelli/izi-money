import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:izi_money/di/injector.di.dart';
import 'package:izi_money/features/latest_exchange/data/models/rates.model.dart';
import 'package:izi_money/features/latest_exchange/domain/entities/latest_exchange.entity.dart';
import 'package:izi_money/features/latest_exchange/domain/entities/rates.entity.dart';
import 'package:izi_money/features/latest_exchange/domain/usecases/clear_local_currencies.use_case.dart';
import 'package:izi_money/features/latest_exchange/domain/usecases/get_local_currencies.use_case.dart';
import 'package:izi_money/features/latest_exchange/domain/usecases/get_new_currency.use_case.dart';
import 'package:izi_money/features/latest_exchange/domain/usecases/get_remote_latest.use_case.dart';
import 'package:izi_money/features/latest_exchange/domain/usecases/save_local_currencies.use_case.dart';
import 'package:izi_money/features/latest_exchange/presentation/pages/latest/widgets/search/search.bloc.dart';

part 'latest.event.dart';

part 'latest.state.dart';

class LatestBloc extends Bloc<LatestEvent, LatestState> {
  final IGetRemoteLatestUseCase getLatestUseCase;
  final IGetNewCurrencyUseCase getNewCurrencyUseCase;
  final ISaveLocalCurrenciesUseCase saveLocalCurrenciesUseCase;
  final IGetLocalCurrenciesUseCase getLocalCurrenciesUseCase;
  final IClearLocalCurrenciesUseCase clearLocalCurrencies;

  List<MapEntry<String, dynamic>> ratesList = [];
  final List<String> _userCurrencies = [];
  String _userBase = '';

  LatestBloc(
    this.getLatestUseCase,
    this.saveLocalCurrenciesUseCase,
    this.getNewCurrencyUseCase,
    this.getLocalCurrenciesUseCase,
    this.clearLocalCurrencies,
  ) : super(LatestInitialState()) {
    on<GetUserCurrenciesEvent>((event, emit) async {
      final getLocalLatestResult = await getLocalCurrenciesUseCase();

      getLocalLatestResult.fold(
        (failure) => emit(LatestErrorState(message: '$failure')),
        (userCurrencies) {
          emit(LatestLoadingState());
          if (userCurrencies != null) {
            _userBase = userCurrencies.base;
            fillUserCurrenciesList(userCurrencies.rates);
          } else {
            emit(NoCurrenciesAddedYetState());
          }
        },
      );
      add(GetLatestExchangeEvent());
    });
    on<GetLatestExchangeEvent>((event, emit) async {
      if (_userCurrencies.isEmpty) {
        emit(NoCurrenciesAddedYetState());
      } else {
        emit(LatestLoadingState());
        final getLatestExchangeResult = await getLatestUseCase(_userCurrencies);

        getLatestExchangeResult.fold(
          (failure) {
            emit(LatestErrorState(message: '$failure'));
          },
          (latestExchange) {
            emit(
              LatestExchangeState(
                latestExchange: latestExchange,
                rates: createRatesList(latestExchange.rates),
              ),
            );
          },
        );
      }
    });
    on<AddCurrencyEvent>((event, emit) async {
      emit(LatestLoadingState());

      if (_userCurrencies.contains(event.newCurrency)) {
        _userCurrencies.remove(event.newCurrency);
      } else {
        _userCurrencies.add(event.newCurrency);
      }

      if (_userCurrencies.isNotEmpty) {
        final newCurrencyData = await getNewCurrencyUseCase(
          'USD', // TODO change user base currency
          _userCurrencies,
        );

        newCurrencyData.fold(
          (failure) {
            emit(LatestErrorState(message: '$failure'));
          },
          (newCurrencyList) {
            saveLocalCurrenciesUseCase(newCurrencyList);

            emit(
              LatestExchangeState(
                latestExchange: newCurrencyList,
                rates: createRatesList(newCurrencyList.rates),
              ),
            );
            if (emit.isDone) {
              Injector.di<SearchBloc>().add(LoadCurrencyEvent());
            }
          },
        );
      } else {
        clearLocalCurrencies();

        emit(NoCurrenciesAddedYetState());
        if (emit.isDone) {
          Injector.di<SearchBloc>().add(LoadCurrencyEvent());
        }
      }
    });
    add(GetUserCurrenciesEvent());
  }

  List<MapEntry<String, dynamic>> createRatesList(Rates rates) {
    ratesList.clear();
    for (var rate in RatesModel.fromRates(rates).toJson().entries) {
      if (rate.value != null) {
        ratesList.add(rate);
      }
    }

    return ratesList;
  }

  void fillUserCurrenciesList(Rates rates) {
    _userCurrencies.clear();
    for (var rate in RatesModel.fromRates(rates).toJson().entries) {
      if (rate.value != null) _userCurrencies.add(rate.key);
    }
  }
}
