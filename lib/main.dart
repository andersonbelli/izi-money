import 'package:flutter/material.dart';
import 'package:izi_money/core/http/dio_impl.dart';
import 'package:izi_money/core/utils/app_colors.dart';
import 'package:izi_money/features/latest_exchange/data/datasources/latest.remote.datasource.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'izi Money',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: AppColors.mainColor,
      ),
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () => LatestDataSource(http: DioImpl()).getLatest(),
            child: const Text('Request Latest Currency'),
          ),
        ),
      ),
    );
  }
}
