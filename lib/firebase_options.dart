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
    apiKey: 'AIzaSyDdVrU9uczKg6G8VWIwehNk6FZyjVYCPcE',
    appId: '1:514515683759:web:a73a3b021d958df742475a',
    messagingSenderId: '514515683759',
    projectId: 'multi-vendor-store-4b2d5',
    authDomain: 'multi-vendor-store-4b2d5.firebaseapp.com',
    storageBucket: 'multi-vendor-store-4b2d5.appspot.com',
    measurementId: 'G-526Y6LD4M3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD6piC0g1_bTtOnrdE5hfkf6HCtN5Q503g',
    appId: '1:514515683759:android:fa89f531974fb5df42475a',
    messagingSenderId: '514515683759',
    projectId: 'multi-vendor-store-4b2d5',
    storageBucket: 'multi-vendor-store-4b2d5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAQnCr6x-iKQl-QgWQoD7n7JowQynEzgAc',
    appId: '1:514515683759:ios:d621fa452986ac6342475a',
    messagingSenderId: '514515683759',
    projectId: 'multi-vendor-store-4b2d5',
    storageBucket: 'multi-vendor-store-4b2d5.appspot.com',
    iosBundleId: 'com.example.multiVendorStore',
  );
}
