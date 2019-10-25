import 'package:flutter_douban2/util/client_api.dart';

void main() {
  ClientAPI api = new ClientAPI();
  api.getCelebrityPhotos(id: '1274242');
}
