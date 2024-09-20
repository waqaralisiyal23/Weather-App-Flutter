import '../../../core/constants/app_constants.dart';
import '../../domain/common/result.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/i_repositories/i_weather_repository.dart';
import '../common/constants/api_end_point_constants.dart';
import '../common/network/api.dart';
import '../common/object_mapper.dart';
import '../dtos/weather_dto/weather_dto.dart';

class WeatherRepository implements IWeatherRepository {
  final ObjectMapper objectMapper;
  final Api api;

  WeatherRepository({
    required this.objectMapper,
    required this.api,
  });

  @override
  Future<Result<WeatherEntity>> fetchWeatherData(String city) async {
    try {
      final response = await api.post(
        ApiEndPointConstant.weatherInfo,
        queryParameters: {
          'q': city,
          'appid': AppConstants.weatherApiKey,
          'units': 'metric'
        },
      );
      if (response.statusCode == 200) {
        WeatherDto weatherDto = WeatherDto.fromApiJson(response.data);
        return Result.success(objectMapper.toWeatherEntity(weatherDto));
      } else {
        return Result.failed(objectMapper.responseToErrorEntity(response));
      }
    } on Exception catch (e) {
      return Result.failed(objectMapper.toErrorEntity(e));
    }
  }
}
