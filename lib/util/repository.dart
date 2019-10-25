import 'package:flutter_douban2/util/log_util.dart';

class Repository {
  static var _caches = new Map();
  static void clearCache() {
    LogUtil.log('=======Repository.clearCache()');
    _caches.clear();
  }

  static List getCachedList(String key) {
    LogUtil.log('=======Repository.getCachedList($key)');
    return _caches[key];
  }

  static void setCachedList(key, list) {
    LogUtil.log('=======Repository.setCachedList($key)');
    _caches[key] = list;
  }

  static dynamic getCachedObject(String key) {
    LogUtil.log('=======Repository.getCachedObject($key)');
    return _caches[key];
  }

  static void setCachedObject(key, obj) {
    LogUtil.log('=======Repository.setCachedObject($key)');
    _caches[key] = obj;
  }

  static bool isCached(String key) {
    LogUtil.log('=======Repository.isCached($key): ' + _caches.containsKey(key).toString());
    return _caches.containsKey(key);
  }
}
