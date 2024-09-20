import 'package:intl/intl.dart';

class FormatUtils {
  static String getFormattedTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  static String getFormattedDayAndDate(DateTime dateTime) {
    return DateFormat('EEEE, dd MMM yyyy').format(dateTime);
  }
}
