import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izi_money/core/extensions/string_parser.dart';
import 'package:izi_money/di/injector.di.dart';
import 'package:izi_money/features/latest_exchange/presentation/pages/latest.bloc.dart';
import 'package:izi_money/features/latest_exchange/presentation/pages/latest/widgets/search/search_exchange.widget.dart';

class LatestPage extends StatelessWidget {
  const LatestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injector.di.get<LatestBloc>(),
      child: const Scaffold(
        body: SafeArea(child: LatestContent()),
      ),
    );
  }
}

class LatestContent extends StatelessWidget {
  const LatestContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LatestBloc, LatestState>(
      builder: (BuildContext _, state) {
        if (state is LatestInitialState) {
          return const Center(child: Text('Nothing to see here 🤔'));
        }
        if (state is LatestLoadingState) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white70,
            ),
          );
        }
        if (state is LatestErrorState) {
          return Center(
            child: RichText(
              softWrap: true,
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: Theme.of(context).textTheme.headline6,
                  children: [
                    const TextSpan(text: 'There was an error 😔\n'),
                    const TextSpan(text: 'Please try again.\n\n'),
                    TextSpan(
                        text: state.message,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ]),
            ),
          );
        }
        if (state is NoCurrenciesAddedYetState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () => showSearch(
                      context: context,
                      delegate: SearchExchange(),
                      useRootNavigator: false,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.black54,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(16),
                      ),
                    ),
                    child: Text(
                      'Click to add new currency',
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is LatestExchangeState) {
          return Column(
            children: [
              HeaderContent(date: state.latestExchange.date.toDisplayDate()),
              RatesContent(state.rates),
            ],
          );
        }
        return Center(
          child: Text(
            'You were not supposed to see this 🤔',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}

class HeaderContent extends StatelessWidget {
  final String date;

  const HeaderContent({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black87,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => showSearch(
              context: context,
              delegate: SearchExchange(),
              useRootNavigator: true,
            ),
            highlightColor: Colors.amber,
            focusColor: Colors.deepPurpleAccent,
            splashColor: Colors.teal,
            color: Colors.deepOrange,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Last time updated: $date',
            ),
          ),
        ],
      ),
    );
  }
}

class RatesContent extends StatelessWidget {
  final List<MapEntry<String, dynamic>> rates;

  const RatesContent(this.rates, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: rates.length,
        itemBuilder: (context, i) {
          var rate = rates[i];

          var rateValue = rate.value;

          if (rate.key.toUpperCase() != 'BTC') {
            rateValue = double.parse(rate.value.toString())
                .toStringAsFixed(2)
                .toString();
          }

          return CurrencyItem(
            title: rate.key,
            value: rateValue.toString(),
          );
        },
      ),
    );
  }
}

class CurrencyItem extends StatelessWidget {
  final String title;
  final String value;

  const CurrencyItem({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      margin: const EdgeInsets.all(8),
      shadowColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            color: Colors.black45,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(32),
                      child: CurrencyImage(title),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        title.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurrencyImage extends StatelessWidget {
  final String imageName;

  const CurrencyImage(this.imageName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/flags/${imageName.toLowerCase()}.png',
      errorBuilder: (_, __, ___) {
        return Image.asset(
          'assets/flags/placeholder.png',
        );
      },
    );
  }
}
