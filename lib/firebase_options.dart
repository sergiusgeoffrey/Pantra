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
    apiKey: 'AIzaSyAUK0pxo0jcA912rhFYkujXlE0K908BULk',
    appId: '1:568483008738:web:353a1fa9293a5a45c54ebb',
    messagingSenderId: '568483008738',
    projectId: 'pantra-cf329',
    authDomain: 'pantra-cf329.firebaseapp.com',
    storageBucket: 'pantra-cf329.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAv2WkaYC3F1eeZOLncrfUAiecPV-f1FCQ',
    appId: '1:568483008738:android:8ae5908d16518f19c54ebb',
    messagingSenderId: '568483008738',
    projectId: 'pantra-cf329',
    storageBucket: 'pantra-cf329.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAAodXQolIDYmjYPsplBK17xxC6e3tq4hA',
    appId: '1:568483008738:ios:1044757f800c0c08c54ebb',
    messagingSenderId: '568483008738',
    projectId: 'pantra-cf329',
    storageBucket: 'pantra-cf329.appspot.com',
    iosClientId: '568483008738-6rqq077m1rj0pbtbel1666r3fdrdbmbf.apps.googleusercontent.com',
    iosBundleId: 'com.example.pantraProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAAodXQolIDYmjYPsplBK17xxC6e3tq4hA',
    appId: '1:568483008738:ios:1044757f800c0c08c54ebb',
    messagingSenderId: '568483008738',
    projectId: 'pantra-cf329',
    storageBucket: 'pantra-cf329.appspot.com',
    iosClientId: '568483008738-6rqq077m1rj0pbtbel1666r3fdrdbmbf.apps.googleusercontent.com',
    iosBundleId: 'com.example.pantraProject',
  );
}
