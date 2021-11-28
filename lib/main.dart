import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:roaa_weather/features/auth/presentation/pages/splash/splash_screen.dart';
import 'core/app_theme.dart';
import 'core/shared_pref/shar_pref.dart';
import 'di/app_injector.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
        child:  MaterialApp(
              theme: AppThemeFactory().create(ThemeType.blue),
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
            ),

      ),
    );
  }
}
