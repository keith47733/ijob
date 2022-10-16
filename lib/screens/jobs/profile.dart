import 'package:flutter/material.dart';

import '../../styles/clr.dart';
import '../../styles/layout.dart';
import '../../styles/txt.dart';
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
      decoration: BoxDecorationGradient(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MainAppBar('Profile'),
        bottomNavigationBar: BottomNavBar(navIndex: 3),
      ),
    );
  }
}
