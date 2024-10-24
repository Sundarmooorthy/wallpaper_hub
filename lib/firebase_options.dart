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
    apiKey: 'AIzaSyAGH7zHY84PSEIjXF3LymTHHwJbUGEsqk0',
    appId: '1:441861090815:web:379aacf172ffa8c1108bca',
    messagingSenderId: '441861090815',
    projectId: 'wallpaper-zone-4e42e',
    authDomain: 'wallpaper-zone-4e42e.firebaseapp.com',
    databaseURL: 'https://wallpaper-zone-4e42e-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'wallpaper-zone-4e42e.appspot.com',
    measurementId: 'G-YWS18RBVKZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBvZfMzbt5ur8DakJiD94fr9ZYsBx41j08',
    appId: '1:441861090815:android:35286a397b4030e0108bca',
    messagingSenderId: '441861090815',
    projectId: 'wallpaper-zone-4e42e',
    databaseURL: 'https://wallpaper-zone-4e42e-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'wallpaper-zone-4e42e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBOd9CKxvS9uVMbh4-wrEBiTMhCBVNJ3AE',
    appId: '1:441861090815:ios:488ca899a13c71ab108bca',
    messagingSenderId: '441861090815',
    projectId: 'wallpaper-zone-4e42e',
    databaseURL: 'https://wallpaper-zone-4e42e-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'wallpaper-zone-4e42e.appspot.com',
    iosBundleId: 'com.example.wallpaperHub',
  );
}
