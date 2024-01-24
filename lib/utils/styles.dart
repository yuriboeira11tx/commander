import 'package:flutter/material.dart';

const primaryColor = Color(0xE4404B60);
const colorPrimarySwatch = MaterialColor(
  0xE4404B60,
  <int, Color>{
    50: primaryColor,
    100: primaryColor,
    200: primaryColor,
    300: primaryColor,
    400: primaryColor,
    500: primaryColor,
    600: primaryColor,
    700: primaryColor,
    800: primaryColor,
    900: primaryColor,
  },
);

const colorTitle = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);

const styleTextDefault = TextStyle(
  color: colorTitle,
);

const styleTextSnackbar = TextStyle(
  fontWeight: FontWeight.bold,
  color: colorTitle,
);

const styleTextButton = TextStyle(
  fontWeight: FontWeight.bold,
  color: colorTitle,
);
