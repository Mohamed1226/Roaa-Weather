class CountryWeather {
  late String _name;

  late double _temp;
  late int _humidity;

  late double _wind;
  late int _pressure;
  late double _feelsLike;
  late num _lat;
  late num _lon;
  late String _description;

  String get name => _name;

  String get description => _description;

  double get temp => _temp;

  int get humidity => _humidity;

  double get wind => _wind;

  num get lat => _lat;

  num get log => _lon;

  int get pressure => _pressure;

  double get feelsLike => _feelsLike;

  CountryWeather(
      {required feelsLike,
      required name,
      required humidity,
      required pressure,
      required temp,
      required wind,
      required lat,
      required lon,
      required description})
      : _feelsLike = feelsLike,
        _temp = temp,
        _name = name,
        _humidity = humidity,
        _pressure = pressure,
        _wind = wind,
        _description = description,
        _lat = lat,
        _lon = lon;

  CountryWeather.fromjson(Map<String, dynamic> json) {
    _name = json["name"];
    _temp = json["main"]["temp"];
    _wind = json["wind"]["speed"];
    _humidity = json["main"]["humidity"];
    _pressure = json["main"]["pressure"];
    _feelsLike = json["main"]["feels_like"];

    _description = json["weather"][0]["main"];
    _lat = json["coord"]["lat"];
    _lon = json["coord"]["lon"];
  }


  Map<String,dynamic>  toMap() {
   return {
   "name" : _name,
     "temp":_temp,
     "wind":_wind,
     "humidity":_humidity,
     "pressure":_pressure,
     "feels_like":_feelsLike,
     "main":_description,
     "lat":_lat,
     "lon":_lon,

   };

  }
}

CountryWeather initialCountryWeather = CountryWeather(
    feelsLike: 20.0,
    name: "london",
    lat: 20.0,
    lon: 40.0,
    description: "clear",
    humidity: 20,
    pressure: 20,
    temp: 20.0,
    wind: 20.0);
