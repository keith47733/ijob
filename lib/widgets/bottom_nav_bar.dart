import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/jobs/jobs.dart';
import '../screens/profile/profile.dart';
import '../screens/search_jobs/search_jobs.dart';
import '../screens/upload_job/upload_job.dart';
import '../styles/clr.dart';
import '../styles/layout.dart';
import "../styles/txt.dart";
import '../user_state.dart';

class BottomNavBar extends StatelessWidget {
  int navIndex;
  BottomNavBar({required this.navIndex});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: clr.accent,
      color: clr.primary,
      height: layout.curvedNavBarHeight,
      index: navIndex,
      items: const [
        Icon(Icons.list, size: layout.bottomNavBarIconSize, color: clr.dark),
        Icon(Icons.search, size: layout.bottomNavBarIconSize, color: clr.dark),
        Icon(Icons.add, size: layout.bottomNavBarIconSize, color: clr.dark),
        Icon(Icons.person, size: layout.bottomNavBarIconSize, color: clr.dark),
        Icon(Icons.exit_to_app, size: layout.bottomNavBarIconSize, color: clr.dark),
      ],
      // animationDuration: const Duration(milliseconds: 300),
      // animationCurve: Curves.bounceInOut,
      onTap: (navIndex) {
        if (navIndex == 0) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Jobs()));
        }
        if (navIndex == 1) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SearchJobs()));
        }
        if (navIndex == 2) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UploadJob()));
        }
        if (navIndex == 3) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile()));
        }
        if (navIndex == 4) {
          _logout(context);
        }
      },
    );
  }

  _logout(context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
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
                  size: layout.dialogIconSize,
                  color: clr.dark,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(layout.padding),
                child: Text(
                  'Sign Out',
                  style: txt.dialogTitle,
                ),
              ),
            ],
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: txt.dialogBody,
          ),
          actions: [
            TextButton(
              onPressed: () {
								// navIndex = 1;
                Navigator.canPop(context) ? Navigator.pop(context) : null;
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
        );
      },
    );
  }
}
