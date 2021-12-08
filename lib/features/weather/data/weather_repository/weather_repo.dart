import 'package:dartz/dartz.dart';
import 'package:roaa_weather/core/error/exceptions.dart';
import 'package:roaa_weather/core/error/failures.dart';
import 'package:roaa_weather/core/location_retriever.dart';
import 'package:roaa_weather/core/network/network_info.dart';
import 'package:roaa_weather/features/weather/data/model/weather_model.dart';
import 'package:roaa_weather/features/weather/data/weather_data_source/weather_local_data_source.dart';
import 'package:roaa_weather/features/weather/data/weather_data_source/weather_remote_data_source.dart';

import 'package:roaa_weather/features/weather/domain/entities/weather_entites.dart';
import 'package:roaa_weather/features/weather/domain/repository/weather_repository.dart';

typedef Future<WeatherModel> _CountryOrLocationChooser();

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;
  final WeatherLocalDataSource weatherLocalDataSource;
  final NetworkInfo networkInfo;
//  final LocationRetriever locationRetriever;

  WeatherRepositoryImpl(
      {required this.networkInfo,
      required this.weatherLocalDataSource,
      required this.weatherRemoteDataSource,
      });

  @override
  Future<Either<Failure, WeatherEntities>> getWeatherByCountryName(
      String countryName) async {
    return await _getWeather(
        () => weatherRemoteDataSource.getWeatherByCountryName(countryName));
  }

  @override
  Future<Either<Failure, WeatherEntities>> getWeatherByLocation(
       lat,  lon) async {
    return await _getWeather(
        () => weatherRemoteDataSource.getWeatherByLocation(lat, lon));
  }

  Future<Either<Failure, WeatherEntities>> _getWeather(
      _CountryOrLocationChooser getWeatherByCountryOrLocation) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather = await getWeatherByCountryOrLocation();
        weatherLocalDataSource.cacheWeather(remoteWeather);
        return Right(remoteWeather);
      } on ServerException {
        return Left(ServerFailure( ));
      }
    } else {
      try {
        final cachedWeather = await weatherLocalDataSource.getLastWeather();
        return Right(cachedWeather);
      } on CacheException {
        return Left(Cachefailure());
      }
    }
  }
}
