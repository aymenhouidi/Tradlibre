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
    apiKey: 'AIzaSyC5viBv1KBIJb6Cq6ACFaCVN2XJFkf_OFI',
    appId: '1:502307153628:web:58472882a031b02f773619',
    messagingSenderId: '502307153628',
    projectId: 'tradlibre-notification',
    authDomain: 'tradlibre-notification.firebaseapp.com',
    storageBucket: 'tradlibre-notification.appspot.com',
    measurementId: 'G-FCZ5LVN2Y9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDRwNyZWo-zKQlZUtt-rr-oNd5MuR1wYew',
    appId: '1:502307153628:android:4ebf76ad3be5f93d773619',
    messagingSenderId: '502307153628',
    projectId: 'tradlibre-notification',
    storageBucket: 'tradlibre-notification.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUo9gkWsl9_NjsvRIijLcwtrXqfvKbMt4',
    appId: '1:502307153628:ios:86e2e6d5cfc5a085773619',
    messagingSenderId: '502307153628',
    projectId: 'tradlibre-notification',
    storageBucket: 'tradlibre-notification.appspot.com',
    iosClientId: '502307153628-bq614knlqqqlam1ahpso341dj19cn6ae.apps.googleusercontent.com',
    iosBundleId: 'com.example.tradlibre',
  );
}
