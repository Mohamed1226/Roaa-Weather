import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:roaa_weather/presentation/screens/splash/splash_screen.dart';
import 'package:roaa_weather/presentation/screens/splash_native/splash_native_screen.dart';
import 'package:roaa_weather/presentation/screens/weather/weather_provider.dart';
import 'core/app_theme.dart';
import 'data/shar_pref.dart';
import 'di/app_injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await CacheHelper.init();

  runApp(DevicePreview(enabled: true, builder: (context) => MyApp()));
 // runApp( MyApp());
}

class MyApp extends StatelessWidget {
  var appInjector = AppInjector();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: appInjector.injectBloc(),
      child: MultiProvider(
        providers: appInjector.injectProvider(),
        child: Consumer<WeatherProvider>(
          builder: (context, data, child) {
            data.checkSavedWeather();
            return MaterialApp(
              // theme: lightTheme,
              //   darkTheme: AppThemeFactory().create(data.themeType),
              theme: AppThemeFactory().create(data.themeType),
              debugShowCheckedModeBanner: false,
              home: SplashView(),
            );
          }
        ),
      ),
    );
  }
}
