import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../application/services/weather_service.dart';
import '../../../../domain/entities/error_entity.dart';
import '../../../../domain/entities/weather_entity.dart';

part 'weather_state.dart';
part 'weather_cubit.freezed.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService _weatherService;
  WeatherCubit(this._weatherService) : super(const WeatherState.initial());

  Future<void> fetchWeatherData(String city) async {
    emit(const WeatherState.loading());
    final result = await _weatherService.fetchWeatherData(city);
    result.when(
      success: (weatherEntity) {
        emit(WeatherState.success(weatherEntity));
      },
      failed: (error) {
        emit(WeatherState.error(error));
      },
    );
  }
}
