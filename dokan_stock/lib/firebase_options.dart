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
    apiKey: 'AIzaSyAMGzrRSWmp5keQFNdYbPuxzWmkaTlO6jE',
    appId: '1:440030831367:web:587a4374327fcdeecd1ba2',
    messagingSenderId: '440030831367',
    projectId: 'dokan-stock-ca76e',
    authDomain: 'dokan-stock-ca76e.firebaseapp.com',
    storageBucket: 'dokan-stock-ca76e.appspot.com',
    measurementId: 'G-L7N51FZ3SZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAwMiKe4nLZir2f1fGNhJhQ8EnkLWCPViQ',
    appId: '1:440030831367:android:d822ad70a1dd1a12cd1ba2',
    messagingSenderId: '440030831367',
    projectId: 'dokan-stock-ca76e',
    storageBucket: 'dokan-stock-ca76e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBiZsbIqMC2UlHsEgu07P-RxQS6kt3I6C8',
    appId: '1:440030831367:ios:7fe646d3461de756cd1ba2',
    messagingSenderId: '440030831367',
    projectId: 'dokan-stock-ca76e',
    storageBucket: 'dokan-stock-ca76e.appspot.com',
    iosBundleId: 'com.example.dokanStock',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBiZsbIqMC2UlHsEgu07P-RxQS6kt3I6C8',
    appId: '1:440030831367:ios:6d5716d6d75df99acd1ba2',
    messagingSenderId: '440030831367',
    projectId: 'dokan-stock-ca76e',
    storageBucket: 'dokan-stock-ca76e.appspot.com',
    iosBundleId: 'com.example.dokanStock.RunnerTests',
  );
}
