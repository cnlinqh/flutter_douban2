//https://pub.dev/packages/dio#-installing-tab-
import 'package:dio/dio.dart';
import 'package:flutter_douban2/util/repository.dart';

//https://pub.dev/packages/html#-installing-tab-
import 'package:html/dom.dart';
// import 'package:html/dom_parsing.dart';
import 'package:html/parser.dart';
import 'package:flutter_douban2/util/log_util.dart';

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
    LogUtil.log(">>ClientAPI: getMovieHotRecommendList()");
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
    LogUtil.log(
        "<<<<ClientAPI: getMovieHotRecommendList() ##########################  ${e.difference(s).inMilliseconds}");
    return hots;
  }

  Future<List> getMovieInTheaters({
    int start = 0,
    int count = 6,
  }) async {
    LogUtil.log(">>ClientAPI: getMovieInTheaters($start, $count)");
    var s = new DateTime.now();
    // var key = "getMovieComingSoon#$start#$count";
    // if (Repository.isCached(key)) {
    //   return new Future<List>(() {
    //     return Repository.getCachedList(key);
    //   });
    // }
    Response<Map> res = await apiDio.get('/v2/movie/in_theaters',
        queryParameters: {"start": start, 'count': count});
    // Repository.setCachedList(key, res.data['subjects']);
    var e = new DateTime.now();
    LogUtil.log(
        "<<<<ClientAPI: getMovieInTheaters() ##########################  ${e.difference(s).inMilliseconds}");
    return res.data['subjects'];
  }

  Future<List> getMovieComingSoon({
    int start = 0,
    int count = 6,
  }) async {
    LogUtil.log(">>ClientAPI: getMovieComingSoon($start, $count)");
    var s = new DateTime.now();
    // var key = "getMovieComingSoon#$start#$count";
    // if (Repository.isCached(key)) {
    //   return new Future<List>(() {
    //     return Repository.getCachedList(key);
    //   });
    // }

    Response<Map> res = await apiDio.get('/v2/movie/coming_soon',
        queryParameters: {"start": start, 'count': count});
    // Repository.setCachedList(key, res.data['subjects']);
    var e = new DateTime.now();
    LogUtil.log(
        "<<<<ClientAPI: getMovieComingSoon($start, $count) ##########################  ${e.difference(s).inMilliseconds}");
    return res.data['subjects'];
  }

  Future<List> getMovieWeekly() async {
    LogUtil.log(">>ClientAPI: getMovieWeekly()");
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
    LogUtil.log(
        "<<<<ClientAPI: getMovieWeekly() ##########################  ${e.difference(s).inMilliseconds}");
    return res.data['subjects'];
  }

  Future<List> getMovieNew() async {
    LogUtil.log(">>ClientAPI: getMovieNew()");
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
    LogUtil.log(
        "<<<<ClientAPI: getMovieNew() ##########################  ${e.difference(s).inMilliseconds}");
    return res.data['subjects'];
  }

  Future<List> getMovieUSBox() async {
    LogUtil.log(">>ClientAPI: getMovieUSBox()");
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
    LogUtil.log(
        "<<<<ClientAPI: getMovieUSBox() ##########################  ${e.difference(s).inMilliseconds}");
    return res.data['subjects'];
  }

  Future<List> getMovieTop250({
    int start = 0,
    int count = 6,
  }) async {
    LogUtil.log(">>ClientAPI: getMovieTop250($start, $count)");
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
    LogUtil.log(
        "<<<<ClientAPI: getMovieTop250($start, $count) ##########################  ${e.difference(s).inMilliseconds}");
    return res.data['subjects'];
  }

  Future getMovieSubject(id) async {
    LogUtil.log(">>ClientAPI: getMovieSubject($id)");
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
    LogUtil.log(
        "<<<<ClientAPI: getMovieSubject($id) ##########################  ${e.difference(s).inMilliseconds}");
    return res.data;
  }

  Future<List> getAllDirectorsCastsList(id) async {
    LogUtil.log(">>ClientAPI: getAllDirectorsCastsList($id)");
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
    LogUtil.log(
        "<<<<ClientAPI: getAllDirectorsCastsList($id) ##########################  ${e.difference(s).inMilliseconds}");
    return celebrities;
  }

  Future getSubjectPhotos(id) async {
    LogUtil.log(">>ClientAPI: getSubjectPhotos($id)");
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
    LogUtil.log(
        "<<<<ClientAPI: getSubjectPhotos($id) ##########################  ${e.difference(s).inMilliseconds}");
    return res.data['photos'];
  }

  Future newSearchSubjects(search) async {
    LogUtil.log(">>ClientAPI: newSearchSubjects($search)");
    var s = new DateTime.now();
    String url = '/j/new_search_subjects?$search';
    Response<Map> res = await webDio.get(url);
    var e = new DateTime.now();
    LogUtil.log(
        "<<<<ClientAPI: newSearchSubjects($search) ##########################  ${e.difference(s).inMilliseconds}");
    return res.data['data'];
  }

  Future yearRankList({year = '2018', type = '1'}) async {
    LogUtil.log(">>ClientAPI: yearRankList($year, $type)");
    var s = new DateTime.now();
    String url = '/ithil_j/activity/movie_annual$year/widget/$type';
    LogUtil.log(url);
    Response<Map> res = await webDio.get(url);
    var e = new DateTime.now();
    LogUtil.log(
        "<<<<ClientAPI: newSearchSubjects($year, $type) ##########################  ${e.difference(s).inMilliseconds}");
    return res.data['res'];
  }

  Future searchSubjects(
      {int start = 0, int count = 20, String tag = '热门'}) async {
    LogUtil.log(">>ClientAPI: searchSubjects($start, $count, $tag)");
    var s = new DateTime.now();
    String url =
        '/j/search_subjects?type=movie&tag=$tag&page_limit=$count&page_start=$start';
    LogUtil.log(url);
    Response<Map> res = await webDio.get(url);
    var e = new DateTime.now();
    LogUtil.log(
        "<<<<ClientAPI: searchSubjects($start, $count, $tag) ##########################  ${e.difference(s).inMilliseconds}");
    return res.data['subjects'];
  }

  Future getAllComments({
    String subjectId,
    int start = 0,
    int count = 0,
    String sort = 'new_score', //new_score 热门， time 最新
    String status = 'P', //P 看过， F 想看
  }) async {
    LogUtil.log(
        ">>ClientAPI: getAllComment($subjectId, $start, $count, $sort, $status)");
    var s = new DateTime.now();
    List comments = [];
    var url =
        "/subject/$subjectId/comments?start=$start&limit=$count&sort=$sort&status=$status";
    Response res = await webDio.get(url);
    var document = parse(res.toString());
    List<Element> items = document.body.getElementsByClassName('comment-item');
    items.forEach((item) {
      var comment = {
        'authorAvatar': item.getElementsByTagName('img')[0].attributes['src'],
        'authorName': item.getElementsByTagName('a')[0].attributes['title'],
        'ratingValue': convertToStar(
            item.getElementsByClassName('rating').length > 0
                ? item.getElementsByClassName('rating')[0].classes.toString()
                : ""),
        'createdAt':
            item.getElementsByClassName('comment-time ')[0].attributes['title'],
        'content': item.getElementsByClassName('short')[0].text,
        'usefufCount': item.getElementsByClassName('votes')[0].text,
      };
      comments.add(comment);
    });

    List<Element> isActives = document.body.getElementsByClassName('is-active');
    var total = isActives[0].getElementsByTagName('span')[0].text;
    LogUtil.log("total: " + total);
    var e = new DateTime.now();
    LogUtil.log(
        "<<<<ClientAPI: getAllComment($subjectId, $start, $count, $sort, $status) ##########################  ${e.difference(s).inMilliseconds}");
    return {
      "comments": comments,
      "total": total,
    };
  }

  static String convertToStar(star) {
    if (star == "allstar50 rating" || star == "allstar50 main-title-rating") {
      return "5";
    } else if (star == "allstar40 rating" ||
        star == "allstar40 main-title-rating") {
      return "4";
    } else if (star == "allstar30 rating" ||
        star == "allstar30 main-title-rating") {
      return "3";
    } else if (star == "allstar20 rating" ||
        star == "allstar20 main-title-rating") {
      return "2";
    } else if (star == "allstar10 rating" ||
        star == "allstar10 main-title-rating") {
      return "1";
    } else {
      return "0";
    }
  }

  Future getAllReviews({
    String subjectId,
    int start = 0,
    int count = 20,
    String sort = 'hotest', //hotest 最受欢迎， time 最新发布
    String rating = '', // 1,2,3,4,5, ,
  }) async {
    LogUtil.log(
        ">>ClientAPI: getAllReviews($subjectId, $start, $count, $sort, $rating)");
    var s = new DateTime.now();
    List reviews = [];
    var url =
        "/subject/$subjectId/reviews?start=$start&count=$count&sort=$sort&rating=$rating";
    LogUtil.log(url);
    Response res = await webDio.get(url);
    var document = parse(res.toString());
    List<Element> items =
        document.body.getElementsByClassName('main review-item');
    items.forEach((item) {
      var rid =
          item.getElementsByClassName('review-short')[0].attributes['data-rid'];
      var avator = item.getElementsByTagName('img')[0].attributes['src'];
      var name = item.getElementsByClassName('name')[0].text.trim();
      var ratingValue = convertToStar(
          item.getElementsByClassName('main-title-rating').length > 0
              ? item
                  .getElementsByClassName('main-title-rating')[0]
                  .classes
                  .toString()
              : "");
      var title = item.getElementsByTagName('h2')[0].firstChild.text.trim();
      var shortContent =
          item.getElementsByClassName('short-content')[0].text.trim();
      var up = item
          .getElementsByClassName('action-btn up')[0]
          .getElementsByTagName('span')[0]
          .text
          .trim();
      var down = item
          .getElementsByClassName('action-btn down')[0]
          .getElementsByTagName('span')[0]
          .text
          .trim();
      var createdAt = item.getElementsByClassName('main-meta')[0].text.trim();

      var review = {
        'rid': rid,
        'avator': avator,
        'name': name,
        'ratingValue': ratingValue,
        'title': title,
        'shortContent': shortContent,
        'up': up,
        'down': down,
        'createdAt': createdAt,
      };
      reviews.add(review);
    });

    List<Element> droplist = document.body.getElementsByClassName('droplist');
    var total = droplist[0].getElementsByTagName('a')[0].text.trim();
    LogUtil.log("total: " + total);
    var total5 = droplist[0].getElementsByTagName('a')[1].text.trim();
    LogUtil.log("total: " + total5);
    var total4 = droplist[0].getElementsByTagName('a')[2].text.trim();
    LogUtil.log("total: " + total4);
    var total3 = droplist[0].getElementsByTagName('a')[3].text.trim();
    LogUtil.log("total: " + total3);
    var total2 = droplist[0].getElementsByTagName('a')[4].text.trim();
    LogUtil.log("total: " + total2);
    var total1 = droplist[0].getElementsByTagName('a')[5].text.trim();
    LogUtil.log("total: " + total1);
    var e = new DateTime.now();
    LogUtil.log(
        "<<<<ClientAPI: getAllReviews($subjectId, $start, $count, $sort, $rating) ##########################  ${e.difference(s).inMilliseconds}");
    return {
      "reviews": reviews,
      "total": total,
      "total5": total5,
      "total4": total4,
      "total3": total3,
      "total2": total2,
      "total1": total1,
    };
  }

  Future fetchFullReview(rid) async {
    LogUtil.log(">>ClientAPI: fetchFullReview($rid)");
    var s = new DateTime.now();
    var key = "fetchFullReview($rid)";
    if (Repository.isCached(key)) {
      return new Future(() {
        return Repository.getCachedObject(key);
      });
    }
    Response<Map> res = await webDio.get('/j/review/$rid/full');
    Repository.setCachedObject(key, res.data);
    var e = new DateTime.now();
    LogUtil.log(
        "<<<<ClientAPI: fetchFullReview($rid) ##########################  ${e.difference(s).inMilliseconds}");
    return res.data;
  }

  Future<List> getAlsoLikeMovies(subjectId) async {
    LogUtil.log(">>ClientAPI: getAlsoLikeMovies($subjectId)");
    var s = new DateTime.now();
    var key = "getAlsoLikeMovies($subjectId)";
    if (Repository.isCached(key)) {
      return new Future(() {
        return Repository.getCachedObject(key);
      });
    }
    List movies = [];
    var url = '/subject/$subjectId/?from=showing';
    Response res = await webDio.get(url);
    var document = parse(res.toString());
    List<Element> items =
        document.body.getElementsByClassName('recommendations-bd');
    items = items[0].getElementsByTagName('dl');
    items.forEach((item) {
      var movie = {
        'cover': item.getElementsByTagName('img')[0].attributes['src'],
        'title': item.getElementsByTagName('img')[0].attributes['alt'],
        'href': item.getElementsByTagName('a')[0].attributes['href'],
      };
      RegExp id = new RegExp(r'\d+');
      RegExpMatch match = id.firstMatch(movie['href'].toString());
      movie['id'] = match.group(0);
      movies.add(movie);
    });

    Repository.setCachedObject(key, movies);
    var e = new DateTime.now();
    LogUtil.log(
        "<<<<ClientAPI: getAlsoLikeMovies($subjectId) ##########################  ${e.difference(s).inMilliseconds}");
    return movies;
  }

  Future getCelebrityDetails(id) async {
    LogUtil.log(">>ClientAPI: getCelebrityDetails($id)");
    var s = new DateTime.now();
    var key = "getCelebrityDetails($id)";
    if (Repository.isCached(key)) {
      return new Future(() {
        return Repository.getCachedObject(key);
      });
    }
    Response<Map> res = await apiDio.get('/v2/movie/celebrity/$id');
    Repository.setCachedObject(key, res.data);
    var e = new DateTime.now();
    LogUtil.log(
        "<<<<ClientAPI: getCelebrityDetails($id) ##########################  ${e.difference(s).inMilliseconds}");
    return res.data;
  }

  Future<List> getCelebrityPhotos({
    String id,
    String sortBy = 'like', //like, 按喜欢排序； size， 按尺寸排序；time，按时间排序
    int start = 0, //count cannot be set, always 30
  }) async {
    LogUtil.log(">>ClientAPI: getCelebrityPhotos($id , $sortBy, $start)");
    var s = new DateTime.now();
    var key = "getCelebrityPhotos($id , $sortBy, $start)";
    if (Repository.isCached(key)) {
      return new Future(() {
        return Repository.getCachedList(key);
      });
    }
    var url =
        '/celebrity/$id/photos/?type=C&start=$start&sortby=$sortBy&size=a&subtype=a';
    Response res = await webDio.get(url);
    var document = parse(res.toString());
    List<Element> items =
        document.body.getElementsByClassName('poster-col3 clearfix');
    items = items[0].getElementsByTagName('li');
    List photos = [];
    items.forEach((item) {
      photos.add({
        'img': item.getElementsByTagName('img')[0].attributes['src'],
        'prop': item.getElementsByClassName('prop')[0].text.trim(),
        'name': item.getElementsByClassName('name')[0].firstChild.text.trim(),
      });
    });

    Repository.setCachedList(key, photos);
    var e = new DateTime.now();
    LogUtil.log(
        "<<<<ClientAPI: getCelebrityPhotos($id , $sortBy, $start) ##########################  ${e.difference(s).inMilliseconds}");
    return photos;
  }
}
