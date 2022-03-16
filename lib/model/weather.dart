import 'package:bloc_sample/bloc/weather_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Weather {
  final String cityName;
  final double temperatureCelsius;

  const Weather({
    required this.cityName,
    required this.temperatureCelsius,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Weather &&
        runtimeType == other.runtimeType &&
        cityName == other.cityName &&
        temperatureCelsius == other.temperatureCelsius;
  }

  @override
  int get hashCode => cityName.hashCode ^ temperatureCelsius.hashCode;
}
