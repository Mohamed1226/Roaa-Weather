import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:roaa_weather/data/repositry/auth_repo.dart';
import 'package:roaa_weather/data/repositry/weather_repo.dart';
import 'package:roaa_weather/data/web_services/auth_web_service.dart';
import 'package:roaa_weather/data/web_services/wearher_web_service.dart';
import 'package:roaa_weather/presentation/screens/weather/weather_provider.dart';
import 'package:roaa_weather/presentation/shared/cubit/authentication_cubit.dart';

class AppInjector {
  var authWebService = AuthWebService();
  late AuthRepo authRepo = AuthRepo(authWebService);
  late AuthCubit cubitLogin = AuthCubit(authRepo);

  var weatherWebService = WeatherWebService();
  late WeatherRepo weatherRepo = WeatherRepo(weatherWebService);
  late WeatherProvider weatherViewModel = WeatherProvider(weatherRepo);

  injectBloc() {
    return [BlocProvider(create: (context) => cubitLogin)];
  }

  injectProvider() {
    return [
      ListenableProvider<WeatherProvider>(create: (context) => weatherViewModel)
    ];
  }
}
