//https://pub.dev/packages/dio#-installing-tab-
import 'package:dio/dio.dart';
import 'package:flutter_douban2/util/repository.dart';

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
    print(">>ClientAPI: getMovieHotRecommendList()");
    var s = new DateTime.now();
    var key = "getMovieHotRecommendList";
    if (Repository.isCached(key)) {
      return new Future<List>(() {
        return Repository.getCachedList(key);
      });
    }
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
    Repository.setCachedList(key, hots);
    var e = new DateTime.now();
    print(
        "<<<<ClientAPI: getMovieHotRecommendList() ##########################  ${e.difference(s).inMilliseconds}");
    return hots;
  }

  Future<List> getMovieInTheaters({
    int start = 0,
    int count = 6,
  }) async {
    print(">>ClientAPI: getMovieInTheaters($start, $count)");
    var s = new DateTime.now();
    var key = "getMovieComingSoon#$start#$count";
    if (Repository.isCached(key)) {
      return new Future<List>(() {
        return Repository.getCachedList(key);
      });
    }
    Response<Map> res = await apiDio.get('/v2/movie/in_theaters',
        queryParameters: {"start": start, 'count': count});
    Repository.setCachedList(key, res.data['subjects']);
    var e = new DateTime.now();
    print(
        "<<<<ClientAPI: getMovieInTheaters() ##########################  ${e.difference(s).inMilliseconds}");
    return res.data['subjects'];
  }

  Future<List> getMovieComingSoon({
    int start = 0,
    int count = 6,
  }) async {
    print(">>ClientAPI: getMovieComingSoon($start, $count)");
    var s = new DateTime.now();
    var key = "getMovieComingSoon#$start#$count";
    if (Repository.isCached(key)) {
      return new Future<List>(() {
        return Repository.getCachedList(key);
      });
    }

    Response<Map> res = await apiDio.get('/v2/movie/coming_soon',
        queryParameters: {"start": start, 'count': count});
    Repository.setCachedList(key, res.data['subjects']);
    var e = new DateTime.now();
    print(
        "<<<<ClientAPI: getMovieComingSoon() ##########################  ${e.difference(s).inMilliseconds}");
    return res.data['subjects'];
  }

  Future<List> getMovieWeekly() async {
    print(">>ClientAPI: getMovieWeekly()");
    var s = new DateTime.now();
    var key = "getMovieWeekly";
    if (Repository.isCached(key)) {
      return new Future<List>(() {
        return Repository.getCachedList(key);
      });
    }
    Response<Map> res = await apiDio.get('/v2/movie/weekly');
    Repository.setCachedList(key, res.data['subjects']);
    var e = new DateTime.now();
    print(
        "<<<<ClientAPI: getMovieWeekly() ##########################  ${e.difference(s).inMilliseconds}");
    return res.data['subjects'];
  }

  Future<List> getMovieNew() async {
    print(">>ClientAPI: getMovieNew()");
    var s = new DateTime.now();
    var key = "getMovieNew";
    if (Repository.isCached(key)) {
      return new Future<List>(() {
        return Repository.getCachedList(key);
      });
    }
    Response<Map> res = await apiDio.get('/v2/movie/new_movies');
    Repository.setCachedList(key, res.data['subjects']);
    var e = new DateTime.now();
    print(
        "<<<<ClientAPI: getMovieNew() ##########################  ${e.difference(s).inMilliseconds}");
    return res.data['subjects'];
  }

  Future<List> getMovieUSBox() async {
    print(">>ClientAPI: getMovieUSBox()");
    var s = new DateTime.now();
    var key = "getMovieUSBox";
    if (Repository.isCached(key)) {
      return new Future<List>(() {
        return Repository.getCachedList(key);
      });
    }
    Response<Map> res = await apiDio.get('/v2/movie/us_box');
    Repository.setCachedList(key, res.data['subjects']);
    var e = new DateTime.now();
    print(
        "<<<<ClientAPI: getMovieUSBox() ##########################  ${e.difference(s).inMilliseconds}");
    return res.data['subjects'];
  }

  Future<List> getMovieTop250({
    int start = 0,
    int count = 6,
  }) async {
    print(">>ClientAPI: getMovieTop250($start, $count)");
    var s = new DateTime.now();
    var key = "getMovieTop250#$start#$count";
    if (Repository.isCached(key)) {
      return new Future<List>(() {
        return Repository.getCachedList(key);
      });
    }
    Response<Map> res = await apiDio.get('/v2/movie/top250',
        queryParameters: {"start": start, 'count': count});
    Repository.setCachedList(key, res.data['subjects']);
    var e = new DateTime.now();
    print(
        "<<<<ClientAPI: getMovieTop250($start, $count) ##########################  ${e.difference(s).inMilliseconds}");
    return res.data['subjects'];
  }

  Future getMovieSubject(id) async {
    print(">>ClientAPI: getMovieSubject($id)");
    var s = new DateTime.now();
    var key = "getMovieSubject($id)";
    if (Repository.isCached(key)) {
      return new Future(() {
        return Repository.getCachedObject(key);
      });
    }
    Response<Map> res = await apiDio.get('/v2/movie/subject/' + id);
    Repository.setCachedObject(key, res.data);
    var e = new DateTime.now();
    print(
        "<<<<ClientAPI: getMovieSubject($id) ##########################  ${e.difference(s).inMilliseconds}");
    return res.data;
  }

  Future<List> getAllDirectorsCastsList(id) async {
    print(">>ClientAPI: getAllDirectorsCastsList($id)");
    var s = new DateTime.now();
    var key = "getAllDirectorsCastsList($id)";
    if (Repository.isCached(key)) {
      return new Future<List>(() {
        return Repository.getCachedList(key);
      });
    }
    List celebrities = [];
    Response res = await webDio.get("/subject/" + id + "/celebrities");
    var document = parse(res.toString());
    List<Element> items = document.body.getElementsByClassName('celebrity');
    items.forEach((item) {
      String title = item.getElementsByClassName('role').length > 0
          ? item
              .getElementsByClassName('role')[0]
              .attributes['title']
              .toString()
          : '';
      String name = item.getElementsByTagName('a').length > 0
          ? item.getElementsByTagName('a')[0].attributes['title'].toString()
          : '';
      String avatar = item.getElementsByClassName('avatar').length > 0
          ? item
              .getElementsByClassName('avatar')[0]
              .attributes['style']
              .toString()
          : '';
      var celebrity = {
        'title': title,
        'name': name.split(" ")[0],
        "name_en": name.substring(name.split(" ")[0].length + 1),
        'avatar': avatar.substring(22, avatar.length - 1),
      };
      celebrities.add(celebrity);
    });
    Repository.setCachedList(key, celebrities);
    var e = new DateTime.now();
    print(
        "<<<<ClientAPI: getAllDirectorsCastsList($id) ##########################  ${e.difference(s).inMilliseconds}");
    return celebrities;
  }

  Future getSubjectPhotos(id) async {
    print(">>ClientAPI: getSubjectPhotos($id)");
    var s = new DateTime.now();
    var key = "getSubjectPhotos($id)";
    if (Repository.isCached(key)) {
      return new Future(() {
        return Repository.getCachedList(key);
      });
    }
    Response<Map> res = await apiDio.get('/v2/movie/subject/$id/photos');
    Repository.setCachedList(key, res.data['photos']);
    var e = new DateTime.now();
    print(
        "<<<<ClientAPI: getSubjectPhotos($id) ##########################  ${e.difference(s).inMilliseconds}");
    return res.data['photos'];
  }

  Future newSearchSubjects(search) async {
    print(">>ClientAPI: newSearchSubjects($search)");
    var s = new DateTime.now();
    String url = '/j/new_search_subjects?$search';
    Response<Map> res = await webDio.get(url);
    var e = new DateTime.now();
    print(
        "<<<<ClientAPI: newSearchSubjects($search) ##########################  ${e.difference(s).inMilliseconds}");
    return res.data['data'];
  }

  Future yearRankList({year = '2018', type = '1'}) async {
    print(">>ClientAPI: yearRankList($year, $type)");
    var s = new DateTime.now();
    String url = '/ithil_j/activity/movie_annual$year/widget/$type';
    print(url);
    Response<Map> res = await webDio.get(url);
    var e = new DateTime.now();
    print(
        "<<<<ClientAPI: newSearchSubjects($year, $type) ##########################  ${e.difference(s).inMilliseconds}");
    return res.data['res'];
  }

  Future searchSubjects(
      {int start = 0, int count = 20, String tag = '热门'}) async {
    print(">>ClientAPI: searchSubjects($start, $count, $tag)");
    var s = new DateTime.now();
    String url =
        '/j/search_subjects?type=movie&tag=$tag&page_limit=$count&page_start=$start';
    print(url);
    Response<Map> res = await webDio.get(url);
    var e = new DateTime.now();
    print(
        "<<<<ClientAPI: searchSubjects($start, $count, $tag) ##########################  ${e.difference(s).inMilliseconds}");
    return res.data['subjects'];
  }

  Future<List> getAllComments({
    String subjectId,
    int start = 0,
    int count = 0,
    String sort = 'new_score', //new_score 热门， time 最新
    String status = 'P', //P 看过， F 想看
  }) async {
    print(
        ">>ClientAPI: getAllComment($subjectId, $start, $count, $sort, $status)");
    var s = new DateTime.now();
    List comments = [];
    var url =
        "/subject/$subjectId/comments?start=$start&limit=$count&sort=$sort&status=$status&comments_only=1";
    Response res = await webDio.get(url);
    String html = "<!DOCTYPE html><html><body>" +
        res.data['html'].toString() +
        "</body></html>";
    var document = parse(html);
    List<Element> items = document.body.getElementsByClassName('comment-item');
    print(items.length);
    items.forEach((item) {
      var comment = {
        'authorAvatar': item.getElementsByTagName('img')[0].attributes['src'],
        'authorName': item.getElementsByTagName('a')[0].attributes['title'],
        'ratingValue': convertToStar(
            item.getElementsByClassName('rating').length > 0
                ? item.getElementsByClassName('rating')[0].classes
                : ""),
        'createdAt':
            item.getElementsByClassName('comment-time ')[0].attributes['title'],
        'content': item.getElementsByClassName('short')[0].text,
        'usefufCount': item.getElementsByClassName('votes')[0].text,
      };
      comments.add(comment);
    });
    var e = new DateTime.now();
    print(
        "<<<<ClientAPI: getAllComment($subjectId, $start, $count, $sort, $status) ##########################  ${e.difference(s).inMilliseconds}");
    return comments;
  }

  static String convertToStar(star) {
    if (star == "allstar50 rating") {
      return "5";
    } else if (star == "allstar40 rating") {
      return "4";
    } else if (star == "allstar30 rating") {
      return "3";
    } else if (star == "allstar20 rating") {
      return "2";
    } else if (star == "allstar10 rating") {
      return "1";
    } else {
      return "0";
    }
  }
}
