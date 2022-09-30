import 'package:simple_logger/simple_logger.dart';

final SimpleLogger log = SimpleLogger()
  ..mode = LoggerMode.print
  ..setLevel(
    Level.FINEST,
    includeCallerInfo: true,
  );

class Utils {
  static String formatTime(int timeInSecond) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min != 0 ? '${min}m' : '';
    String second = sec != 0 ? '${sec}s' : '';
    return "$minute$second";
  }
}
