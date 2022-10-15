import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../styles/layout.dart';
import '../../styles/txt.dart';
import '../../user_state.dart';

class Jobs extends StatefulWidget {
  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jobs',
          style: txt.appBarTitle,
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _auth.signOut();
            Navigator.canPop(context) ? Navigator.pop(context) : null;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => UserState(),
              ),
            );
          },
          child: const Padding(
            padding: EdgeInsets.all(layout.appPadding * 0.75),
            child: Text(
              'Logout',
              style: txt.button,
            ),
          ),
        ),
      ),
    );
  }
}
