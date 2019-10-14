import 'package:flutter_douban2/util/client_api.dart';

void main() {
  ClientAPI api = new ClientAPI();
  api.getMovieHotRecommendList().then((hots) {
    hots.forEach((hot) {
      print(hot);
    });
  });
}
