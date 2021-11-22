
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:roaa_weather/data/auth_services/auth_web_service.dart';
import 'package:roaa_weather/data/repositry/auth_repo.dart';
import 'package:roaa_weather/data/repositry/weather_repo.dart';
import 'package:roaa_weather/data/weather_data_source/local_weather_data_source.dart';
import 'package:roaa_weather/data/weather_data_source/remote_weather_data_source.dart';
import 'package:roaa_weather/presentation/screens/weather/weather_provider.dart';
import 'package:roaa_weather/presentation/shared/cubit/authentication_cubit.dart';

class AppInjector {

  var authWebService = AuthWebService();
  late AuthRepo authRepo = AuthRepo(authWebService);
  late AuthCubit cubitLogin = AuthCubit(authRepo);


LocalWeatherDataSource localWeatherDataSource=LocalWeatherDataSource();
  RemoteWeatherDataSource remoteWeatherDataSource = RemoteWeatherDataSource();
  late WeatherRepo weatherRepo = WeatherRepo(remoteWeatherDataSource,localWeatherDataSource);
  late WeatherProvider weatherViewModel = WeatherProvider(weatherRepo);

  injectBloc() {
    return [BlocProvider(create: (context) => cubitLogin)];
  }

  injectProvider() {
    return [
  //    ListenableProvider<WeatherProvider>(create: (context) => weatherViewModel),
      ChangeNotifierProvider<WeatherProvider>.value(value: weatherViewModel),
    ];
  }
}
