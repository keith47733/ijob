import 'package:flutter/material.dart';

class clr {
  static const Color primary = Colors.blue;
  static const Color lightPrimary = Colors.lightBlue;
  static const Color light = Colors.white;
  static const Color passive = Colors.grey;
  static final Color passiveLight = Colors.grey.shade400;
  static const Color dark = Colors.black;
  static const Color error = Colors.red;

  // static Color _hexToColor(String code) {
  //   return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  // }

  // static Color lighten(Color baseColor, int percent) {
  //   // assert(1 <= percent && percent <= 100);
  //   var p = percent / 100;
  //   return Color.fromARGB(baseColor.alpha, baseColor.red + ((255 - baseColor.red) * p).round(),
  //       baseColor.green + ((255 - baseColor.green) * p).round(), baseColor.blue + ((255 - baseColor.blue) * p).round());
  // }

  // static Color darken(Color baseColor, int percent) {
  //   // assert(1 <= percent && percent <= 100);
  //   var f = 1 - percent / 100;
  //   return Color.fromARGB(
  //       baseColor.alpha, (baseColor.red * f).round(), (baseColor.green * f).round(), (baseColor.blue * f).round());
  // }
}
