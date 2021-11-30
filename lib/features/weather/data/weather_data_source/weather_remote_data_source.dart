import 'dart:convert';

import 'package:roaa_weather/core/error/exceptions.dart';
import 'package:roaa_weather/features/weather/data/model/weather_model.dart';
import 'package:roaa_weather/features/weather/data/weather_data_source/weather_api.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeatherByCountryName(String countryName);

  Future<WeatherModel> getWeatherByLocation( lat,  lon);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {

  final http.Client client;
  WeatherRemoteDataSourceImpl({required this.client});
  @override
  Future<WeatherModel> getWeatherByCountryName(String countryName) async {
    var url = weatherApiCountry(countryName);
    http.Response _response = await client.get(url);
    if (_response.statusCode == 200) {
      var _body = jsonDecode(_response.body);
      var weather =WeatherModel.fromjson(_body);
      return weather;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<WeatherModel> getWeatherByLocation( lat,  lon) async{
    var url = weatherApiLocation(lat,lon);
    http.Response _response = await client.get(url);
    if (_response.statusCode == 200) {
      var _body = jsonDecode(_response.body);
      var weather =WeatherModel.fromjson(_body);
      return weather;
    } else {
      throw ServerException();
    }
  }
}
