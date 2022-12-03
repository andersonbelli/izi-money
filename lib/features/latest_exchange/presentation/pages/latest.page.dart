import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:izi_money/dio/injector.di.dart';
import 'package:izi_money/features/latest_exchange/presentation/pages/latest.bloc.dart';

class LatestPage extends StatelessWidget {
  const LatestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injector.di.get<LatestBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Latest Exchange'),
        ),
        body: const LatestContent(),
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
            child: Text(
              'There was an error 😔 \n ${state.message}',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          );
        }
        if (state is LatestExchangeState) {
          final inputFormat = DateFormat('yyyy-MM-dd hh:mm');
          final inputDate = inputFormat.parse(state.latestExchange.date);
          final outputFormat = DateFormat('hh:mm - dd/MM/yyyy');
          final outputDate = outputFormat.format(inputDate);

          return Column(
            children: [
              Container(
                width: double.maxFinite,
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  'Last time updated: $outputDate',
                ),
              ),
              Expanded(
                child: RatesContent(state.rates),
              ),
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

class RatesContent extends StatelessWidget {
  final List<MapEntry<String, dynamic>> rates;

  const RatesContent(this.rates, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: rates.length,
      itemBuilder: (context, i) {
        var rate = rates[i];

        var rateValue = rate.value;

        if (rate.key.toUpperCase() != 'BTC') {
          rateValue =
              double.parse(rate.value.toString()).toStringAsFixed(2).toString();
        }

        return CurrencyItem(
          title: rate.key,
          value: rateValue.toString(),
        );
      },
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
      color: Colors.white,
      margin: const EdgeInsets.all(8),
      shadowColor: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.asset(
                'assets/flags/${title.toLowerCase()}.png',
                width: 55,
                errorBuilder: (_, __, ___) {
                  return Image.asset(
                    'assets/flags/placeholder.png',
                    width: 35,
                  );
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
