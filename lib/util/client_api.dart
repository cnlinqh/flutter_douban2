//https://pub.dev/packages/dio#-installing-tab-
import 'package:dio/dio.dart';

//https://pub.dev/packages/html#-installing-tab-
import 'package:html/dom.dart';
import 'package:html/dom_parsing.dart';
import 'package:html/parser.dart';


import 'package:flutter_douban2/model/movie_hot_recommend.dart';

class ClientAPI {

  Dio webDio = initDio(
    baseUrl: "https://movie.douban.com",
  );
  Dio apiDio = initDio(
    baseUrl: "http://api.douban.com",
    apiKey: "0df993c66c0c636e29ecbb5344252a4a",
  );

  static Dio initDio({baseUrl, apiKey = "apiKey"}) {
    var options = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 10000,
        receiveTimeout: 100000,
        contentType: "application/json",
        queryParameters: {
          "apikey": apiKey,
        });
    return Dio(options);
  }

  Future<List<MovieHotRecommend>> getMovieHotRecommendList() async {
    List<MovieHotRecommend> hots = [];
    Response res = await webDio.get("/");
    var document = parse(res.toString());
    List<Element> items = document.body.getElementsByClassName('gallery-frame');
    items.forEach((item) {
      String cover =
          item.getElementsByTagName('img')[0].attributes['src'].toString();
      String link =
          item.getElementsByTagName('a')[0].attributes['href'].toString();
      String title = item.getElementsByTagName('h3')[0].text.toString().trim();
      String summary = item.getElementsByTagName('p')[0].text.toString().trim();
      MovieHotRecommend hot = new MovieHotRecommend(
        cover: cover,
        link: link,
        title: title,
        summary: summary,
      );
      hots.add(hot);
    });
    return hots;
  }
}
