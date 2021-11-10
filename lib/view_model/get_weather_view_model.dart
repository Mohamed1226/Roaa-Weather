import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:roaa_weather/data/models/country_weather.dart';
import 'package:roaa_weather/data/web_services/get_wearher_model.dart';

class GetWeatherViewModel extends ChangeNotifier {
  CountryWeather _country = CountryWeather(
      feelsLike: 20.0,
      name: "london",
      humidity: 20,
      pressure: 20,
      temp: 20.0,
      wind: 20.0);

  CountryWeather get country => _country;
  bool _hasData = false;

  bool get hasData => _hasData;

  getWeatherByCountryName(BuildContext context, String countryName) async {
    GetWeatherModel model = GetWeatherModel();

    model.getWeather(countryName).then((value) {
      _country = CountryWeather.fromjson(value);
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
