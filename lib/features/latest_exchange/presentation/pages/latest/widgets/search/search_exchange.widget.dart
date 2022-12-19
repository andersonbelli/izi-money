import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izi_money/di/injector.di.dart';
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
      onPressed: () => close(context, null),
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
                currencyName: result[i],
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
    final List<String> currencies = Injector.di<SearchBloc>().currencies;

    return BlocBuilder<SearchBloc, SearchState>(
      bloc: Injector.di<SearchBloc>(),
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: currencies.length,
          itemBuilder: (context, i) {
            return SearchItem(
              currencyName: currencies[i],
            );
          },
        );
      },
    );
  }
}

class SearchItem extends StatelessWidget {
  final String currencyName;

  const SearchItem({Key? key, required this.currencyName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(currencyName),
      trailing: const Icon(Icons.add),
    );
  }
}
