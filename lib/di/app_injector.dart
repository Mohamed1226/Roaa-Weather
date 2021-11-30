import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:roaa_weather/core/network/network_info.dart';
import 'package:roaa_weather/features/auth/data/auth_data_source/auth_web_service.dart';
import 'package:roaa_weather/features/auth/data/auth_repository/auth_repo.dart';
import 'package:roaa_weather/features/auth/presentation/auth_bloc/authentication_cubit.dart';
import 'package:roaa_weather/features/weather/data/weather_data_source/weather_local_data_source.dart';
import 'package:roaa_weather/features/weather/data/weather_data_source/weather_remote_data_source.dart';
import 'package:roaa_weather/features/weather/data/weather_repository/weather_repo.dart';
import 'package:roaa_weather/features/weather/domain/repository/weather_repository.dart';
import 'package:roaa_weather/features/weather/domain/usecases/get_weather_by_country_name_usecases.dart';
import 'package:roaa_weather/features/weather/domain/usecases/get_weather_by_location_usecase.dart';

import 'package:roaa_weather/features/weather/presentation/weather_bloc/weather_bloc.dart';
import 'package:roaa_weather/features/weather/presentation/weather_provider/weather_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  ////////features auth
  //
  // var authWebService = AuthWebService();
  // late AuthRepo authRepo = AuthRepo(authWebService);
  // late AuthCubit cubitLogin = AuthCubit(authRepo);

  /////features weather
  //bloc
  // sl.registerFactory(
  //     () => WeatherBloc(weatherByCountry: sl(), weatherLocation: sl()));
//provider
  sl.registerFactory(
      () => WeatherProvider(weatherByCountry: sl(), weatherLocation: sl()));

//useCases
  sl.registerLazySingleton(() => GetWeatherByCountryUseCases(sl())); //////core
  sl.registerLazySingleton(() => GetWeatherByLocationUseCases(sl())); //////core

//repository
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
      networkInfo: sl(),
      weatherLocalDataSource: sl(),
      weatherRemoteDataSource: sl()));

  //data sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<WeatherLocalDataSource>(() =>WeatherLocalDataSourceImpl());

  //////core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplCustom());

  //////external


  sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton(() => DataConnectionChecker());
}

injectProvider2()  {
  return [
    ChangeNotifierProvider<WeatherProvider>.value(value: sl<WeatherProvider>()),
  ];
}

class AppInjector {
  var authWebService = AuthWebService();
  late AuthRepo authRepo = AuthRepo(authWebService);
  late AuthCubit cubitLogin = AuthCubit(authRepo);

  //
  // LocalWeatherDataSource localWeatherDataSource = LocalWeatherDataSource();
  // RemoteWeatherDataSource remoteWeatherDataSource = RemoteWeatherDataSource();
  // NetworkInfo networkInfo = NetworkInfoImpl(dataConnectionChecker);
  // DataConnectionChecker dataConnectionChecker = DataConnectionChecker();
  //
  // late WeatherRepository weatherRepo = WeatherRepositoryImpl();
  // late WeatherProvider weatherViewModel = WeatherProvider(weatherRepo);
  //
  injectBloc() {
    return [BlocProvider(create: (context) => cubitLogin)];
  }

  late WeatherProvider weatherProvider = WeatherProvider(
      weatherByCountry: getWeatherByCountryUseCases,
      weatherLocation: getWeatherByLocationUseCases);
  late GetWeatherByCountryUseCases getWeatherByCountryUseCases =
      GetWeatherByCountryUseCases(repository);
  late GetWeatherByLocationUseCases getWeatherByLocationUseCases =
      GetWeatherByLocationUseCases(repository);
  late WeatherRepository repository = WeatherRepositoryImpl(
      networkInfo: networkInfo,
      weatherLocalDataSource: weatherLocalDataSource,
      weatherRemoteDataSource: weatherRemoteDataSource);
  late NetworkInfo networkInfo = NetworkInfoImplCustom();
  late WeatherRemoteDataSource weatherRemoteDataSource =
      WeatherRemoteDataSourceImpl(client: http.Client());

  // Future<SharedPreferences> initShared()async{
  //    return await SharedPreferences.getInstance();
  //  }

  late WeatherLocalDataSource weatherLocalDataSource =
      WeatherLocalDataSourceImpl();

  injectProvider()  {
    return [
      ChangeNotifierProvider<WeatherProvider>.value(value: weatherProvider),
    ];
  }
}
