import 'package:flutter/material.dart';

class Style {
  static const _textScaleFactor = 1.1;

  static const _textSizeDefault = 18.0 * _textScaleFactor;
  static const _textSizeSmall = 16.0 * _textScaleFactor;
  static const _textSizeMedium = 18.0 * _textScaleFactor;
  static const _textSizeLarge = 22.0 * _textScaleFactor;

  static const Color primaryColor = Colors.blue;
  static const Color lightPrimaryColor = Colors.lightBlue;
  static const Color defaultColor = Colors.white;
  static const Color passiveColor = Colors.grey;
  static const Color dialogColor = Colors.black;
  static const Color errorColor = Colors.red;

  static const String _fontNameDefault = 'SourceSansPro';

  static const textDefault = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: defaultColor,
  );

  static const textLarge = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeLarge,
    color: primaryColor,
  );

  static const textDialog = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: dialogColor,
  );

  static const textFormFieldHint = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: defaultColor,
  );

  static const textFormField = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: defaultColor,
  );

  static const textButtonSmall = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeSmall,
    color: primaryColor,
  );
  static const button = TextStyle(
    fontFamily: _fontNameDefault,
		fontWeight: FontWeight.bold,
    fontSize: _textSizeMedium + 2,
    color: defaultColor,
  );

  static const textButtonLarge = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeMedium,
    color: primaryColor,
  );

  static const textError = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeMedium,
    color: errorColor,
  );

  static Color _hexToColor(String code) {
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }
}
