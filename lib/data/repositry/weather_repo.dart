import 'dart:io';
import 'package:roaa_weather/core/location_retriever.dart';
import 'package:roaa_weather/data/models/weather/country_weather.dart';
import 'package:roaa_weather/data/weather_data_source/local_weather_data_source.dart';
import 'package:roaa_weather/data/weather_data_source/remote_weather_data_source.dart';
import 'package:roaa_weather/presentation/widget/app_toast.dart';

class WeatherRepo {
  RemoteWeatherDataSource remoteWeatherDataSource;
  LocalWeatherDataSource localWeatherDataSource;

  WeatherRepo(this.remoteWeatherDataSource, this.localWeatherDataSource);

  CountryWeather? _country;

  CountryWeather? get country => _country;

  // bool isConnected = true;

  Future<bool> checkConnectionWithInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
       // print("connected ");
        return true;
      }
    } on SocketException catch (_) {
   //   print("Not connected ");
      return false;
    }
    return false;
  }

  Future<CountryWeather?> getWeatherByCountryName(String country) async {
    bool isConnected = await checkConnectionWithInternet();
    print("checking connection");

    if (isConnected) {
      print("i am in connected");

      await remoteWeatherDataSource
          .getWeatherByCountryName(country)
          .then((value) {
        _country = CountryWeather.fromjson(value);
        return _country;
      }).catchError((e) {
        print(e.toString());
        print("error");
        appToast("please input a correct country name");
      });
    }
    if (!isConnected) {
      print("i am in disconnected");
      var result = localWeatherDataSource.getSavedWeather();
      if (result != null) {
        _country = result;
        appToast("Last Saved Weather Open Internet to Refresh");
      } else {
        appToast("No Internet Connection");
      }
    }
    return _country;
  }

  Future<CountryWeather?> getWeatherByUserLocation() async {
    bool isConnected = await checkConnectionWithInternet();
    print("i am in checking connection");
    if (isConnected) {
      var position = await LocationRetriever().retrieve();

      print("i am in connected");

      return await remoteWeatherDataSource
          .getWeatherByUserLocation(position.latitude, position.longitude)
          .then((value) {
        print("i am in then");
        _country = CountryWeather.fromjson(value);
        return _country;
      }).catchError((e) {
        print("i am in catchError");

        print(e.toString());
        print("error");
        if (e.runtimeType is HttpException) {
          print("i am in HttpException");

          appToast("Server Not Found");
        } else if (e.runtimeType is FormatException) {
          print("i am in HttpException");

          appToast("some thing wrong happened");
        } else {
          appToast("please open GBS");
        }
      });
    }
    if (!isConnected) {
      print("i am in disconnected");
      var result = localWeatherDataSource.getSavedWeather();
      if (result != null) {
        _country = result;
        appToast("The Last Saved Weather Open Internet");
      } else {
        appToast("No Internet Connection");
      }
    }
    return _country;
  }
}
