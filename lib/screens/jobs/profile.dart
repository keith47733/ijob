import 'package:flutter/material.dart';

import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/box_decoration_gradient.dart';
import '../../widgets/main_app_bar.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationGradient(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: mainAppBar('Profile'),
        bottomNavigationBar: BottomNavBar(navIndex: 3),
      ),
    );
  }
}
