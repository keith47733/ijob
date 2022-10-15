import 'package:flutter/material.dart';

import '../../styles/clr.dart';
import '../../styles/layout.dart';
import '../../styles/txt.dart';

PreferredSizeWidget MainAppBar(String title) {
  return AppBar(
    elevation: layout.elevation,
    centerTitle: true,
    title: Text(
      title,
      style: txt.appBarTitle,
    ),
  );
}
