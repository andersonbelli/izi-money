import 'package:flutter/material.dart';
import 'package:izi_money/core/utils/app_colors.dart';
import 'package:izi_money/di/core.di.dart';
import 'package:izi_money/features/latest_exchange/presentation/pages/latest.page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CoreDI().registerAll();
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
      home: const Scaffold(
        body: LatestPage(),
      ),
    );
  }
}
