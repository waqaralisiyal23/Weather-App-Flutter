import '../../domain/common/result.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/i_repositories/i_weather_repository.dart';

class WeatherService {
  final IWeatherRepository _weatherRepository;

  WeatherService(this._weatherRepository);

  Future<Result<WeatherEntity>> fetchWeatherData(String city) {
    return _weatherRepository.fetchWeatherData(city);
  }
}
