import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ijob/services/global_variables.dart';

import '../screens/jobs/jobs.dart';
import '../screens/jobs/logout.dart';
import '../screens/jobs/profile.dart';
import '../screens/jobs/search.dart';
import '../screens/jobs/upload.dart';
import '../styles/clr.dart';
import '../styles/layout.dart';

@override
class BottomNavBar extends StatelessWidget {
  int navIndex;
  BottomNavBar({required this.navIndex});

  @override
  Widget build(BuildContext context) {
    _getAvatar();
    return CurvedNavigationBar(
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: clr.accent,
      color: clr.primary,
      height: layout.curvedNavBarHeight,
      index: navIndex,
      items: [
        const Icon(Icons.list, size: layout.iconMedium, color: clr.bottomNavBarIcon),
        const Icon(Icons.search, size: layout.iconMedium, color: clr.bottomNavBarIcon),
        const Icon(Icons.add, size: layout.iconMedium, color: clr.bottomNavBarIcon),
        const Icon(Icons.person, size: layout.iconMedium, color: clr.bottomNavBarIcon),
        CircleAvatar(
          radius: 50,
          foregroundImage: avatarImage,
        ),
      ],
      // animationDuration: const Duration(milliseconds: 2000),
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
        }
      },
    );
  }

  _getAvatar() async {
    final DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    avatarURL = userDoc.get('user_image');
    avatarImage = NetworkImage(avatarURL.toString());
  }
}
