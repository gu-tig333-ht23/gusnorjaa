import 'package:flutter/material.dart';

// Ska ändra hur theme fungerar kommande dagarna så att det inte använder sig
// utav globala variabler.

var appTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 150, 182, 197),
    onPrimary: Color.fromARGB(255, 173, 196, 206),
    secondary: Color.fromARGB(255, 238, 224, 201),
    onSecondary: Color.fromARGB(255, 173, 196, 206),
    error: Color.fromARGB(255, 255, 0, 0),
    onError: Color.fromARGB(255, 173, 196, 206),
    background: Color.fromARGB(255, 173, 196, 206),
    onBackground: Color.fromARGB(255, 173, 196, 206),
    surface: Color.fromARGB(255, 173, 196, 206),
    onSurface: Color.fromARGB(255, 173, 196, 206),
  ),
);
