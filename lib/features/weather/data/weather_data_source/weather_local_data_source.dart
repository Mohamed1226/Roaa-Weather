import 'dart:convert';

import 'package:roaa_weather/core/error/exceptions.dart';
import 'package:roaa_weather/core/shared_pref/shar_pref.dart';
import 'package:roaa_weather/features/weather/data/model/weather_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class WeatherLocalDataSource {
  Future<WeatherModel> getLastWeather();

  Future<bool> cacheWeather(WeatherModel model);
}

const CachedWeather = "weather";

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  // final SharedPreferences sharedPreferences;
  //
  // WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<bool> cacheWeather(WeatherModel model) {
  return CacheHelper.putData(key: CachedWeather,value:  json.encode(model.toMap()));
  }

  @override
  Future<WeatherModel> getLastWeather() {
    final weatherString = CacheHelper.getData(CachedWeather);
    if (weatherString != null) {
      return Future.value(WeatherModel.fromjson(json.decode(weatherString)));
    } else {
      throw CacheException();
    }
  }
}


