



import 'package:flutter/cupertino.dart';
import 'package:roaa_weather/data/shar_pref.dart';
import 'package:roaa_weather/view/home_view.dart';
import 'package:roaa_weather/view/sign_screen/login_screen.dart';

class AppRoute{
  Widget isLogin (){
    var uId = CacheHelper.getData("uId");

    if (uId != null) {
      return HomeView();
    } else {
       return LogInScreen();
    }

  }

   }