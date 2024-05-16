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
    apiKey: 'AIzaSyDOjUUJP_t5I04qd_n7h4gIFzDZxb-glQ0',
    appId: '1:240822367064:web:46d964efadd6ff20cfab2d',
    messagingSenderId: '240822367064',
    projectId: 'locator-spb',
    authDomain: 'locator-spb.firebaseapp.com',
    databaseURL: 'https://locator-spb-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'locator-spb.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAGZxiX3CAANwUCJnOZNN2a6T8J2HaITbA',
    appId: '1:240822367064:android:da0da4d14c677796cfab2d',
    messagingSenderId: '240822367064',
    projectId: 'locator-spb',
    databaseURL: 'https://locator-spb-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'locator-spb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDgULJyaeg05V_x5oA6s_g7JU4SBwYMDo4',
    appId: '1:240822367064:ios:af46346036490217cfab2d',
    messagingSenderId: '240822367064',
    projectId: 'locator-spb',
    databaseURL: 'https://locator-spb-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'locator-spb.appspot.com',
    iosBundleId: 'ru.baitimirov.locator',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDgULJyaeg05V_x5oA6s_g7JU4SBwYMDo4',
    appId: '1:240822367064:ios:af46346036490217cfab2d',
    messagingSenderId: '240822367064',
    projectId: 'locator-spb',
    databaseURL: 'https://locator-spb-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'locator-spb.appspot.com',
    iosBundleId: 'ru.baitimirov.locator',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDOjUUJP_t5I04qd_n7h4gIFzDZxb-glQ0',
    appId: '1:240822367064:web:f37efc8bbe8b6f91cfab2d',
    messagingSenderId: '240822367064',
    projectId: 'locator-spb',
    authDomain: 'locator-spb.firebaseapp.com',
    databaseURL: 'https://locator-spb-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'locator-spb.appspot.com',
  );

}