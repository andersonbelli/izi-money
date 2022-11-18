import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            child: Text('There was an error 😔 \n ${state.message}'),
          );
        }
        if (state is LatestExchangeState) {
          return RatesContent(state.rates);
        }
        return const Center(
          child: Text('You were not supposed to see this 🤔'),
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
    return ListView.builder(
      itemCount: rates.length,
      itemBuilder: (context, i) {
        var rate = rates[i];

        return ListTile(
          title: Text('${rate.key.toUpperCase()}: ${rate.value}'),
        );
      },
    );
  }
}
