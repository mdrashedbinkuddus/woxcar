import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD8Y1UU2uhTfYBb9Vsvbjvk6DdvRLOKnkg",
            authDomain: "zwapp002.firebaseapp.com",
            projectId: "zwapp002",
            storageBucket: "zwapp002.appspot.com",
            messagingSenderId: "182992990950",
            appId: "1:182992990950:web:c8f8c822d0dc1fe9848127"));
  } else {
    await Firebase.initializeApp();
  }
}
