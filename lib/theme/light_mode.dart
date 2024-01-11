import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white.withOpacity(0.9),
    primary: Colors.white.withOpacity(0.9),
    secondary: Colors.white.withOpacity(0.8),
    inversePrimary: Colors.white.withOpacity(0.2),
  ),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.grey[800],
        displayColor: Colors.black,
      ),
);
