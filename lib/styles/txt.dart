import 'package:flutter/material.dart';

import 'clr.dart';

class txt {
  static const _textScaleFactor = 1.1;

  static const _textSizeSmall = 16.0 * _textScaleFactor;
  static const _textSizeDefault = 20.0 * _textScaleFactor;
  static const _textSizeMedium = 30.0 * _textScaleFactor;
  static const _textSizeLarge = 40.0 * _textScaleFactor;

  static const String _fontBody = 'Yeseva';
  static const String _fontTitle = 'JosefinSans';

  static const appBarTitle = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: clr.light,
  );

  static const title = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeLarge,
    color: clr.light,
  );

  static const subTitle = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeMedium,
    color: clr.light,
  );

  static const body1 = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeSmall,
    color: clr.light,
  );

  static const body2 = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: clr.light,
  );

  static const dialogTitle = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeMedium,
    color: clr.dark,
  );

  static const dialogBody = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: clr.dark,
  );

  static const dialogOptions = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeDefault,
    color: clr.secondary,
  );

  static final formFieldHint = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeSmall,
    color: clr.passiveLight,
  );

  static const formField = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: clr.light,
  );

  static const smallTextButton = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeSmall,
    color: clr.primary,
  );

  static const mediumTextButton = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeDefault,
    color: clr.primary,
  );

  static const button = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeMedium * 0.75,
    color: clr.light,
  );

  static const error = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeSmall,
    color: clr.error,
  );
}
