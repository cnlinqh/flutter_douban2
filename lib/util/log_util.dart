import 'package:intl/intl.dart';

class LogUtil {
  static bool enable = false;
  static DateFormat format = DateFormat('hh:mm:ss SSS a');
  static log(msg) {
    if (enable) {
      print('${format.format(DateTime.now())} : $msg');
    }
  }
}
