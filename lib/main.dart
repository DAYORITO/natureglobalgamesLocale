import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/main_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AppState(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: false,
        dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
      ),
      debugShowCheckedModeBanner: false,
      title: 'NatureGlobalGames',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home:
          // const ModalTry(),
          const MainScreen(),
    );
  }
}

class AppState extends ChangeNotifier {
  bool isDarkMode = false;
  double _width = 0;
  double _height = 0;

  double get width => _width;
  double get height => _height;

  void setSize(Size size) {
    _width = size.width;
    _height = size.height;
    notifyListeners();
  }

  void updateTheme(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
  }
}


