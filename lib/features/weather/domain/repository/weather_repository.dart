import 'package:dartz/dartz.dart';
import 'package:roaa_weather/core/error/failures.dart';
import 'package:roaa_weather/features/weather/domain/entities/weather_entites.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntities>> getWeatherByCountryName(
      String countryName);

  Future<Either<Failure, WeatherEntities>> getWeatherByLocation(
       lat,  lon);
}
