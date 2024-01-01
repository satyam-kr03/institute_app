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
    apiKey: 'AIzaSyB4ngeXKD9XppvaDJjcoEW6MJeCzv6wkfs',
    appId: '1:3410474415:web:2dc0381f0a674e2f9cab5a',
    messagingSenderId: '3410474415',
    projectId: 'iitmandi-app',
    authDomain: 'iitmandi-app.firebaseapp.com',
    storageBucket: 'iitmandi-app.appspot.com',
    measurementId: 'G-M09C7209SS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA5MMy3rWq72EArLm3WyT9lSLXEjcx-LTE',
    appId: '1:3410474415:android:23692615290704249cab5a',
    messagingSenderId: '3410474415',
    projectId: 'iitmandi-app',
    storageBucket: 'iitmandi-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3u8OVqUVIKm-XtgiPRfLSUZl-i0uxASw',
    appId: '1:3410474415:ios:6f416cc48e3c0b799cab5a',
    messagingSenderId: '3410474415',
    projectId: 'iitmandi-app',
    storageBucket: 'iitmandi-app.appspot.com',
    androidClientId: '3410474415-rte3tnc7uuakosnsrqh67436osoe725k.apps.googleusercontent.com',
    iosClientId: '3410474415-94ln5ksr7vufs9js8n2qr1sq2198s9d9.apps.googleusercontent.com',
    iosBundleId: 'io.github.amansikarwar.institute-app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD3u8OVqUVIKm-XtgiPRfLSUZl-i0uxASw',
    appId: '1:3410474415:ios:3672d8b5c3faf7029cab5a',
    messagingSenderId: '3410474415',
    projectId: 'iitmandi-app',
    storageBucket: 'iitmandi-app.appspot.com',
    androidClientId: '3410474415-rte3tnc7uuakosnsrqh67436osoe725k.apps.googleusercontent.com',
    iosClientId: '3410474415-pq6p7175d5eli7ib04se1jb3i458bjkm.apps.googleusercontent.com',
    iosBundleId: 'com.example.myApp',
  );

}