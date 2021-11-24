import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:roaa_weather/core/app_config.dart';
import 'package:roaa_weather/features/weather/weather_api.dart';
import 'package:roaa_weather/core/shared_pref/shar_pref.dart';

class RemoteWeatherDataSource {
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
  @override
  Future getWeatherByUserLocation(lat, log) async {
    try {
      var url = weatherApiLocation(lat, log);
      http.Response _response = await http.get(url);
      //print(response.body);
      if (_response.statusCode == 200) {
        CacheHelper.putData(key: "countryWeather", value: _response.body);
      }
      var _body = jsonDecode(_response.body);
      return _body;
    } on HttpException catch (error) {
      print(error);
      rethrow;
    } on FormatException catch (error) {
      print(error);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getWeatherByCountryName(String country) async {
    try {
      var url = weatherApiCountry(country);
      http.Response _response = await http.get(url);
      //print(response.body);
      if (_response.statusCode == 200) {
        CacheHelper.putData(key: "countryWeather", value: _response.body);
      }

      var _body = jsonDecode(_response.body);
      return _body;
    } on HttpException catch (error) {
      print(error);
      rethrow;
    } on FormatException catch (error) {
      print(error);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
