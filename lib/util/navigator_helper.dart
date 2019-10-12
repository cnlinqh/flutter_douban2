import 'package:flutter/material.dart';
import 'package:flutter_douban2/movie/movie_list_paged_page.dart';
import 'package:flutter_douban2/movie/movie_list_static_page.dart';
import 'package:flutter_douban2/movie/subject_details_page.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';

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
    NavigatorHelper.push(context, MovieListPagedPage(title, getData));
  }

  static pushMoviedStatic(BuildContext context, String title, List subjects) {
    NavigatorHelper.push(context, MovieListStaticPage(title, subjects));
  }

  static pushMovieListPage(BuildContext context, String title) {
    if (title == LabelConstant.MOVIE_IN_THEATERS_TITLE) {
      pushMoviePaged(
          context, title, ClientAPI.getInstance().getMovieInTheaters);
    } else if (title == LabelConstant.MOVIE_COMING_SOON_TITLE) {
      pushMoviePaged(
          context, title, ClientAPI.getInstance().getMovieComingSoon);
    } else if (title == LabelConstant.MOVIE_TOP_TOP250) {
      pushMoviePaged(context, title, ClientAPI.getInstance().getMovieTop250);
    }
  }

  static pushMovieSubjectDetailPage(BuildContext context, String id) {
    NavigatorHelper.push(context, SubjectDetailsPage(id));
  }
}
