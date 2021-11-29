import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:roaa_weather/features/weather/domain/entities/weather_entites.dart';
import 'package:roaa_weather/features/weather/domain/usecases/get_weather_by_country_name_usecases.dart';
import 'package:roaa_weather/features/weather/domain/usecases/get_weather_by_location_usecase.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherByCountryUseCases weatherByCountry;
  final GetWeatherByLocationUseCases weatherLocation;

  WeatherBloc({required this.weatherByCountry, required this.weatherLocation})
      : super(Empty());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {

  }
}
