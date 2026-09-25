import 'package:firebase_core/firebase_core.dart';
import '../core/utils/app_logger.dart';
import 'firebase_options.dart';

class FirebaseInitializer {
  FirebaseInitializer._();

  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      AppLogger.info('Firebase basariyla baslatildi.');
    } catch (e, stackTrace) {
      AppLogger.error('Firebase baslatilirken hata olustu.', e, stackTrace);
      // Uygulamanın offline modda çalışabilmesi için hata yutulabilir 
      // veya UI tarafına bildirilmek üzere fırlatılabilir.
    }
  }
}
