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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCR3fsux8bjHEdClSdgxanBjyvV6IBNaRw',
    appId: '1:757941876489:android:65e282575f6780776505d8',
    messagingSenderId: '757941876489',
    projectId: 'ussduz-9a40d',
    databaseURL: 'https://ussduz-9a40d-default-rtdb.firebaseio.com',
    storageBucket: 'ussduz-9a40d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBTWkBGxfK8eCg2YI5-Kliny0I6Kcn_7_o',
    appId: '1:757941876489:ios:6ffd92ee816ee4846505d8',
    messagingSenderId: '757941876489',
    projectId: 'ussduz-9a40d',
    databaseURL: 'https://ussduz-9a40d-default-rtdb.firebaseio.com',
    storageBucket: 'ussduz-9a40d.appspot.com',
    iosClientId: '757941876489-73g12p3veiem8c21e7pa3o6kdnegat7e.apps.googleusercontent.com',
    iosBundleId: 'com.example.com',
  );
}
