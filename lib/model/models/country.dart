class Country {
  late String name;

  late double temp;
  late int humidity;

  late double wind;
  late int pressure;
  late double feelsLike;

  Country(
      {required this.feelsLike,
      required this.name,
      required this.humidity,
      required this.pressure,
      required this.temp,
      required this.wind});

  Country.fromjson(Map<String, dynamic> json) {
    name = json["name"];
    temp = json["main"]["temp"]  ;
    wind=json["wind"]["speed"];
    humidity=json["main"]["humidity"];
    pressure =json["main"]["pressure"];
    feelsLike=json["main"]["feels_like"];
  }
}
