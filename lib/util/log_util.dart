class LogUtil {
  static bool enable = false;
  static log(msg) {
    if (enable) print(msg);
  }
}
