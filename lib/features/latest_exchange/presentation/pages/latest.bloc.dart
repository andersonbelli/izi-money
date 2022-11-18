import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:izi_money/features/latest_exchange/data/models/rates.model.dart';
import 'package:izi_money/features/latest_exchange/domain/entities/latest_exchange.entity.dart';
import 'package:izi_money/features/latest_exchange/domain/entities/rates.entity.dart';
import 'package:izi_money/features/latest_exchange/domain/usecases/latest.use_case.dart';

part 'latest.event.dart';
part 'latest.state.dart';

class LatestBloc extends Bloc<LatestEvent, LatestState> {
  final ILatestUseCase getLatestUseCase;

  LatestBloc(this.getLatestUseCase) : super(LatestInitialState()) {
    on<GetLatestExchangeEvent>((event, emit) async {
      emit(LatestLoadingState());
      final getLatestExchangeResult = await getLatestUseCase();

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
    });
    add(GetLatestExchangeEvent());
  }

  List<MapEntry<String, dynamic>> createRatesList(Rates rates) {
    List<MapEntry<String, dynamic>> ratesList = [];

    for (var rate in RatesModel.fromRates(rates).toJson().entries) {
      if (rate.value != null) ratesList.add(rate);
    }

    return ratesList;
  }
}
