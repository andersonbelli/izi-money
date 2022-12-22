import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:izi_money/features/latest_exchange/data/models/rates.model.dart';
import 'package:izi_money/features/latest_exchange/domain/entities/latest_exchange.entity.dart';
import 'package:izi_money/features/latest_exchange/domain/entities/rates.entity.dart';
import 'package:izi_money/features/latest_exchange/domain/usecases/get_local_latest.use_case.dart';
import 'package:izi_money/features/latest_exchange/domain/usecases/get_new_currency.use_case.dart';
import 'package:izi_money/features/latest_exchange/domain/usecases/get_remote_latest.use_case.dart';
import 'package:izi_money/features/latest_exchange/domain/usecases/save_latest.use_case.dart';

part 'latest.event.dart';
part 'latest.state.dart';

class LatestBloc extends Bloc<LatestEvent, LatestState> {
  final IGetRemoteLatestUseCase getLatestUseCase;
  final IGetNewCurrencyUseCase getNewCurrencyUseCase;
  final ISaveLatestUseCase saveLatestUseCase;
  final IGetLocalLatestUseCase getLocalLatestUseCase;

  List<MapEntry<String, dynamic>> ratesList = [];
  final List<String> _userCurrencies = [];
  String _userBase = '';

  LatestBloc(
    this.getLatestUseCase,
    this.saveLatestUseCase,
    this.getNewCurrencyUseCase,
    this.getLocalLatestUseCase,
  ) : super(LatestInitialState()) {
    on<GetUserCurrenciesEvent>((event, emit) async {
      final getLocalLatestResult = await getLocalLatestUseCase();

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

      _userCurrencies.add(event.newCurrency);

      final newCurrencyData = await getNewCurrencyUseCase(
        _userBase,
        _userCurrencies,
      );

      newCurrencyData.fold(
        (failure) {
          emit(LatestErrorState(message: '$failure'));
        },
        (newCurrencyList) {
          saveLatestUseCase(newCurrencyList);

          emit(
            LatestExchangeState(
              latestExchange: newCurrencyList,
              rates: createRatesList(newCurrencyList.rates),
            ),
          );
        },
      );
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
