import 'package:flutter/material.dart';

import 'clr.dart';

class txt {
  static const _textScaleFactor = 1.1;

  static const _textSizeLarge = 24.0 * _textScaleFactor;
  static const _textSizeMedium = 20.0 * _textScaleFactor;
  static const _textSizeDefault = 16.0 * _textScaleFactor;
  static const _textSizeSmall = 12.0 * _textScaleFactor;

  static const String _fontBody = 'Yeseva';
  static const String _fontTitle = 'JosefinSans';

  static const appBarTitle = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeLarge,
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

  static const smallTextButton = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeDefault,
    color: clr.primary,
  );

  static const mediumTextButton = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeMedium,
    color: clr.primary,
  );

  static const button = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeMedium,
    color: clr.light,
  );

  static const error = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeSmall,
    color: clr.error,
  );

  // TEXT ON DARK

  static const titleLight = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeLarge,
    color: clr.light,
  );

  static const subTitleLight = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeMedium,
    color: clr.light,
  );

  static const body1Light = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeSmall,
    color: clr.light,
  );

  static const body2Light = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: clr.light,
  );

  static const labelLight = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: clr.light,
  );

  static const floatingLabelLight = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault * 1.25,
    color: clr.primary,
  );

  static const fieldLight = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: clr.light,
  );

  // TEXT ON LIGHT
  static const titleDark = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeLarge,
    color: clr.dark,
  );

  static const subTitleDark = TextStyle(
    fontFamily: _fontTitle,
    fontWeight: FontWeight.bold,
    fontSize: _textSizeMedium,
    color: clr.dark,
  );

  static const body1Dark = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeSmall,
    color: clr.dark,
  );

  static const body2Dark = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: clr.dark,
  );

  static const labelDark = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: clr.dark,
  );

  static const floatingLabelDark = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault * 1.25,
    color: clr.primary,
  );

  static const fieldDark = TextStyle(
    fontFamily: _fontBody,
    fontWeight: FontWeight.normal,
    fontSize: _textSizeDefault,
    color: clr.dark,
  );
}
