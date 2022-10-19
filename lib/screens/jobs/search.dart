import 'package:flutter/material.dart';

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
      decoration: boxDecorationGradient(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: mainAppBar('Search Jobs'),
        bottomNavigationBar: BottomNavBar(navIndex: 1),
      ),
    );
  }
}
