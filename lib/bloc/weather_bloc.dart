import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bloc_sample/model/weather.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(const WeatherInitial()) {
    on<GetWeather>(onGetWeather);
  }
  void onGetWeather(GetWeather event, Emitter<WeatherState> emit) async {
    emit(const WeatherLoading());
    try {
      final weather = await fetchWeather(event.cityName);
      emit(WeatherLoaded(weather: weather));
    } on Exception {
      emit(WeatherError(message: 'Error! Could not fetch weather'));
    }
  }

  Future<Weather> fetchWeather(String cityName) {
    return Future.delayed(
      const Duration(seconds: 3),
      () {
        final random = Random();

        if (random.nextBool()) {
          throw NetworkException();
        }

        return Weather(
          cityName: cityName,
          temperatureCelsius: 20 + random.nextInt(15) + random.nextDouble(),
        );
      },
    );
  }
}

class NetworkException implements Exception {}
