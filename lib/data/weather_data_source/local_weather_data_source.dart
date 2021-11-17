import 'dart:convert';

import 'package:roaa_weather/data/models/weather/country_weather.dart';

import '../shar_pref.dart';

class LocalWeatherDataSource {
  CountryWeather? _country;
  @override
  CountryWeather? getSavedWeather() {
    var countryWeather = CacheHelper.getData("countryWeather");
    if (countryWeather != null) {
      _country = CountryWeather.fromjson(jsonDecode(countryWeather));
    }

      return _country;

  }
}
