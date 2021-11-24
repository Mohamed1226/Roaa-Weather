import 'package:roaa_weather/core/app_config.dart';

Uri weatherApiCountry(String country){
  var url =  '${AppConfig.baseUrl}weather?q=$country&appid=${AppConfig.apiKey}';
  return Uri.parse(url);
}


Uri weatherApiLocation(lat,log) {
  var url = '${AppConfig.baseUrl}weather?lat=$lat&lon=$log&appid=${AppConfig.apiKey}';
  return Uri.parse(url);
}