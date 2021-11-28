import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:roaa_weather/core/error/failures.dart';
import 'package:roaa_weather/core/usecase/usecase.dart';
import 'package:roaa_weather/features/weather/domain/entities/weather_entites.dart';
import 'package:roaa_weather/features/weather/domain/repository/weather_repository.dart';

class GetWeatherByCountry implements UseCase<WeatherEntities, Params> {
  final WeatherRepository repository;

  GetWeatherByCountry(this.repository);

  @override
  Future<Either<Failure, WeatherEntities>> call(Params params) async {
    return await repository.getWeatherByCountryName(params.country);
  }
}

class Params extends Equatable {
  final String country;

  Params({required this.country});

  @override
  // TODO: implement props
  List<Object?> get props => [country];
}
