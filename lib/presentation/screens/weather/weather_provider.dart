import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:roaa_weather/core/app_theme.dart';
import 'package:roaa_weather/core/location_retriever.dart';
import 'package:roaa_weather/data/models/weather/country_weather.dart';
import 'package:roaa_weather/data/repositry/weather_repo.dart';

import 'package:roaa_weather/data/shar_pref.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherRepo weatherRepo;

  WeatherProvider(this.weatherRepo) {
    checkSavedWeatherANdTheme();
    getWeatherByUserLocation();
  }

  checkSavedWeatherANdTheme() {
    var theme = CacheHelper.getData("theme");
    if (theme != null) {
      //    print("saved $theme");
      changeAppTheme(theme);
    }
  }

  //show textFormField
  bool isSearching = false;

  userIsSearching() {
    isSearching = true;
    notifyListeners();
  }

  CountryWeather? _country;

  CountryWeather? get country => _country;

  bool _hasData = false;

  bool get hasData => _hasData;

  //get weather by location

  getWeatherByUserLocation() async {
    weatherRepo.getWeatherByUserLocation().then((value) {
      _country = value;
      //  print(_country);
      changeImageAccordingTem();

      _hasData = true;

      //  print(country.humidity);
      notifyListeners();
    });
  }

  //get weather by country name

  getWeatherByCountryName(BuildContext context, String countryName) async {
    weatherRepo.getWeatherByCountryName(countryName).then((value) {
      _country = value;
      changeImageAccordingTem();
      _hasData = true;
      isSearching = false;
      //  print(country.humidity);
      notifyListeners();
    });
    //.catchError((e) {
    //   appDialog(context, "Please Input a Correct Name");
    //   print("${e.toString()} ;;;;");
    //});
  }

  //change image according temperature
  String image = "";

  changeImageAccordingTem() {
    if (_country!.temp - 273.15 > 30) {
      image = "assets/light.png";
      return;
    }
    if (_country!.temp - 273.15 > 15 && _country!.temp - 273.15 < 30) {
      image = "assets/rain.png";
      return;
    }
    if (_country!.temp - 273.15 > 5 && _country!.temp - 273.15 < 15) {
      image = "assets/snow.png";
      return;
    }
    if (_country!.temp - 273.15 < 5) {
      image = "assets/thunder.png";
      return;
    }

    notifyListeners();
  }

//change valued in DropDownButton
  String value = "orange";

  changeValueInDropDownButton(v) {
    value = v;
    //  print(value);
    notifyListeners();
    savedTheme();
    changeAppTheme(value);
  }

//change app theme
  ThemeType themeType = ThemeType.navyBlue;

  changeAppTheme(String value) {
    if (value == "purple") {
      themeType = ThemeType.purple;
      return;
    }
    if (value == "blue") {
      themeType = ThemeType.blue;

      return;
    }
    if (value == "navyBlue") {
      themeType = ThemeType.navyBlue;

      return;
    }
    if (value == "orange") {
      themeType = ThemeType.orange;

      return;
    }

    // notifyListeners();
  }

  savedTheme() {
    CacheHelper.putData(key: "theme", value: value);
  }
}
