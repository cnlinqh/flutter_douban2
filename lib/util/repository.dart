class Repository {
  static var _caches = new Map();
  static void clearCache() {
    print('=======Repository.clearCache()');
    _caches.clear();
  }

  static List getCachedList(String key) {
    print('=======Repository.getCachedList($key)');
    return _caches[key];
  }

  static void setCachedList(key, list) {
    print('=======Repository.setCachedList($key)');
    _caches[key] = list;
  }

  static bool isCached(String key) {
    print('=======Repository.isCached($key): ' +
        _caches.containsKey(key).toString());
    return _caches.containsKey(key);
  }
}
