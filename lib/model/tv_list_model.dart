import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';

class TVListModel extends ChangeNotifier {
  Map map = Map();

  init(tag) {
    TVListInstance instance = new TVListInstance();
    instance.init(tag);
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

  void init(tag) {
    _tag = tag;
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
    var more = await ClientAPI.getInstance().searchTvs(start: _start, count: _count, tag: _tag);
    _list.insertAll(_list.length - 1, more);
    _start = _start + more.length;
    if (more.length < _count) {
      _done = true;
    }
    func();
    _calling = false;
  }
}
