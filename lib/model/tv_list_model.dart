import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';

class TVListModel extends ChangeNotifier {
  Map map = Map();

  String _mode = "ListView"; //ListView or GridView

  String get mode => _mode;

  set mode(value) {
    this._mode = value;
    // map.keys.forEach((key){
    //   TVListInstance instance  = map[key];
    //   instance.refresh();
    // });
    notifyListeners();
  }

  String _sort = 'recommend';

  String get sort => _sort;

  set sort(value) {
    this._sort = value;
    map.keys.forEach((key) {
      TVListInstance instance = map[key];
      instance.refresh(sort);
    });
    notifyListeners();
  }

  init(tag) {
    TVListInstance instance = TVListInstance();
    instance.init(tag, sort);
    map[tag] = instance;
  }

  more(tag) {
    TVListInstance instance = map[tag];
    instance.more(notifyListeners);
  }

  loading(tag, index) {
    TVListInstance instance = map[tag];
    return instance.loading(index);
  }

  tvs(tag) {
    TVListInstance instance = map[tag];
    return instance.list;
  }
}

class TVListInstance {
  static const String _LOADING = '##loading##';

  String _tag;
  bool _calling = false;
  bool _done;
  int _start;
  int _count;
  String _sort;

  List _list = [
    {
      "title": _LOADING,
    }
  ];

  List get list {
    return _list;
  }

  bool loading(index) {
    return this._list[index]['title'] == _LOADING;
  }

  void refresh(sort) {
    _start = 0;
    _count = 20;
    _sort = sort;
    _done = false;
    _list.removeRange(0, _list.length - 1);
  }

  void init(tag, sort) {
    _tag = tag;
    _sort = sort;
    _start = 0;
    _count = 20;
    _done = false;
    _list.removeRange(0, _list.length - 1);
  }

  void more(func) async {
    if (_done) {
      return;
    }
    if (_calling) {
      return;
    }
    _calling = true;
    var more = await ClientAPI.getInstance().searchTvs(start: _start, count: _count, tag: _tag, sort: _sort);
    _list.insertAll(_list.length - 1, more);
    _start = _start + more.length;
    if (more.length < _count) {
      _done = true;
    }
    func();
    _calling = false;
  }
}
