import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'login/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialiation = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialiation,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              primarySwatch: Colors.blue,
						fontFamily: 'Signatra',
            ),
            home: const Scaffold(
              body: Center(
                child: Text(
                  'iJob is being initialized',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return MaterialApp(
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
            title: 'iJob',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.black,
              primarySwatch: Colors.blue,
            ),
            home: Login(),
          );
        }
      }),
    );
  }
}
