import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:roaa_weather/data/models/weather/country_weather.dart';
import 'package:roaa_weather/data/repositry/weather_repo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:roaa_weather/data/shar_pref.dart';
import 'package:roaa_weather/presentation/widget/app_dialog.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherRepo weatherRepo;

  WeatherProvider(this.weatherRepo);

  //geolator
  void getCurrentLocation(BuildContext context) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    //  print(position.longitude);
    getWeatherByUserLocation(context, position.latitude, position.longitude);

    notifyListeners();
  }

  //show textFormField
  bool isSearching = false;

  userIsSearching() {
    isSearching = true;
    notifyListeners();
  }

  //get weather by country
  CountryWeather? _country;

  CountryWeather? get country => _country;

  bool _hasData = false;

  bool get hasData => _hasData;

  //get weather by location

  getWeatherByUserLocation(BuildContext context, lat, log) async {
    //print("Lllll $lat");
    weatherRepo.getWeatherByUserLocation(lat, log).then((value) {
      //print("1111");
      _country = value;
      changeImageAccordingTem();

      _hasData = true;

      //  print(country.humidity);
      notifyListeners();
    }).catchError((e) {
      appDialog(context, "Please give GBS permission");
      // print("${e.toString()} ;;;;");
    });
  }

  //get weather by country

  getWeatherByCountryName(BuildContext context, String countryName) async {
    weatherRepo.getWeatherByCountryName(countryName).then((value) {
      _country = value;
      changeImageAccordingTem();
      _hasData = true;

      //  print(country.humidity);
      notifyListeners();
    }).catchError((e) {
      appDialog(context, "Please Input a Correct Name");
      //   print("${e.toString()} ;;;;");
    });
  }

  //change image according temperature
  String image = "";

  String changeImageAccordingTem() {
    if (_country!.temp > 30) {
      image = "assets/light.png";
    } else if (_country!.temp > 15 && _country!.temp < 30) {
      image = "assets/rain.png";
    } else if (_country!.temp > 5 && _country!.temp < 15) {
      image = "assets/rain.png";
    } else {
      image = "assets/thunder.png";
    }
    notifyListeners();
    return image;
  }
   setData(){
     CacheHelper.putData(key: "temp", value: _country!.temp.toString());
     CacheHelper.putData(key: "name", value: _country!.name.toString());
     CacheHelper.putData(key: "pressure", value: _country!.pressure.toString());
     CacheHelper.putData(key: "wind", value: _country!.wind.toString());
     CacheHelper.putData(key: "humidity", value: _country!.humidity.toString());
     CacheHelper.putData(key: "feelsLike", value: _country!.feelsLike.toString());
     CacheHelper.putData(key: "temp", value: _country!.temp.toString());
   }
}

//enum StatusTem { light, rain, snow, thunder }
