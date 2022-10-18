import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../styles/clr.dart';
import '../../styles/layout.dart';
import '../../styles/txt.dart';
import '../../user_state.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/box_decoration_gradient.dart';
import '../../widgets/main_app_bar.dart';
import 'jobs.dart';

class Logout extends StatefulWidget {
  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecorationGradient(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MainAppBar('Logout'),
        bottomNavigationBar: BottomNavBar(navIndex: 4),
        body: AlertDialog(
          elevation: layout.elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(layout.radius),
          ),
          backgroundColor: Colors.white,
          title: Row(
            children: const [
              Padding(
                padding: EdgeInsets.all(layout.padding / 2),
                child: Icon(
                  Icons.logout,
                  size: layout.iconLarge,
                  color: clr.dark,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(layout.padding),
                child: Text(
                  'Log Out',
                  style: txt.titleDark,
                ),
              ),
            ],
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: txt.body2Dark,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Jobs()));
              },
              child: const Text(
                'No',
                style: txt.dialogOptions,
              ),
            ),
            TextButton(
              onPressed: () {
                _auth.signOut();
                Navigator.canPop(context) ? Navigator.pop(context) : null;
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserState()));
              },
              child: const Text(
                'Yes',
                style: txt.dialogOptions,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _logout(context) {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         elevation: layout.elevation,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(layout.radius),
  //         ),
  //         backgroundColor: Colors.white,
  //         title: Row(
  //           children: const [
  //             Padding(
  //               padding: EdgeInsets.all(layout.padding / 2),
  //               child: Icon(
  //                 Icons.logout,
  //                 size: layout.iconLarge,
  //                 color: clr.dark,
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.all(layout.padding),
  //               child: Text(
  //                 'Log Out',
  //                 style: txt.titleDark,
  //               ),
  //             ),
  //           ],
  //         ),
  //         content: const Text(
  //           'Are you sure you want to logout?',
  //           style: txt.body2Dark,
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.canPop(context) ? Navigator.pop(context) : null;
  //             },
  //             child: const Text(
  //               'No',
  //               style: txt.dialogOptions,
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               _auth.signOut();
  //               Navigator.canPop(context) ? Navigator.pop(context) : null;
  //               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserState()));
  //             },
  //             child: const Text(
  //               'Yes',
  //               style: txt.dialogOptions,
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
