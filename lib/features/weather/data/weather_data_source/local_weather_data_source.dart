import 'dart:convert';

import 'package:roaa_weather/features/weather/data/model/country_weather.dart';

import '../../../../core/shared_pref/shar_pref.dart';

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
