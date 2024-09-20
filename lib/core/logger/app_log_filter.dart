import 'package:logger/logger.dart';

class AppLogFilter extends LogFilter {
  final bool enableLogger;

  AppLogFilter(this.enableLogger);

  @override
  bool shouldLog(LogEvent event) => enableLogger;
}
