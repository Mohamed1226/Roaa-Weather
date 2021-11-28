part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {}

class GetWeatherByCountry extends WeatherEvent {

  @override
  List<Object?> get props =>[];
}
