import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roaa_weather/presentation/screens/weather/weather_provider.dart';
import 'package:roaa_weather/presentation/widget/app_card.dart';

class WeatherScreen extends StatelessWidget {
  TextEditingController countryController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var weatherViewModel = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: _appBar(context, weatherViewModel),
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 50),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    weatherViewModel.hasData
                        ? _modelHasData(weatherViewModel, context)
                        : _modelNotHasData(weatherViewModel, context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _appBar(BuildContext context, weatherViewModel) {
    return AppBar(
      title: Text(
        "Flutter Weather",
        style: Theme.of(context).textTheme.bodyText1,
      ),
      backgroundColor: Theme.of(context).appBarTheme.color,
      // backgroundColor: Theme.of(context).,
      actions: [
        DropdownButton(
          items: [],

            icon: Icon(
              Icons.settings,
              color: Theme.of(context).iconTheme.color,
            )),
        !weatherViewModel.isSearching
            ? IconButton(
                onPressed: () {
                  weatherViewModel.userIsSearching();
                },
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).iconTheme.color,
                ))
            : Container(
                height: 30,
                width: MediaQuery.of(context).size.width - 100,
                child: TextFormField(
                    cursorColor: Colors.white,
                    controller: countryController,
                    validator: (v) {
                      if (v.toString().isEmpty) {
                        return "Search can not be empty";
                      } else {}
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepOrange),
                          borderRadius: BorderRadius.circular(20)),
                      focusColor: Colors.white,
                      labelText: "Search For Your Country Weather",
                      labelStyle: Theme.of(context).textTheme.bodyText2,
                      suffix: IconButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            weatherViewModel.getWeatherByCountryName(
                                context, countryController.text);

                            countryController.clear();
                            //   provider.getAllCountries();
                          }
                        },
                        icon: Icon(
                          Icons.search,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ),
                    onFieldSubmitted: (v) {
                      if (formKey.currentState!.validate()) {
                        weatherViewModel.getWeatherByCountryName(
                            context, countryController.text);
                        countryController.clear();
                      }
                    },
                    keyboardType: TextInputType.emailAddress),
              ),
      ],
    );
  }

  _modelHasData(model, context) {
    return Column(
      children: [
        Text(
          model.country!.name,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_on,
              color: Colors.white,
              size: 16,
            ),
            Text(
              "${model.country!.lat} , ",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Text(
              "${model.country!.log}",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              model.image,
              width: 50,
              height: 50,
            ),
            Column(
              children: [
                Text(
                  "${(model.country!.temp - 273.15).toInt()} C",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Feels Like ${(model.country!.feelsLike - 273.15).toInt()} C",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          "${model.country!.description}",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(
          height: 10,
        ),
        _sectionGridView(model, context)
      ],
    );
  }

  Widget _sectionGridView(model, BuildContext context) {
    return Container(
      height: 300,
      child: GridView.count(
        childAspectRatio: (3 / 2),
        crossAxisCount: 2,
        children: [
          appCard(context, "Wind", "${model.country.wind.toString()} m/s"),
          appCard(context, "Pressure", model.country.pressure.toString()),
          appCard(context, "FeelsLike",
              "${(model.country!.feelsLike - 273.15).toInt()} C"),
          appCard(
              context, "Humidity", "${model.country.humidity.toString()} %"),
        ],
      ),
    );
  }

  _modelNotHasData(model, context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Text(
              "Search For Your Country Weather ",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Text(
            "--OR--",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          ElevatedButton(
            onPressed: () {
              model.getCurrentLocation(context);
            },
            child: Text(
              "Open GPS",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            "assets/weather_app.jpg",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
