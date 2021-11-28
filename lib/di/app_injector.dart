//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
// import 'package:roaa_weather/features/auth/data/auth_data_source/auth_web_service.dart';
// import 'package:roaa_weather/features/auth/data/auth_repository/auth_repo.dart';
// import 'package:roaa_weather/trying_some_code/remote_weather_data_source.dart';
// import 'package:roaa_weather/features/weather/data/weather_repository/weather_repo.dart';
// import 'package:roaa_weather/trying_some_code/local_weather_data_source.dart';
// import 'package:roaa_weather/features/weather/presentation/weather_bloc/weather_bloc.dart';
// import 'package:roaa_weather/features/auth/presentation/auth_bloc/authentication_cubit.dart';
//
// class AppInjector {
//
//   var authWebService = AuthWebService();
//   late AuthRepo authRepo = AuthRepo(authWebService);
//   late AuthCubit cubitLogin = AuthCubit(authRepo);
//
//
// LocalWeatherDataSource localWeatherDataSource=LocalWeatherDataSource();
//   RemoteWeatherDataSource remoteWeatherDataSource = RemoteWeatherDataSource();
//   late WeatherRepo weatherRepo = WeatherRepo(remoteWeatherDataSource,localWeatherDataSource);
//   late WeatherProvider weatherViewModel = WeatherProvider(weatherRepo);
//
//   injectBloc() {
//     return [BlocProvider(create: (context) => cubitLogin)];
//   }
//
//   injectProvider() {
//     return [
//   //    ListenableProvider<WeatherProvider>(create: (context) => weatherViewModel),
//       ChangeNotifierProvider<WeatherProvider>.value(value: weatherViewModel),
//     ];
//   }
// }
