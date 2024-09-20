import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_dto.freezed.dart';
part 'weather_dto.g.dart';

@freezed
class WeatherDto with _$WeatherDto {
  const factory WeatherDto({
    required String name,
    required double temperature,
    required double temperatureMin,
    required double temperatureMax,
    required String description,
    required String icon,
    required int humidity,
    required double windSpeed,
  }) = _WeatherDto;

  factory WeatherDto.fromJson(Map<String, dynamic> json) =>
      _$WeatherDtoFromJson(json);

  factory WeatherDto.fromApiJson(Map<String, dynamic> json) {
    return WeatherDto(
      name: json['name'],
      temperature: json['main']['temp'],
      temperatureMax: json['main']['temp_min'],
      temperatureMin: json['main']['temp_max'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
    );
  }
}
