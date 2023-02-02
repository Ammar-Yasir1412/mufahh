import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mufahh/Screens/auth/Splash_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // primarySwatch: Colors.red,
        ),
        home: FutureBuilder(
          // Initialize FlutterFire
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return const Text("Some thing Went Wrong");
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return splashscreen();
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}