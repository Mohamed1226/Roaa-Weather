import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:roaa_weather/core/constant.dart';
import 'package:roaa_weather/presentation/screens/splash/splash_screen.dart';
import 'data/shar_pref.dart';
import 'di/app_injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await CacheHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var appInjector = AppInjector();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: appInjector.injectBloc(),
      child: MultiProvider(
        providers: appInjector.injectProvider(),
        child: MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          home: SplashView(),
        ),
      ),
    );
  }
}
