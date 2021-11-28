import 'package:roaa_weather/features/weather/domain/entities/weather_entites.dart';

class WeatherModel extends WeatherEntities {
  WeatherModel({required feelsLike,
    required name,
    required humidity,
    required pressure,
    required temp,
    required wind,
    required lat,
    required lon,
    required description})
      : super(
      feelsLike: feelsLike,
      description: description,
      humidity: humidity,
      lat: lat,
      lon: lon,
      name: name,
      wind: wind,
      temp: temp,
      pressure: pressure);

  factory WeatherModel.fromjson(Map<String, dynamic> json) {
    return WeatherModel(
        name: json["name"],
        temp: json["main"]["temp"],
        wind: json["wind"]["speed"],
        humidity: json["main"]["humidity"],
        pressure: json["main"]["pressure"],
        feelsLike: json["main"]["feels_like"],
        description: json["weather"][0]["main"],
        lat: json["coord"]["lat"],
        lon: json["coord"]["lon"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "temp": temp,
      "wind": wind,
      "humidity": humidity,
      "pressure": pressure,
      "feels_like": feelsLike,
      "main": description,
      "lat": lat,
      "lon":lon,
    };
  }


  WeatherModel initialCountryWeather = WeatherModel(
      feelsLike: 20.0,
      name: "london",
      lat: 20.0,
      lon: 40.0,
      description: "clear",
      humidity: 20,
      pressure: 20,
      temp: 20.0,
      wind: 20.0);
}