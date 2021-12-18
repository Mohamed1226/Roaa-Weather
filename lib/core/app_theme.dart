import 'package:flutter/material.dart';
import 'package:roaa_weather/core/themes.dart';

enum ThemeType { orange, blue, navyBlue, purple }

class AppThemeFactory {
   create(ThemeType type) {
    switch (type) {
      case ThemeType.orange:
      //  print("case ThemeType.orange:");
        return orangeTheme;

      case ThemeType.blue:
        //print("case ThemeType.blue:");
        return blueTheme;

      case ThemeType.navyBlue:
        //print("case ThemeType.navyBlue:");
        return navyBlueTheme;

      case ThemeType.purple:
        //print("case ThemeType.purple:");
        return purpleTheme;
    }
  }
}
