import 'package:roaa_weather/data/models/weather/country_weather.dart';
import 'package:roaa_weather/data/web_services/wearher_web_service.dart';

class WeatherRepo {
  final WeatherWebService weatherWebService;
 WeatherRepo(this.weatherWebService);

  CountryWeather _country = initialCountryWeather;
CountryWeather get country => _country;

  Future<CountryWeather> getWeatherByCountryName(String country) async =>
      await weatherWebService.getWeatherByCountryName(country).then((value) {
        _country = CountryWeather.fromjson(value);
        return _country;
      }).catchError((e) {
        print(e.toString());
      });

  Future<CountryWeather> getWeatherByUserLocation( lat, log) async =>

      await weatherWebService.getWeatherByUserLocation(lat,log).then((value) {
        print("222");
        _country = CountryWeather.fromjson(value);
        return _country;
      }).catchError((e) {
        print(e.toString());
      });
}
