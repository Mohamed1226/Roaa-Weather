part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}
// class InitialState extends WeatherState {
//   @override
//   List<Object?> get props => [];
// }

class Empty extends WeatherState {
  @override
  List<Object?> get props => [];
}

class Loading extends WeatherState {
  @override
  List<Object?> get props => [];
}

class Loaded extends WeatherState {
  final WeatherEntities weather;

  const Loaded({required this.weather});

  @override
  List<Object?> get props => [weather];
}

class Error extends WeatherState {
  final String message;

  const Error({required this.message});

  @override
  List<Object?> get props => [message];
}
