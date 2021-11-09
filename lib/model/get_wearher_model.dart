import 'dart:convert';

import 'package:http/http.dart' as http;


class GetWeatherModel {
  Future getWeather(String country) async {
   String APIKEY="c39edb1f487155d36e655629443197b7";

      var url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$country&appid=$APIKEY');
      http.Response response = await http.get(url);
      //print(response.body);
      var body=jsonDecode(response.body);
      return body;

  }
}
