import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:roaa_weather/core/app_tanslations.dart';
import 'package:roaa_weather/presentation/screens/splash/splash_screen.dart';
import 'package:roaa_weather/presentation/screens/weather/weather_provider.dart';
import 'core/app_localization.dart';
import 'core/app_theme.dart';
import 'data/shar_pref.dart';
import 'di/app_injector.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'generated/l10n.dart';

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

            builder: (context, weatherProvider, child) {
             // weatherProvider.getLang(context);
          return MaterialApp(
            // translations: Translation(),
            // locale: Locale('en'),
            // fallbackLocale:  Locale('en'),
            // theme: lightTheme,
            //   darkTheme: AppThemeFactory().create(data.themeType),
            // supportedLocales: [
            //   Locale('en', 'US'),
            //   Locale('ar', 'EG'),
            // ],
            // localizationsDelegates: [
            //   AppLocalization.delegate,
            //   GlobalMaterialLocalizations.delegate,
            //   GlobalWidgetsLocalizations.delegate,
            // ],
            // localeResolutionCallback: (locale, supportedLocales) {
            //   for (var supportedLocale in supportedLocales) {
            //     if (supportedLocale.languageCode == locale!.languageCode &&
            //         supportedLocale.countryCode == locale!.countryCode) {
            //       return supportedLocale;
            //     }
            //     return supportedLocales.first;
            //   }
            // },
            theme: AppThemeFactory().create(weatherProvider.themeType),
            debugShowCheckedModeBanner: false,
            home: const SplashView(),
            localizationsDelegates: const [
              // 1
              S.delegate,
              // 2
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
          );
        }),
      ),
    );
  }
}
