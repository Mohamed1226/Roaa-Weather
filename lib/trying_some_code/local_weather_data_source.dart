// import 'dart:convert';
//
// import 'package:roaa_weather/features/weather/data/model/weather_model.dart';
//
// import '../core/shared_pref/shar_pref.dart';
//
// class LocalWeatherDataSource {
//   WeatherModel? _country;
//   @override
//   WeatherModel? getSavedWeather() {
//     var countryWeather = CacheHelper.getData("countryWeather");
//     if (countryWeather != null) {
//       _country = WeatherModel.fromjson(jsonDecode(countryWeather));
//     }
//
//       return _country;
//
//   }
// }
