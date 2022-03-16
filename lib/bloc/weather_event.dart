part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {
  const WeatherEvent();
}

class GetWeather extends WeatherEvent {
  final String cityName;
  const GetWeather({required this.cityName});
}
