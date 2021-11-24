import 'package:flutter/cupertino.dart';
import 'package:roaa_weather/core/shared_pref/shar_pref.dart';
import 'package:roaa_weather/features/auth/presentation/pages/login/login_screen.dart';
import 'package:roaa_weather/features/weather/presentation/pages/weather_screen.dart';

class AppRoute {
  Widget isLogin() {
    var uId = CacheHelper.getData("uId");

    if (uId != null && uId != "") {
      return WeatherScreen();
    } else {
      return LogInScreen();
    }
  }
}
