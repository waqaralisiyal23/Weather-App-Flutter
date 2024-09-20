part of 'weather_cubit.dart';

@freezed
class WeatherState with _$WeatherState {
  const factory WeatherState.initial() = _Initial;
  const factory WeatherState.loading() = _Loading;
  const factory WeatherState.success(WeatherEntity weatherEntity) = _Success;
  const factory WeatherState.error(ErrorEntity errorEntity) = _Error;
}
