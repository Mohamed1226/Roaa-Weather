import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:roaa_weather/data/models/weather/country_weather.dart';
import 'package:roaa_weather/data/repositry/weather_repo.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherRepo weatherRepo;
 WeatherProvider(this.weatherRepo);


  CountryWeather? _country;
CountryWeather? get country => _country;


  bool _hasData = false;
bool get hasData => _hasData;

  getWeatherByCountryName(BuildContext context, String countryName) async {
    weatherRepo.getWeather(countryName).then((value) {
      _country = value;
      _hasData = true;

      //  print(country.humidity);
      notifyListeners();
    }).catchError((e) {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              backgroundColor: Colors.amberAccent,
              title: Text("Please Input a Correct Name"),
            );
          });
      print("${e.toString()} ;;;;");
    });
  }
}
