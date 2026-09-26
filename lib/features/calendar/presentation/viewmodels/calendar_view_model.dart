import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/app_logger.dart';

// Takvimde seçili olan tarihi tutan basit bir StateProvider
final selectedDateProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  // Saati sıfırlayarak sadece gün bazında tutuyoruz
  return DateTime(now.year, now.month, now.day);
});
