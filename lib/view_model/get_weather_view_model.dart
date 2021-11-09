
import 'package:flutter/foundation.dart';
import 'package:roaa_weather/model/get_wearher_model.dart';
import 'package:roaa_weather/model/models/country.dart';

class GetWeatherViewModel extends ChangeNotifier {
  Country country=Country(feelsLike: 20, name: "london", humidity: 20, pressure: 20, temp: 20, wind: 20);
bool hasData=false;

  getWeatherByCountryName(String countryName) async {
    GetWeatherModel model = GetWeatherModel();

    model.getWeather(countryName).then((value) {
       country = Country.fromjson(value);
       hasData=true;
     print(country.humidity);
     notifyListeners();
    }).catchError((e) {
      print(e.toString());
    });
  }
}
