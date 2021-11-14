import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  iconTheme: const IconThemeData(color: Colors.black),
  scaffoldBackgroundColor: Colors.blue.withOpacity(0.9),
  // color of ABppar in weather screen
  appBarTheme: const AppBarTheme(color: Colors.amberAccent),
  primarySwatch: Colors.amber,
  // color of ABppar in weather screen
  primaryColor: Colors.amberAccent,
  buttonColor: Colors.white,
  brightness: Brightness.dark,
  // color of ABppar in weather screen

  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.white, fontSize: 25),
    bodyText2: TextStyle(color: Colors.white, fontSize: 16),
    headline1: TextStyle(
        color: Colors.blue, fontSize: 22, fontWeight: FontWeight.bold),
  ),
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);


