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
    apiKey: 'AIzaSyDra-ZdnyCMS861W_v4L4nVD3TFuswCuEc',
    appId: '1:693528374203:web:a87de787ca9c4a15b3f29e',
    messagingSenderId: '693528374203',
    projectId: 'bilotcod-8d38b',
    authDomain: 'bilotcod-8d38b.firebaseapp.com',
    storageBucket: 'bilotcod-8d38b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBE2OIPiknjG7Y9zVcKf-gTa8KHJx5LI7Y',
    appId: '1:693528374203:android:4acd099008f1305cb3f29e',
    messagingSenderId: '693528374203',
    projectId: 'bilotcod-8d38b',
    storageBucket: 'bilotcod-8d38b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBEdWhYmAg4XMdhK43ZL7Ho5quZtC3e6e4',
    appId: '1:693528374203:ios:5c7fe62123d94b21b3f29e',
    messagingSenderId: '693528374203',
    projectId: 'bilotcod-8d38b',
    storageBucket: 'bilotcod-8d38b.appspot.com',
    iosClientId: '693528374203-hfj5n34hidbitjpjfd52u7hl5f8ag2kf.apps.googleusercontent.com',
    iosBundleId: 'com.example.bilotcodPatient',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBEdWhYmAg4XMdhK43ZL7Ho5quZtC3e6e4',
    appId: '1:693528374203:ios:5c7fe62123d94b21b3f29e',
    messagingSenderId: '693528374203',
    projectId: 'bilotcod-8d38b',
    storageBucket: 'bilotcod-8d38b.appspot.com',
    iosClientId: '693528374203-hfj5n34hidbitjpjfd52u7hl5f8ag2kf.apps.googleusercontent.com',
    iosBundleId: 'com.example.bilotcodPatient',
  );
}
