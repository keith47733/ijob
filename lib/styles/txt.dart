import 'package:flutter/material.dart';

import 'clr.dart';

class txt {
  static const _textScaleFactor = 1.1;

  static const _textSizeDefault = 18.0 * _textScaleFactor;
  static const _textSizeSmall = 16.0 * _textScaleFactor;
  static const _textSizeMedium = 18.0 * _textScaleFactor;
  static const _textSizeLarge = 20.0 * _textScaleFactor;

  static const String _fontNameDefault = 'SourceSansPro';

  static const titleLight = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeLarge * 2,
    color: clr.light,
  );

  static const subTitleLight = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeMedium * 1.5,
    color: clr.light,
  );

  static const bodyDefaultLight = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: clr.light,
  );

  static const bodyMediumLight = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeLarge,
    color: clr.primary,
  );

  static const dialogDark = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: clr.dark,
  );

  static const formFieldHintLight = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: clr.passive,
  );

  static const formFieldLight = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: clr.light,
  );

  static const smallTextButton = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeSmall,
    color: clr.primary,
  );

  static const mediumTextButton = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeMedium,
    color: clr.primary,
  );

  static const button = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeMedium + 2,
    color: clr.light,
  );

  static const error = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeMedium,
    color: clr.error,
  );

  static Color _hexToColor(String code) {
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }
}
