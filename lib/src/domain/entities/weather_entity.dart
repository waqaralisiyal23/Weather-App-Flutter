import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String name;
  final double temperature;
  final double temperatureMin;
  final double temperatureMax;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;

  const WeatherEntity({
    required this.name,
    required this.temperature,
    required this.temperatureMin,
    required this.temperatureMax,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
  });

  @override
  List<Object?> get props => [
        name,
        temperature,
        temperatureMin,
        temperatureMax,
        description,
        icon,
        humidity,
        windSpeed,
      ];
}
