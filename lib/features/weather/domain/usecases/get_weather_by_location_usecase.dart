import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:roaa_weather/core/error/failures.dart';
import 'package:roaa_weather/core/usecase/usecase.dart';
import 'package:roaa_weather/features/weather/domain/entities/weather_entites.dart';
import 'package:roaa_weather/features/weather/domain/repository/weather_repository.dart';

class GetWeatherByLocationUseCases implements UseCase<WeatherEntities, ParamsL> {
  final WeatherRepository repository;

  GetWeatherByLocationUseCases(this.repository);

  @override
  Future<Either<Failure, WeatherEntities>> call(ParamsL params) async {
    return await repository.getWeatherByLocation(params.lat, params.lon);
  }
}

class ParamsL extends Equatable {
  final  lat,lon;

  ParamsL({required this.lat,required this.lon});

  @override
  // TODO: implement props
  List<Object?> get props => [lat,lon];
}
