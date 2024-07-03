// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        return windows;
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
    apiKey: 'AIzaSyCfdKVl9OvpyuemfyY45kRWQgfYETDJyU4',
    appId: '1:26868767962:web:f10bfc95052dd26224d9e3',
    messagingSenderId: '26868767962',
    projectId: 'berfin-app',
    authDomain: 'berfin-app.firebaseapp.com',
    storageBucket: 'berfin-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCY7pHKFZIAIBDvVs7TJzaMHkh1527PJ3M',
    appId: '1:26868767962:android:65310f92615a01be24d9e3',
    messagingSenderId: '26868767962',
    projectId: 'berfin-app',
    storageBucket: 'berfin-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD88BOYwoXSSOrXAiA7xf5Ctr8Dc5azpA4',
    appId: '1:26868767962:ios:38e566cf1851d00f24d9e3',
    messagingSenderId: '26868767962',
    projectId: 'berfin-app',
    storageBucket: 'berfin-app.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD88BOYwoXSSOrXAiA7xf5Ctr8Dc5azpA4',
    appId: '1:26868767962:ios:38e566cf1851d00f24d9e3',
    messagingSenderId: '26868767962',
    projectId: 'berfin-app',
    storageBucket: 'berfin-app.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCfdKVl9OvpyuemfyY45kRWQgfYETDJyU4',
    appId: '1:26868767962:web:c88420d309ff65e424d9e3',
    messagingSenderId: '26868767962',
    projectId: 'berfin-app',
    authDomain: 'berfin-app.firebaseapp.com',
    storageBucket: 'berfin-app.appspot.com',
  );
}