import 'package:flutter/material.dart';
// Yeni oluşturduğunuz dosyayı uygulamaya tanıtıyoruz
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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF5722)),
      ),
      // Uygulama açıldığında direkt oluşturduğunuz Ana Sayfaya (HomeScreen) gidecek
      home: const HomeScreen(), 
    );
  }
}
