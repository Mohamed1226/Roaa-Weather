import 'package:equatable/equatable.dart';

class WeatherEntities extends Equatable {
  final String name;

  final double temp;
  final int humidity;

  final double wind;
  final int pressure;
  final double feelsLike;
  final num lat;
  final num lon;
  final String description;

  WeatherEntities(
      {required this.name,
      required this.temp,
      required this.humidity,
      required this.wind,
      required this.pressure,
      required this.feelsLike,
      required this.lat,
      required this.lon,
      required this.description});

  @override
  List<Object?> get props =>
      [name, temp, humidity, wind, pressure, feelsLike, lat, lon, description];
}
