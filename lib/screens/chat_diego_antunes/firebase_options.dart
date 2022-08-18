// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCM0WjC41mh26_l1DcqSIstwCFYAFXLgFo',
    appId: '1:403150866921:web:f113801534d236ff456378',
    messagingSenderId: '403150866921',
    projectId: 'flutter-tutoriais',
    authDomain: 'flutter-tutoriais.firebaseapp.com',
    storageBucket: 'flutter-tutoriais.appspot.com',
    measurementId: 'G-3Y6L39L2E5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDPS3eYPX_6e8hlEU5mK6bHmB6dhc-OiJ8',
    appId: '1:403150866921:android:87beb257ff80ac3e456378',
    messagingSenderId: '403150866921',
    projectId: 'flutter-tutoriais',
    storageBucket: 'flutter-tutoriais.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCE7KNpkmoyHIBtzJRvwdqD3PDa4p9pojg',
    appId: '1:403150866921:ios:69823767c9f329d5456378',
    messagingSenderId: '403150866921',
    projectId: 'flutter-tutoriais',
    storageBucket: 'flutter-tutoriais.appspot.com',
    iosClientId:
        '403150866921-ojn0pdk3uutftruhk8081fmgp9ue4dcm.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFirebaseStorage',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCE7KNpkmoyHIBtzJRvwdqD3PDa4p9pojg',
    appId: '1:403150866921:ios:69823767c9f329d5456378',
    messagingSenderId: '403150866921',
    projectId: 'flutter-tutoriais',
    storageBucket: 'flutter-tutoriais.appspot.com',
    iosClientId:
        '403150866921-ojn0pdk3uutftruhk8081fmgp9ue4dcm.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFirebaseStorage',
  );
}
