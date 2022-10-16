import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'styles/txt.dart';
import 'user_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              primarySwatch: Colors.blue,
            ),
            home: const Scaffold(
              body: Center(
                child: Text(
                  'iJob is being initialized',
                  style: txt.body2Light,
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              primarySwatch: Colors.blue,
              fontFamily: 'Signatra',
            ),
            home: const Scaffold(
              body: Center(
                child: Text(
                  'An error has occurred',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'iJob',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.blue,
            ),
            home: UserState(),
          );
        }
      }),
    );
  }
}
