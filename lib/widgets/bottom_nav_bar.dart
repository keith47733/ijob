import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/jobs/jobs.dart';
import '../screens/jobs/logout.dart';
import '../screens/jobs/profile.dart';
import '../screens/jobs/search.dart';
import '../screens/jobs/upload.dart';
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
        Icon(Icons.list, size: layout.iconMedium, color: clr.bottomNavBarIcon),
        Icon(Icons.search, size: layout.iconMedium, color: clr.bottomNavBarIcon),
        Icon(Icons.add, size: layout.iconMedium, color: clr.bottomNavBarIcon),
        Icon(Icons.person, size: layout.iconMedium, color: clr.bottomNavBarIcon),
        Icon(Icons.exit_to_app, size: layout.iconMedium, color: clr.bottomNavBarIcon),
      ],
      // animationDuration: const Duration(milliseconds: 300),
      // animationCurve: Curves.bounceInOut,
      onTap: (navIndex) {
        if (navIndex == 0) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Jobs()));
        }
        if (navIndex == 1) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Search()));
        }
        if (navIndex == 2) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Upload()));
        }
        if (navIndex == 3) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile()));
        }
        if (navIndex == 4) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Logout()));
          // _logout(context);
        }
      },
    );
  }

  _logout(context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
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
