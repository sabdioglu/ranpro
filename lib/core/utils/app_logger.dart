import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static void info(String message) {
    if (kDebugMode) {
      print('[INFO]: $message');
    }
  }

  static void warning(String message) {
    if (kDebugMode) {
      print('[WARNING]: $message');
    }
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('[ERROR]: $message');
      if (error != null) print('Exception: $error');
      if (stackTrace != null) print('StackTrace: $stackTrace');
    }
  }
}
