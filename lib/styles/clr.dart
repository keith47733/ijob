import 'package:flutter/material.dart';

class clr {
  static const Color primary = Colors.blue;
  static const Color lightPrimary = Colors.lightBlue;
  static const Color secondary = Colors.green;
  static const Color lightSecondary = Colors.lightGreen;
  static final Color accent = _lighten(Colors.yellow, 40);

  static const Color light = Colors.white;
  static const Color passive = Colors.grey;
  static final Color passiveLight = _lighten(passive, 40);
  static const Color dark = Colors.black;

  static final Color backgroundGradient1 = _lighten(lightPrimary, 65);
  static final Color backgroundGradient2 = _lighten(lightPrimary, 85);

  static const Color error = Colors.red;
}

Color _hexToColor(String code) {
  return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
}

Color _lighten(Color baseColor, int percent) {
  // assert(1 <= percent && percent <= 100);
  var p = percent / 100;
  return Color.fromARGB(baseColor.alpha, baseColor.red + ((255 - baseColor.red) * p).round(),
      baseColor.green + ((255 - baseColor.green) * p).round(), baseColor.blue + ((255 - baseColor.blue) * p).round());
}

Color _darken(Color baseColor, int percent) {
  // assert(1 <= percent && percent <= 100);
  var f = 1 - percent / 100;
  return Color.fromARGB(
      baseColor.alpha, (baseColor.red * f).round(), (baseColor.green * f).round(), (baseColor.blue * f).round());
}
