import 'package:flutter/material.dart';

import '../../styles/clr.dart';
import '../../styles/layout.dart';
import '../../styles/txt.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/box_decoration_gradient.dart';
import '../../widgets/main_app_bar.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecorationGradient(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MainAppBar('Search Jobs'),
        bottomNavigationBar: BottomNavBar(navIndex: 1),
      ),
    );
  }
}
