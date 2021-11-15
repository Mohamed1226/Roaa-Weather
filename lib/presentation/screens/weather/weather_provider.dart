import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:roaa_weather/core/app_theme.dart';
import 'package:roaa_weather/core/location_retriever.dart';
import 'package:roaa_weather/data/models/weather/country_weather.dart';
import 'package:roaa_weather/data/repositry/weather_repo.dart';

import 'package:roaa_weather/data/shar_pref.dart';
import 'package:roaa_weather/presentation/widget/app_dialog.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherRepo weatherRepo;

  WeatherProvider(this.weatherRepo);

  //geolator
  void getCurrentLocation(BuildContext context) async {
    var position = await LocationRetriever().retrieve();
    //  print(position.longitude);
    getWeatherByUserLocation(context, position.latitude, position.longitude);

    notifyListeners();
  }

  checkSavedWeather() {
    var countryWeather = CacheHelper.getData("countryWeather");
    if (countryWeather != null) {
      _country = CountryWeather.fromjson(jsonDecode(countryWeather));
      print("${_country!.temp}   weather model" );
      _hasData = true;
    }
  }

  //show textFormField
  bool isSearching = false;

  userIsSearching() {
    isSearching = true;
    notifyListeners();
  }

  //get weather by country
  CountryWeather? _country;

  CountryWeather? get country => _country;

  bool _hasData = false;

  bool get hasData => _hasData;

  //get weather by location

  getWeatherByUserLocation(BuildContext context, lat, log) async {
    //print("Lllll $lat");
    weatherRepo.getWeatherByUserLocation(lat, log).then((value) {
      _country = value;
      print(_country);
      changeImageAccordingTem();

      _hasData = true;

      //  print(country.humidity);
      notifyListeners();
    }).catchError((e) {
      appDialog(context, "Please give GBS permission");
      // print("${e.toString()} ;;;;");
    });
  }

  //get weather by country

  getWeatherByCountryName(BuildContext context, String countryName) async {
    weatherRepo.getWeatherByCountryName(countryName).then((value) {
      _country = value;
      changeImageAccordingTem();
      _hasData = true;

      //  print(country.humidity);
      notifyListeners();
    }).catchError((e) {
      appDialog(context, "Please Input a Correct Name");
      //   print("${e.toString()} ;;;;");
    });
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

  //List themes = ['orange', "blue", "navyBlue", "purple"];
  String value = "orange";

  changeValueInDropDownButton(v) {
    value = v;
    print(value);
    notifyListeners();
    changeAppTheme();
  }

  ThemeType themeType = ThemeType.orange;

  changeAppTheme() {
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

    notifyListeners();
  }


}
