import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izi_money/di/injector.di.dart';
import 'package:izi_money/features/latest_exchange/data/models/search_currency_item.dart';
import 'package:izi_money/features/latest_exchange/presentation/pages/latest.bloc.dart';
import 'package:izi_money/features/latest_exchange/presentation/pages/latest/widgets/search/search.bloc.dart';

class SearchExchange extends SearchDelegate {
  SearchExchange()
      : super(
          searchFieldLabel: 'Search currency',
        );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = Injector.di<SearchBloc>();

    return BlocBuilder<SearchBloc, SearchState>(
      bloc: searchBloc..add(SearchCurrencyEvent(query.toUpperCase())),
      builder: (context, state) {
        if (state is SearchLoadingState) {
          return const CircularProgressIndicator();
        } else if (state is SearchResultsState) {
          final result = state.results;

          if (result.isEmpty) {
            return Center(
              child: Text(
                'No currency found',
                style: Theme.of(context).textTheme.headline6,
              ),
            );
          }

          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: searchBloc,
              ),
              BlocProvider.value(
                value: Injector.di<LatestBloc>(),
              )
            ],
            child: ListView.builder(
              itemCount: result.length,
              itemBuilder: (context, i) {
                return SearchItem(
                  currencyName: result[i].name,
                  currencyStatus: result[i].status,
                  loading: (context.watch<LatestBloc>().state
                              is LatestLoadingState) &&
                          (searchBloc.currentLoadingCurrencyItem ==
                              result[i].name)
                      ? true
                      : false,
                );
              },
            ),
          );
        }
        return Center(
          child: Text(
            'No currencies available',
            style: Theme.of(context).textTheme.headline6,
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchBloc = Injector.di<SearchBloc>();

    final List<SearchCurrencyItem> currencies = searchBloc.searchCurrencyItems;

    return BlocBuilder<SearchBloc, SearchState>(
      bloc: searchBloc,
      builder: (context, state) {
        if (state is SearchLoadingState) {
          return const CircularProgressIndicator();
        } else if (state is CurrenciesLoadedState) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: searchBloc,
              ),
              BlocProvider.value(
                value: Injector.di<LatestBloc>(),
              )
            ],
            child: ListView.builder(
              itemCount: currencies.length,
              itemBuilder: (context, i) {
                return SearchItem(
                  currencyName: currencies[i].name,
                  currencyStatus: currencies[i].status,
                  loading: (context.watch<LatestBloc>().state
                              is LatestLoadingState) &&
                          (searchBloc.currentLoadingCurrencyItem ==
                              currencies[i].name)
                      ? true
                      : false,
                );
              },
            ),
          );
        }
        return Center(
          child: Text(
            'No currencies available',
            style: Theme.of(context).textTheme.headline6,
          ),
        );
      },
    );
  }
}

class SearchItem extends StatefulWidget {
  final String currencyName;
  final bool currencyStatus;
  final bool loading;

  const SearchItem({
    Key? key,
    required this.currencyName,
    required this.currencyStatus,
    this.loading = false,
  }) : super(key: key);

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.currencyName),
      trailing: IconButton(
        icon: widget.loading
            ? const CircularProgressIndicator()
            : widget.currencyStatus
                ? const Icon(Icons.bookmark)
                : const Icon(Icons.add),
        onPressed: widget.loading
            ? null
            : () async {
                context.read<SearchBloc>().currentLoadingCurrencyItem =
                    widget.currencyName;

                Injector.di<LatestBloc>().add(
                  AddCurrencyEvent(widget.currencyName),
                );

                String snackBarMessage = await Injector.di<SearchBloc>()
                    .showSnackBar(widget.currencyName, widget.currencyStatus);

                if (snackBarMessage.isNotEmpty &&
                    mounted &&
                    (context.read<LatestBloc>().state is LatestExchangeState)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    searchSnackBar(snackBarMessage),
                  );
                }
              },
      ),
    );
  }
}

SnackBar searchSnackBar(String message) => SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      behavior: SnackBarBehavior.floating,
    );
