import 'package:flutter/material.dart';

import '../../screens/weather/weather_screen.dart';
import '../../screens/splash/splash_screen.dart';
import '../constants/route_constants.dart';

class GeneratedRoute {
  Route onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case RouteConstants.splashRoute:
        return generateRoute(const SplashScreen());
      case RouteConstants.weatherRoute:
        return generateRoute(const WeatherScreen());
      default:
        return generateRoute(const SplashScreen());
    }
  }

  MaterialPageRoute generateRoute(Widget child) {
    return MaterialPageRoute(builder: (context) => child);
  }
}
