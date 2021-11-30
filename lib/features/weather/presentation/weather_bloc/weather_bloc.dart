// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:roaa_weather/core/error/failures.dart';
// import 'package:roaa_weather/features/weather/domain/entities/weather_entites.dart';
// import 'package:roaa_weather/features/weather/domain/usecases/get_weather_by_country_name_usecases.dart';
// import 'package:roaa_weather/features/weather/domain/usecases/get_weather_by_location_usecase.dart';
//
// part 'weather_event.dart';
//
// part 'weather_state.dart';
//
// class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
//   final GetWeatherByCountryUseCases weatherByCountry;
//   final GetWeatherByLocationUseCases weatherLocation;
//
//   WeatherBloc({required this.weatherByCountry, required this.weatherLocation})
//       : super(Empty());
//
//   String image = "assets/light.png";
//
//   changeImageAccordingTem(temp) {
//     if (temp - 273.15 > 30) {
//       image = "assets/light.png";
//       return;
//     }
//     if (temp - 273.15 > 15 && temp - 273.15 < 30) {
//       image = "assets/rain.png";
//       return;
//     }
//     if (temp - 273.15 > 5 && temp - 273.15 < 15) {
//       image = "assets/snow.png";
//       return;
//     }
//     if (temp - 273.15 < 5) {
//       image = "assets/thunder.png";
//       return;
//     }
//   }
//
//   @override
//   Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
//     if (event is GetWeatherByCountry) {
//       yield Loading();
//       final weatherOrFailure =
//           await weatherByCountry(Params(country: event.country));
//       yield weatherOrFailure.fold(
//           (failure) => Error(message: mapFailuretoString(failure)), (weather) {
//         changeImageAccordingTem(weather.temp);
//
//         return Loaded(weather: weather);
//       });
//     } else if (event is GetWeatherByLocation) {
//       yield Loading();
//       final weatherOrFailure =
//           await weatherLocation(ParamsL(lat: event.lat, lon: event.log));
//       yield weatherOrFailure.fold(
//           (failure) => Error(message: mapFailuretoString(failure)), (weather) {
//         changeImageAccordingTem(weather.temp);
//         return Loaded(weather: weather);
//       });
//     }
//   }
// }
//
// String mapFailuretoString(Failure failure) {
//   switch (failure.runtimeType) {
//     case ServerFailure:
//       //  print("case ThemeType.orange:");
//       return "Server Failure";
//     case Cachefailure:
//       //  print("case ThemeType.orange:");
//       return "Cache failure";
//     default:
//       return "anthor error";
//   }
// }
