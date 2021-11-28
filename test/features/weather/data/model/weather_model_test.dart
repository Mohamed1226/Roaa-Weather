


import 'package:flutter_test/flutter_test.dart';
import 'package:roaa_weather/features/weather/data/model/weather_model.dart';
import 'package:roaa_weather/features/weather/domain/entities/weather_entites.dart';

void main(){
  final tWeatherModel=WeatherModel(feelsLike: 256.2, name: "name", humidity: 526, pressure: 56, temp: 524, wind: 545, lat: 225.3, lon: 2.25, description: "description");
  test("shoulde be weather ", (){
    expect(tWeatherModel,isA<WeatherEntities>());
  });

}