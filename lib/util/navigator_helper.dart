import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_list_paged.dart';
import 'package:flutter_douban2/util/client_api.dart';

class NavigatorHelper {
  static push(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => page,
      ),
    );
  }

  static pushMoviePaged(BuildContext context, String title, Function getData) {
    NavigatorHelper.push(context, MovieListPaged(title, getData));
  }

  static pushMovieListPage(BuildContext context, String title) {
    if (title == "影院热映") {
      pushMoviePaged(
          context, title, ClientAPI.getInstance().getMovieInTheaters);
    }else if (title == "即将上映") {
      pushMoviePaged(
          context, title, ClientAPI.getInstance().getMovieComingSoon);
    }
  }
}
