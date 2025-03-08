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
    apiKey: 'AIzaSyAwL4OgaBWXv-aFFJhJ50nrN2wkMITSc1I',
    appId: '1:359467655101:web:53f3aa81f550bf8e31fcd4',
    messagingSenderId: '359467655101',
    projectId: 'wongnai-4a43f',
    authDomain: 'wongnai-4a43f.firebaseapp.com',
    storageBucket: 'wongnai-4a43f.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCx07vm_7l9YKeMArLDrKmkeBLkU6oMG3Q',
    appId: '1:359467655101:android:376d83d304258f0931fcd4',
    messagingSenderId: '359467655101',
    projectId: 'wongnai-4a43f',
    storageBucket: 'wongnai-4a43f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCLrqXcWNT2_Dv6Na3aAPJNlaIufa-u_WY',
    appId: '1:359467655101:ios:3acdafa909952c7b31fcd4',
    messagingSenderId: '359467655101',
    projectId: 'wongnai-4a43f',
    storageBucket: 'wongnai-4a43f.firebasestorage.app',
    iosBundleId: 'com.example.wongnai',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCLrqXcWNT2_Dv6Na3aAPJNlaIufa-u_WY',
    appId: '1:359467655101:ios:3acdafa909952c7b31fcd4',
    messagingSenderId: '359467655101',
    projectId: 'wongnai-4a43f',
    storageBucket: 'wongnai-4a43f.firebasestorage.app',
    iosBundleId: 'com.example.wongnai',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAwL4OgaBWXv-aFFJhJ50nrN2wkMITSc1I',
    appId: '1:359467655101:web:5b673856253456d531fcd4',
    messagingSenderId: '359467655101',
    projectId: 'wongnai-4a43f',
    authDomain: 'wongnai-4a43f.firebaseapp.com',
    storageBucket: 'wongnai-4a43f.firebasestorage.app',
  );
}
