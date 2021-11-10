//
//
//
//
// import 'package:roaa_weather/data/models/country_weather.dart';
// import 'package:roaa_weather/data/web_services/get_wearher_model.dart';
//
// class GetWeatherRepo {
// GetWeatherModel model =GetWeatherModel();
//
// CountryWeather _country = CountryWeather(
//     feelsLike: 20.0,
//     name: "london",
//     humidity: 20,
//     pressure: 20,
//     temp: 20.0,
//     wind: 20.0);
//
// CountryWeather get country => _country;
// Future<CountryWeather>  repoWeather(String country) async{
//
//   await model.getWeather(country).then((value) {
//     _country = CountryWeather.fromjson(value);
// return _country;
//   }).catchError((e){
//     print(e.toString());
//   });
//
//
// }
//
//   }