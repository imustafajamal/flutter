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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBMrQjn_usx3_ezwXDzNlO2CLUw0AR1fLg',
    appId: '1:904558447883:web:5e5854766679fef7fe660e',
    messagingSenderId: '904558447883',
    projectId: 'flutter-chat-369c7',
    authDomain: 'flutter-chat-369c7.firebaseapp.com',
    storageBucket: 'flutter-chat-369c7.appspot.com',
    measurementId: 'G-C5PCQY8MBG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyARMA0lP6AgS3pHjdVzmOQTq2GZQD6Pg6Q',
    appId: '1:904558447883:android:d0dc4c1e9fa5f30afe660e',
    messagingSenderId: '904558447883',
    projectId: 'flutter-chat-369c7',
    storageBucket: 'flutter-chat-369c7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAcPQdVOd-fIptgfnQm9siXy2RIYs6uRrw',
    appId: '1:904558447883:ios:725a1125a3e924c8fe660e',
    messagingSenderId: '904558447883',
    projectId: 'flutter-chat-369c7',
    storageBucket: 'flutter-chat-369c7.appspot.com',
    iosClientId: '904558447883-h40i16iikgs6a1p71r93u6bn5m2vjmrt.apps.googleusercontent.com',
    iosBundleId: 'com.imustafajamal.imChatApp',
  );
}