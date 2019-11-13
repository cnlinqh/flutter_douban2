import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/log_util.dart';
import 'package:flutter_douban2/util/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MineSettingsModel extends ChangeNotifier {
  int _photoColumnsNumPortait = 2;
  int get photoColumnsNumPortait => _photoColumnsNumPortait;
  void setPhotoColumnsNumPortait(int value) {
    if (value > 0) {
      this._photoColumnsNumPortait = value;
      notifyListeners();
      save('int', '_photoColumnsNumPortait', _photoColumnsNumPortait);
    }
  }

  int _photoColumnsNumLandscape = 6;
  int get photoColumnsNumLandscape => _photoColumnsNumLandscape;
  void setPhotoColumnsNumLandscape(int value) {
    if (value > 0) {
      this._photoColumnsNumLandscape = value;
      notifyListeners();
      save('int', '_photoColumnsNumLandscape', _photoColumnsNumLandscape);
    }
  }

  int _photoColumnsNumSquare = 3;
  int get photoColumnsNumSquare => _photoColumnsNumSquare;
  void setPhotoColumnsNumSquare(int value) {
    if (value > 0) {
      this._photoColumnsNumSquare = value;
      notifyListeners();
      save('int', '_photoColumnsNumSquare', _photoColumnsNumSquare);
    }
  }

  static const List photoSizes = ['s', 'm', 'l', 'xl'];

  int _photoSizeIndex = 3; //s,m,l,xl
  int get photoSizeIndex => _photoSizeIndex;
  void setPhotoSizeIndex(value) {
    this._photoSizeIndex = value;
    notifyListeners();
    save('int', '_photoSizeIndex', _photoSizeIndex);
  }

  bool _cacheDataInMemory = true;
  bool get cacheDataInMemory => _cacheDataInMemory;
  void setCacheDataInMemory(value) {
    this._cacheDataInMemory = value;
    notifyListeners();
    save('bool', '_cacheDataInMemory', _cacheDataInMemory);
    Repository.enabled = _cacheDataInMemory;
    if (!Repository.enabled) {
      Repository.clearCache();
    }
  }

  bool _logEnabled = false;
  bool get logEnabled => _logEnabled;
  void setLogEnabled(value) {
    this._logEnabled = value;
    notifyListeners();
    save('bool', '_logEnabled', _logEnabled);
    LogUtil.enable = _logEnabled;
  }

  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _photoColumnsNumPortait = prefs.getInt('_photoColumnsNumPortait') ?? _photoColumnsNumPortait;
    _photoColumnsNumLandscape = prefs.getInt('_photoColumnsNumLandscape') ?? _photoColumnsNumLandscape;
    _photoColumnsNumSquare = prefs.getInt('_photoColumnsNumSquare') ?? _photoColumnsNumSquare;
    _photoSizeIndex = prefs.getInt('_photoSizeIndex') ?? _photoSizeIndex;
    _cacheDataInMemory = prefs.getBool('_cacheDataInMemory') ?? _cacheDataInMemory;
    Repository.enabled = _cacheDataInMemory;
    if (!Repository.enabled) {
      Repository.clearCache();
    }
    _logEnabled = prefs.getBool('_logEnabled') ?? _logEnabled;
    LogUtil.enable = _logEnabled;

    LogUtil.log('_photoColumnsNumPortait $_photoColumnsNumPortait');
    LogUtil.log('_photoColumnsNumLandscape $_photoColumnsNumLandscape');
    LogUtil.log('_photoColumnsNumSquare $_photoColumnsNumSquare');
    LogUtil.log('_photoSizeIndex $_photoSizeIndex');
    LogUtil.log('_cacheDataInMemory $_cacheDataInMemory');
    LogUtil.log('_logEnabled $_logEnabled');
  }

  restore() {
    setPhotoColumnsNumPortait(2);
    setPhotoColumnsNumLandscape(6);
    setPhotoColumnsNumSquare(3);
    setPhotoSizeIndex(3);
    setCacheDataInMemory(true);
    setLogEnabled(false);
    notifyListeners();
  }

  save(String type, String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (type == 'int') {
      await prefs.setInt(key, value);
    } else if (type == 'string') {
      await prefs.setString(key, value);
    } else if (type == 'bool') {
      await prefs.setBool(key, value);
    }
  }
}
