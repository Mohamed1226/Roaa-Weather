import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:roaa_weather/view/home_view.dart';
import 'package:roaa_weather/view/sign_screen/login_screen.dart';
import 'package:roaa_weather/view_model/get_weather_view_model.dart';
import 'package:roaa_weather/view_model/login_cubit/login_cubit.dart';

import 'model/shar_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await CacheHelper.init();
  Widget widget;
  var uId = CacheHelper.getData("uId");

  if (uId != null) {
    widget = HomeView();
  } else {
    widget = LogInScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  Widget widget;

  MyApp(this.widget);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CubitLogIn()),
      ],
      child: ChangeNotifierProvider<GetWeatherViewModel>(
        create: (_) => GetWeatherViewModel(),
        child: MaterialApp(
          theme: ThemeData(
            textTheme: const TextTheme(
              bodyText1: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              bodyText2: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: widget,
        ),
      ),
    );
  }
}
