import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const RanProApp());
}

class RanProApp extends StatelessWidget {
  const RanProApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RanPro',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFFFF5722),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF5722)),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA), // Çok açık gri arkaplan
      ),
      home: const MainScreen(),
    );
  }
}
