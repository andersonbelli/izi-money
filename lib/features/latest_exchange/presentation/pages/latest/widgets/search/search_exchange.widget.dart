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
    return BlocBuilder<SearchBloc, SearchState>(
      bloc: Injector.di<SearchBloc>()
        ..add(SearchCurrencyEvent(query.toUpperCase())),
      builder: (context, state) {
        if (state is LoadingState) {
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

          return ListView.builder(
            itemCount: result.length,
            itemBuilder: (context, i) {
              return SearchItem(
                currencyName: result[i].name,
                currencyStatus: result[i].status,
              );
            },
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
    final List<SearchCurrencyItem> currencies =
        Injector.di<SearchBloc>().searchCurrencyItems;

    return BlocBuilder<SearchBloc, SearchState>(
      bloc: Injector.di<SearchBloc>(),
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CurrenciesLoadedState) {
          return ListView.builder(
            itemCount: currencies.length,
            itemBuilder: (context, i) {
              return SearchItem(
                currencyName: currencies[i].name,
                currencyStatus: currencies[i].status,
              );
            },
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

class SearchItem extends StatelessWidget {
  final String currencyName;
  final bool currencyStatus;

  const SearchItem({
    Key? key,
    required this.currencyName,
    required this.currencyStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(currencyName),
      trailing: IconButton(
        icon:
            currencyStatus ? const Icon(Icons.bookmark) : const Icon(Icons.add),
        onPressed: () {
          Injector.di<LatestBloc>().add(
            AddCurrencyEvent(currencyName),
          );
          SnackBar snackBar;
          if (currencyStatus) {
            snackBar = searchSnackBar('$currencyName removed from list');
          } else {
            snackBar = searchSnackBar('$currencyName added to list');
          }
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
