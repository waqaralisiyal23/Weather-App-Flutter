import '../common/result.dart';
import '../entities/weather_entity.dart';

abstract class IWeatherRepository {
  Future<Result<WeatherEntity>> fetchWeatherData(String city);
}
