import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'core/utils/app_logger.dart';
import 'firebase/firebase_initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  AppLogger.info('Firebase baslatiliyor...');
  await FirebaseInitializer.initialize();
  AppLogger.info('RanPro Baslatiliyor');
  
  runApp(
    const ProviderScope(
      child: RanproApp(),
    ),
  );
}
