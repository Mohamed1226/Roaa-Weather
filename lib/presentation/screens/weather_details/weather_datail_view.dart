import 'package:flutter/material.dart';
import 'package:roaa_weather/data/models/weather/country_weather.dart';

class WeatherDetailsView extends StatelessWidget {
  CountryWeather country;
  int c;

  WeatherDetailsView(this.country, this.c);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: _sectionAppBar(context),
      body: Container(
          margin: const EdgeInsets.symmetric(vertical: 18),
          width: MediaQuery.of(context).size.width,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                _sectionWeatherImage(context),
                const SizedBox(
                  height: 12,
                ),
                _sectionGridView(context),
              ],
            ),
          )),
    );
  }

  Widget _sectionGridView(BuildContext context) {
    return Expanded(
      child: GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        children: [
          _customCard(context, "Wind", "${country.wind.toString()} meter/sec"),
          _customCard(context, "Pressure", country.pressure.toString()),
          _customCard(context, "FeelsLike", country.feelsLike.toString()),
          _customCard(context, "Humidity", "${country.humidity.toString()} %"),
        ],
      ),
    );
  }

  Widget _customCard(BuildContext context, String type, String value) {
    return Card(
      color: Colors.deepOrange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            type,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }

  _sectionAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.teal,
      title: Text(
        country.name,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }

  Widget _sectionWeatherImage(BuildContext context) {
    return Image.asset(
      c <= 22 ? "assets/storm.png" : "assets/sun.png",
      width: 150,
      height: 150,
      fit: BoxFit.cover,
    );
  }
}
