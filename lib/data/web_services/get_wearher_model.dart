import 'dart:convert';

import 'package:http/http.dart' as http;

class GetWeatherModel {
  Future getWeather(String country) async {
    String _APIKEY = "c39edb1f487155d36e655629443197b7";

    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$country&appid=$_APIKEY');
    http.Response _response = await http.get(url);
    //print(response.body);

    var _body = jsonDecode(_response.body);
    return _body;
  }
}
