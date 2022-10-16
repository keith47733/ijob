import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../styles/clr.dart';
import '../../styles/layout.dart';
import '../../styles/txt.dart';
import '../../widgets/main_app_bar.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/box_decoration_gradient.dart';

class List extends StatefulWidget {
  @override
  State<List> createState() => _ListState();
}

class _ListState extends State<List> {
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
