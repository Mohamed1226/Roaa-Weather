import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:roaa_weather/core/app_config.dart';
import 'package:roaa_weather/data/apis/weather_api.dart';
import 'package:roaa_weather/data/shar_pref.dart';

class WeatherWebService {
// late Dio dio;
//   WeatherWebService(){
//     BaseOptions baseOptions =BaseOptions(
//       baseUrl: AppConfig.baseUrl,
//    receiveDataWhenStatusError: true,
//       connectTimeout: 20*1000,
//       receiveTimeout: 20*1000,
//       queryParameters:{
//
//       } ,
//     );
//
//     dio =Dio(baseOptions);
//   }

// Future getWeather(String country) async {
//   var url = apiUrl(country);
//   http.Response _response = await appDio.get(url);
//
//   var _body = jsonDecode(_response.body);
//   return _body;
// }

  Future getWeatherByUserLocation(lat, log) async {
    var url = weatherApiLocation(lat, log);
    http.Response _response = await http.get(url);
    //print(response.body);

    CacheHelper.putData(key: "countryWeather", value:_response.body );
    var _body = jsonDecode(_response.body);
    return _body;
  }

  Future getWeatherByCountryName(String country) async {
    var url = weatherApiCountry(country);
    http.Response _response = await http.get(url);
    //print(response.body);
    CacheHelper.putData(key: "countryWeather", value:_response.body );

    var _body = jsonDecode(_response.body);
    return _body;
  }
}
