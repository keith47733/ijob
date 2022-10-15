import 'package:flutter/material.dart';

import 'clr.dart';

class txt {
  static const _textScaleFactor = 1.1;

  static const _textSizeDefault = 18.0 * _textScaleFactor;
  static const _textSizeSmall = 14.0 * _textScaleFactor;
  static const _textSizeMedium = 30.0 * _textScaleFactor;
  static const _textSizeLarge = 40.0 * _textScaleFactor;

  static const String _fontNameDefault = 'SourceSansPro';

  static const appBarTitle = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault + 2,
    color: clr.light,
  );

  static const title = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeLarge,
    color: clr.light,
  );

  static const subTitle = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeMedium,
    color: clr.light,
  );

  static const body1 = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: clr.light,
  );

  static const body2 = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeMedium,
    color: clr.light,
  );

  static const dialog = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: clr.dark,
  );

  static final formFieldHint = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault - 3,
    color: clr.passiveLight,
  );

  static const formField = TextStyle(
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
    fontSize: _textSizeDefault,
    color: clr.primary,
  );

  static const button = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeMedium * 0.75,
    color: clr.light,
  );

  static const error = TextStyle(
    fontFamily: _fontNameDefault,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeSmall,
    color: clr.error,
  );
}
