import 'package:flutter/material.dart';

final customThemeData = ThemeData(
  colorScheme: ColorScheme(
    primary: Colors.blueGrey,
    onPrimary: Colors.white,
    secondary: Colors.cyan,
    onSecondary: Colors.white,
    surface: Colors.blueGrey.shade800,
    onSurface: Colors.white,
    background: Colors.blueGrey.shade900,
    onBackground: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    brightness: Brightness.dark,
  ),
);

const customHeaderFont1 = TextStyle(
  fontFamily: 'UniSansHeavy',
  fontSize: 24,
);

const customStandardFont1 = TextStyle(
  fontFamily: 'UniSansHeavy',
  color: Colors.white,
);

const customErrorFont = TextStyle(
  fontFamily: 'UniSansHeavy',
  color: Colors.red,
);

const cardElevation = 4.0;
final cardBorderRadius = BorderRadius.circular(10.0);
const cardMargin = EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0);
const cardColor = Colors.blueGrey;

