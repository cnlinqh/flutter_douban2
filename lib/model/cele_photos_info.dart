import 'package:flutter/foundation.dart';
import 'package:flutter_douban2/util/client_api.dart';

class CelePhotosInfo extends ChangeNotifier {
  static const String _LOADING = '##loading##';
  String _celebrityId = '';

  int _selectedIndex = 0;
  int get selectedIndex {
    return _selectedIndex;
  }

  void setSelectedIndex(int index) {
    this._selectedIndex = index;
    notifyListeners();
  }

  bool _calling = false;
  bool _done = false;
  int _start = 0;
  int _count = 30;
  int _total = 0;
  int get total {
    return _total;
  }

  set total(int total) {
    this._total = total;
    notifyListeners();
  }

  List _photos = [
    {
      "title": _LOADING,
    }
  ];
  List get photos {
    return _photos;
  }

  bool isLoading(index) {
    return this._photos[index]['title'] == _LOADING;
  }

  void initPhotos(id) async {
    _celebrityId = id;
    _start = 0;
    _total = 0;
    _done = false;
    _photos.removeRange(0, _photos.length - 1);
  }

  void morePhotos() async {
    if (_done) {
      return;
    }
    if (_calling) {
      return;
    }
    _calling = true;
    var more = await ClientAPI.getInstance()
        .getCelebrityPhotos(id: this._celebrityId, start: _start);
    _photos.insertAll(_photos.length - 1, more['list']);
    _start = _start + more['list'].length;
    _total = more['total'];
    if (more['list'].length < _count) {
      _done = true;
    }
    _calling = false;
    notifyListeners();
  }
}
