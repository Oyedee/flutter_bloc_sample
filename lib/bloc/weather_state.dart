part of 'weather_bloc.dart';

abstract class WeatherState {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

class WeatherLoaded extends WeatherState {
  final Weather weather;

  WeatherLoaded({required this.weather});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WeatherLoaded && other.weather == weather;
  }

  @override
  int get hashCode => weather.hashCode;
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError({required this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WeatherError && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
