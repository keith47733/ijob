import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../styles/clr.dart';
import '../../styles/layout.dart';
import '../../styles/txt.dart';
import '../../widgets/main_app_bar.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/box_decoration_gradient.dart';

class Jobs extends StatefulWidget {
  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecorationGradient(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MainAppBar('Jobs'),
        bottomNavigationBar: BottomNavBar(navIndex: 0),
      ),
    );
  }
}
