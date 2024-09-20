import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../core/logger/app_log_filter.dart';
import '../src/application/services/weather_service.dart';
import '../src/domain/i_repositories/i_weather_repository.dart';
import '../src/infrastructure/common/constants/api_end_point_constants.dart';
import '../src/infrastructure/common/network/api.dart';
import '../src/infrastructure/common/network/api_interceptor.dart';
import '../src/infrastructure/common/object_mapper.dart';
import '../src/infrastructure/repositories/weather_repository.dart';
import '../src/presentation/common/routes/navigation_route.dart';
import '../src/presentation/screens/weather/weather_cubit/weather_cubit.dart';

final getIt = GetIt.instance;

Future<void> initializeInjectedDependencies(
    {required bool enableLogger}) async {
  await _injectUtilities(enableLogger: enableLogger);
  await _initializeData(enableLogger: enableLogger);
  _initServices();
  _injectCubits();
}

Future<void> _injectUtilities({required bool enableLogger}) async {
  getIt.registerLazySingleton(
    () => Logger(filter: AppLogFilter(enableLogger)),
  );
  getIt.registerLazySingleton(
    () => NavigationRoute(getIt.get()),
  );
  getIt.registerLazySingleton(
    () => ObjectMapper(),
  );
}

Future<void> _initializeData({required bool enableLogger}) async {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiEndPointConstant.baseUrl,
      contentType: 'application/json',
    ),
  );
  dio.interceptors.add(ApiInterceptor());
  if (enableLogger) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
      ),
    );
  }
  getIt.registerSingleton(
    Api(dio),
  );

  getIt.registerLazySingleton<IWeatherRepository>(
    () => WeatherRepository(
      objectMapper: getIt.get(),
      api: getIt.get(),
    ),
  );
}

void _initServices() {
  getIt.registerLazySingleton(
    () => WeatherService(getIt.get()),
  );
}

void _injectCubits() {
  getIt.registerFactory(
    () => WeatherCubit(getIt.get()),
  );
}
