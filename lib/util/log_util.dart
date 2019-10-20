class LogUtil {
  static bool enable = true;
  static log(msg) {
    if (enable) print(msg);
  }
}
