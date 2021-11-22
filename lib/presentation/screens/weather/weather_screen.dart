import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roaa_weather/core/app_theme.dart';
import 'package:roaa_weather/data/shar_pref.dart';
import 'package:roaa_weather/generated/l10n.dart';
import 'package:roaa_weather/presentation/screens/login/login_screen.dart';
import 'package:roaa_weather/presentation/screens/weather/weather_provider.dart';
import 'package:roaa_weather/presentation/widget/app_card.dart';

class WeatherScreen extends StatelessWidget {
  TextEditingController countryController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var weatherViewModel = Provider.of<WeatherProvider>(context);
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                        radius: 60,
                        child: Image.asset(
                          "assets/thunder.png",
                          fit: BoxFit.cover,
                        )),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  weatherViewModel.getWeatherByUserLocation();
                  Navigator.of(context).pop();
                },
                child: Text(
                  S.of(context).Open_GPS,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  CacheHelper.putData(key: "uId", value: "");
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LogInScreen()));
                },
                child: Text(S.of(context).Sign_Out),
              ),
            ],
          ),
        ),
      ),
      appBar: _appBar(context, weatherViewModel),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 50),
              width: MediaQuery.of(context).size.width,
              child: Column(
               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
             //   crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (!weatherViewModel.isConnected)
                     Text(
                      S.of(context).check_internet,
                      style:const TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  if (!weatherViewModel.isConnected)
                    const SizedBox(
                      height: 6,
                    ),
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
      ),
    );
  }

  List themes = ['orange', "blue", "navyBlue", "purple"];

  _appBar(BuildContext context, weatherViewModel) {
    return AppBar(
      title: Text(
        S.of(context).Flutter_Weather,
        style: Theme.of(context).textTheme.headline2,
      ),
      backgroundColor: Theme.of(context).appBarTheme.color,
      // backgroundColor: Theme.of(context).,
      actions: [
        DropdownButton(
            //  value: weatherViewModel.value,
            onChanged: (v) {
              weatherViewModel.changeValueInDropDownButton(v);
            },
            items: themes
                .map((theme) => DropdownMenuItem(
                      value: theme,
                      child: Text(theme),
                    ))
                .toList(),
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
            : Expanded(
                child: Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width - 100,
                  child: TextFormField(
                      cursorColor: Colors.white,
                      controller: countryController,
                      validator: (v) {
                        if (v.toString().isEmpty) {
                          return S.of(context).Search_can_not_be_empty;
                        } else {}
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.deepOrange),
                            borderRadius: BorderRadius.circular(20)),
                        focusColor: Colors.white,
                        labelText:S.of(context).search_country,
                        labelStyle: Theme.of(context).textTheme.bodyText2,
                        suffix: IconButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              weatherViewModel.getWeatherByCountryName(
                                  context, countryController.text);
                              weatherViewModel.checkSavedWeather();
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
                  "${(model.country!.temp - 273.15).toInt()}°C",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${S.of(context).FeelsLike} ${(model.country!.feelsLike - 273.15).toInt()}°C",
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
          appCard(context, S.of(context).Wind, "${model.country.wind.toString()}m/s"),
          appCard(context,S.of(context).Pressure, model.country.pressure.toString()),
          appCard(context, S.of(context).FeelsLike,
              "${(model.country!.feelsLike - 273.15).toInt()}°C"),
          appCard(context, S.of(context).Humidity, "${model.country.humidity.toString()}%"),
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
              S.of(context).search_country,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Text(
           S.of(context).OR,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          ElevatedButton(
            onPressed: () {
              model.getWeatherByUserLocation();
            },
            child: Text(
             S.of(context).Open_GPS,
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
