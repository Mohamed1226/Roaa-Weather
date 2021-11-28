import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:roaa_weather/core/error/failures.dart';
import 'package:roaa_weather/core/usecase/usecase.dart';
import 'package:roaa_weather/features/weather/domain/entities/weather_entites.dart';
import 'package:roaa_weather/features/weather/domain/repository/weather_repository.dart';

class GetWeatherByLocation implements UseCase<WeatherEntities, Params> {
  final WeatherRepository repository;

  GetWeatherByLocation(this.repository);

  @override
  Future<Either<Failure, WeatherEntities>> call(Params params) async {
    return await repository.getWeatherByLocation(params.lat, params.lon);
  }
}

class Params extends Equatable {
  final String lat,lon;

  Params({required this.lat,required this.lon});

  @override
  // TODO: implement props
  List<Object?> get props => [lat,lon];
}
