import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:roaa_weather/features/weather/domain/entities/weather_entites.dart';
import 'package:roaa_weather/features/weather/domain/repository/weather_repository.dart';
import 'package:roaa_weather/features/weather/domain/usecases/get_weather_by_country_name_usecases.dart';

class MockGetWeatherRepository extends Mock implements WeatherRepository {}

void main() {
late  GetWeatherByCountry useCases;
late  MockGetWeatherRepository mockGetWeatherRepository;
  setUp(() {
    mockGetWeatherRepository = MockGetWeatherRepository();
    useCases = GetWeatherByCountry(mockGetWeatherRepository);
  });
  final weather = WeatherEntities(
      name: "name",
      temp: 235,
      humidity: 6,
      wind: 65.0,
      pressure: 55,
      feelsLike: 655,
      lat: 46.2,
      lon: 52.5,
      description: "description");

  const country = "london";

  test("should get weather foe country from repository", () async {
    when(mockGetWeatherRepository.getWeatherByCountryName("london"))
        .thenAnswer((_) async => Right(weather));
    final result=await useCases.call(Params(country: country));
    expect(result, Right(weather));
    verify(mockGetWeatherRepository.getWeatherByCountryName(country));
    verifyNoMoreInteractions(mockGetWeatherRepository);
  });
}
