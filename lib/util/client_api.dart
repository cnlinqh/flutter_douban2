//https://pub.dev/packages/dio#-installing-tab-
import 'package:dio/dio.dart';

//https://pub.dev/packages/html#-installing-tab-
import 'package:html/dom.dart';
// import 'package:html/dom_parsing.dart';
import 'package:html/parser.dart';

class ClientAPI {
  static ClientAPI api = new ClientAPI();
  static getInstance() {
    return api;
  }

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

  Future<List> getMovieHotRecommendList() async {
    List hots = [];
    Response res = await webDio.get("/");
    var document = parse(res.toString());
    List<Element> items = document.body.getElementsByClassName('gallery-frame');
    items.forEach((item) {
      var hot = {
        'cover':
            item.getElementsByTagName('img')[0].attributes['src'].toString(),
        'link': item.getElementsByTagName('a')[0].attributes['href'].toString(),
        'title': item.getElementsByTagName('h3')[0].text.toString().trim(),
        'summary': item.getElementsByTagName('p')[0].text.toString().trim(),
      };
      hots.add(hot);
    });
    return hots;
  }

  Future<List> getMovieInTheaters({
    int start = 0,
    int count = 6,
  }) async {
    Response<Map> res = await apiDio.get('/v2/movie/in_theaters',
        queryParameters: {"start": start, 'count': count});
    return res.data['subjects'];
  }

  Future<List> getMovieComingSoon({
    int start = 0,
    int count = 6,
  }) async {
    Response<Map> res = await apiDio.get('/v2/movie/coming_soon',
        queryParameters: {"start": start, 'count': count});
    return res.data['subjects'];
  }

  Future<List> getMovieWeekly() async {
    Response<Map> res = await apiDio.get('/v2/movie/weekly');
    return res.data['subjects'];
  }

  Future<List> getMovieNew() async {
    Response<Map> res = await apiDio.get('/v2/movie/new_movies');
    return res.data['subjects'];
  }

  Future<List> getMovieUSBox() async {
    Response<Map> res = await apiDio.get('/v2/movie/us_box');
    return res.data['subjects'];
  }

  Future<List> getMovieTop250({
    int start = 0,
    int count = 250,
  }) async {
    Response<Map> res = await apiDio.get('/v2/movie/top250',
        queryParameters: {"start": start, 'count': count});
    return res.data['subjects'];
  }

  Future getMovieSubject(id) async {
    Response<Map> res = await apiDio.get('/v2/movie/subject/' + id);
    return res.data;
  }

  Future<List> getAllDirectorsCastsList(id) async {
    List celebrities = [];
    Response res = await webDio.get("/subject/" + id + "/celebrities");
    var document = parse(res.toString());
    List<Element> items = document.body.getElementsByClassName('celebrity');
    items.forEach((item) {
      String title =
          item.getElementsByClassName('role')[0].attributes['title'].toString();
      String name =
          item.getElementsByTagName('a')[0].attributes['title'].toString();
      String avatar = item
          .getElementsByClassName('avatar')[0]
          .attributes['style']
          .toString();

      var celebrity = {
        'title': title,
        'name': name.split(" ")[0],
        "name_en": name.substring(name.split(" ")[0].length + 1),
        'avatar': avatar.substring(22, avatar.length - 1),
      };
      print(celebrity);
      celebrities.add(celebrity);
    });
    return celebrities;
  }
}
