import 'package:flutter/material.dart';

import '../../styles/layout.dart';
import '../../styles/txt.dart';

PreferredSizeWidget mainAppBar(String title) {
  return AppBar(
    elevation: layout.elevation,
    centerTitle: true,
    title: Text(
      title,
      style: txt.appBarTitle,
    ),
  );
}
