// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyCXlfdH-rAylEnBHHcMGn_PY2Sd2E26EAM',
    appId: '1:663509417672:web:66b92d07acaa2947086ffd',
    messagingSenderId: '663509417672',
    projectId: 'registro-oradores',
    authDomain: 'registro-oradores.firebaseapp.com',
    storageBucket: 'registro-oradores.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJJIsras9F_ujKcxY3mmYWAfEiWonIG4E',
    appId: '1:663509417672:android:cd27bb39b9fc955c086ffd',
    messagingSenderId: '663509417672',
    projectId: 'registro-oradores',
    storageBucket: 'registro-oradores.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvaZouGYR6RL9l7Zb5O8zFMvBEHtJbMqc',
    appId: '1:663509417672:ios:7241c3b838f23558086ffd',
    messagingSenderId: '663509417672',
    projectId: 'registro-oradores',
    storageBucket: 'registro-oradores.appspot.com',
    iosBundleId: 'com.example.registroDeOradores',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDvaZouGYR6RL9l7Zb5O8zFMvBEHtJbMqc',
    appId: '1:663509417672:ios:e0395d623884469e086ffd',
    messagingSenderId: '663509417672',
    projectId: 'registro-oradores',
    storageBucket: 'registro-oradores.appspot.com',
    iosBundleId: 'com.example.registroDeOradores.RunnerTests',
  );
}
