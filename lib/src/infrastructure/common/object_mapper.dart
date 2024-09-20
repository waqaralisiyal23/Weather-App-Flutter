import 'package:dio/dio.dart';

import '../../domain/entities/error_entity.dart';
import '../../domain/entities/weather_entity.dart';
import '../dtos/weather_dto/weather_dto.dart';

class ObjectMapper {
  WeatherEntity toWeatherEntity(WeatherDto weatherDto) {
    return WeatherEntity(
      name: weatherDto.name,
      temperature: weatherDto.temperature,
      temperatureMin: weatherDto.temperatureMin,
      temperatureMax: weatherDto.temperatureMax,
      description: weatherDto.description,
      icon: weatherDto.icon,
      humidity: weatherDto.humidity,
      windSpeed: weatherDto.windSpeed,
    );
  }

  WeatherDto toWeatherDto(WeatherEntity weatherEntity) {
    return WeatherDto(
      name: weatherEntity.name,
      temperature: weatherEntity.temperature,
      temperatureMin: weatherEntity.temperatureMin,
      temperatureMax: weatherEntity.temperatureMax,
      description: weatherEntity.description,
      icon: weatherEntity.icon,
      humidity: weatherEntity.humidity,
      windSpeed: weatherEntity.windSpeed,
    );
  }

  ErrorEntity toErrorEntity(Exception e) {
    if (e is DioException) {
      if (e.type == DioExceptionType.badResponse) {
        if (e.response != null && e.response!.data != null) {
          return responseToErrorEntity(e.response!);
        } else {
          return ErrorEntity(
            statusCode: e.response?.statusCode ?? ErrorEntity.kUnknown,
            message: e.message ?? e.toString(),
          );
        }
      } else {
        return ErrorEntity(
          statusCode: e.response?.statusCode ?? ErrorEntity.kUnknown,
          message: e.message ?? e.toString(),
        );
      }
    } else {
      return ErrorEntity(message: e.toString());
    }
  }

  ErrorEntity responseToErrorEntity(Response response) {
    if (response.data == null) {
      return ErrorEntity(
        statusCode: response.statusCode ?? ErrorEntity.kUnknown,
        message: 'Something went wrong!',
      );
    } else {
      return ErrorEntity(
        statusCode: response.statusCode ?? ErrorEntity.kUnknown,
        message: response.data['message'] ?? 'Something went wrong!',
      );
    }
  }
}
