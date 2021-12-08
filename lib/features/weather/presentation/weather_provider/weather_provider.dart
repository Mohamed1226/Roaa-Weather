import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:roaa_weather/core/app_theme.dart';
import 'package:roaa_weather/core/error/failures.dart';
import 'package:roaa_weather/core/location_retriever.dart';
import 'package:roaa_weather/core/network/network_info.dart';
import 'package:roaa_weather/core/shared_pref/shar_pref.dart';
import 'package:roaa_weather/core/widget/app_toast.dart';
import 'package:roaa_weather/features/weather/domain/entities/weather_entites.dart';
import 'package:roaa_weather/features/weather/domain/usecases/get_weather_by_country_name_usecases.dart';
import 'package:roaa_weather/features/weather/domain/usecases/get_weather_by_location_usecase.dart';

class WeatherProvider extends ChangeNotifier {
  final GetWeatherByCountryUseCases weatherByCountry;
  final GetWeatherByLocationUseCases weatherLocation;

  WeatherProvider(
      {required this.weatherByCountry, required this.weatherLocation}) {
    checkSavedTheme();
    getWeatherByUserLocation();
  }
bool isConnected=true;
  checkInternet()async{
    isConnected =await NetworkInfoImplCustom().checkConnectionWithInternet();
    notifyListeners();
  }
  checkSavedTheme() {
    var theme = CacheHelper.getData("theme");
    if (theme != null) {
      changeAppTheme(theme);
    }
  }

  //show textFormField
  bool isSearching = false;

  userIsSearching() {
    isSearching = !isSearching;
    notifyListeners();
  }

  WeatherEntities? _country;

  WeatherEntities? get country => _country;

  bool _hasData = false;

  bool get hasData => _hasData;

  //get weather by location

  getWeatherByUserLocation() async {
    LocationRetriever retriever = LocationRetriever();
    final position = await retriever.retrieve();
    final weatherOrFailure = await weatherLocation(
        ParamsL(lat: position.latitude, lon: position.longitude));
    weatherOrFailure.fold((failure) {
      appToast(mapFailuretoString(failure));
    }, (country) {
      _country = country;
      //  print(_country);
      changeImageAccordingTem();

      _hasData = true;
      print("i am in changeImageAccordingTem");
      //  print(country.humidity);
      notifyListeners();
    });
  }

  //get weather by country name

  getWeatherByCountryName(BuildContext context, String countryName) async {
    final weatherOrFailure =
        await weatherByCountry(Params(country: countryName));
    weatherOrFailure.fold((failure) {
      appToast(mapFailuretoString(failure));
    }, (country) {
      _country = country;

      userIsSearching();

      changeImageAccordingTem();

      _hasData = true;
     // print("i am in changeImageAccordingTem");
      notifyListeners();
    });
  }

//
  String mapFailuretoString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Please Input An Correct Country Name";
      case Cachefailure:
        return "No Data Cached";
      default:
        return "Please Try Again ...";
    }
  }

  //change image according temperature
  String image = "";

  changeImageAccordingTem() {
    if (_country!.temp - 273.15 > 30) {
      image = "assets/light.png";
      return;
    }
    if (_country!.temp - 273.15 > 15 && _country!.temp - 273.15 < 30) {
      image = "assets/rain.png";
      return;
    }
    if (_country!.temp - 273.15 > 5 && _country!.temp - 273.15 < 15) {
      image = "assets/snow.png";
      return;
    }
    if (_country!.temp - 273.15 < 5) {
      image = "assets/thunder.png";
      return;
    }

    notifyListeners();
  }

//change valued in DropDownButton
  String value = "orange";

  changeValueInDropDownButton(v) {
    value = v;
    //  print(value);
    notifyListeners();
    savedTheme();
    changeAppTheme(value);
  }

//change app theme
  ThemeType themeType = ThemeType.orange;

  changeAppTheme(String value) {
    if (value == "purple") {
      themeType = ThemeType.purple;
      return;
    }
    if (value == "blue") {
      themeType = ThemeType.blue;

      return;
    }
    if (value == "navyBlue") {
      themeType = ThemeType.navyBlue;

      return;
    }
    if (value == "orange") {
      themeType = ThemeType.orange;

      return;
    }

  }

  savedTheme() {
    CacheHelper.putData(key: "theme", value: value);
  }
}
