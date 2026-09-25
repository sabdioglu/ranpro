import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

// DİKKAT: Bu dosya derleme hatasını önlemek için oluşturulmuş bir şablondur.
// Projeyi geliştirirken terminalde "flutterfire configure" komutunu çalıştırarak
// bu dosyayı kendi projenizin gerçek Firebase yapılandırmasıyla ezmelisiniz.

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'API_KEY_WEB',
    appId: 'APP_ID_WEB',
    messagingSenderId: 'SENDER_ID',
    projectId: 'PROJECT_ID',
    authDomain: 'PROJECT_ID.firebaseapp.com',
    storageBucket: 'PROJECT_ID.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'API_KEY_ANDROID',
    appId: 'APP_ID_ANDROID',
    messagingSenderId: 'SENDER_ID',
    projectId: 'PROJECT_ID',
    storageBucket: 'PROJECT_ID.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'API_KEY_IOS',
    appId: 'APP_ID_IOS',
    messagingSenderId: 'SENDER_ID',
    projectId: 'PROJECT_ID',
    storageBucket: 'PROJECT_ID.appspot.com',
    iosBundleId: 'com.ranpro.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'API_KEY_MACOS',
    appId: 'APP_ID_MACOS',
    messagingSenderId: 'SENDER_ID',
    projectId: 'PROJECT_ID',
    storageBucket: 'PROJECT_ID.appspot.com',
    iosBundleId: 'com.ranpro.app',
  );
}
