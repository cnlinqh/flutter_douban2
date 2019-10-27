import 'package:flutter/material.dart';
import 'package:flutter_douban2/celebrity/cele_details_page.dart';
import 'package:flutter_douban2/celebrity/cele_section_photos_gallery.dart';
import 'package:flutter_douban2/celebrity/cele_section_photos_gridview.dart';
import 'package:flutter_douban2/movie/movie_choose_page.dart';
import 'package:flutter_douban2/movie/movie_list_group_page.dart';
import 'package:flutter_douban2/movie/movie_list_paged_page.dart';
import 'package:flutter_douban2/movie/movie_list_static_page.dart';
import 'package:flutter_douban2/movie/movie_rank_page_list_static.dart';
import 'package:flutter_douban2/movie/movie_rank_page_top20_static.dart';
import 'package:flutter_douban2/movie/subject_details_page.dart';
import 'package:flutter_douban2/movie/movie_rank_page.dart';
import 'package:flutter_douban2/movie/movie_rank_years_page.dart';
import 'package:flutter_douban2/movie/movie_category_search_page.dart';
import 'package:flutter_douban2/movie/subject_section_media_photos_gallery.dart';
import 'package:flutter_douban2/movie/subject_section_media_video_set.dart';
import 'package:flutter_douban2/movie/subject_section_review_full.dart';
import 'package:flutter_douban2/tv/tv_choose_page.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/log_util.dart';

class NavigatorHelper {
  static _push(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => page,
      ),
    );
  }

  static pushToPage(BuildContext context, String title, {dynamic content}) {
    LogUtil.log("pushToPage $title");
    LogUtil.log("content $content");
    switch (title) {
      case LabelConstant.MOVIE_IN_THEATERS_TITLE: //影院热映
        _push(
          context,
          MovieListPagedPage(title: title, api: ClientAPI.getInstance().getMovieInTheaters),
        );
        break;
      case LabelConstant.MOVIE_COMING_SOON_TITLE: //即将上映
        _push(
          context,
          MovieListGroupPage(title: title, api: ClientAPI.getInstance().getMovieComingSoon),
        );
        break;
      case LabelConstant.MOVIE_TOP_TOP250: //豆瓣电影Top250
        _push(
          context,
          MovieListPagedPage(title: title, api: ClientAPI.getInstance().getMovieTop250, rank: true),
        );
        break;
      case LabelConstant.MOVIE_TOP_WEEKLY: //一周口碑电影榜
      case LabelConstant.MOVIE_TOP_NEW: //豆瓣电影新片榜
      case LabelConstant.MOVIE_TOP_US: //豆瓣电影北美票房榜
        _push(context, MovieListStaticPage(title, content, rank: true));
        break;
      case LabelConstant.MOVIE_DETAILS_TITLE: //电影/电视详情
        _push(context, SubjectDetailsPage(content));
        break;
      case LabelConstant.MOVIE_PHOTO_TITLE: // 剧照
        _push(context, SubjectSectionMediaPhotosGallery(content['photos'], content['index']));
        break;
      case LabelConstant.MOVIE_VIDEO_TITLE: //预告片/花絮
        _push(context, SubjectVideoSet(content));
        break;
      case LabelConstant.MOVIE_RANK_LIST_TITLE: //豆瓣榜单
        _push(context, MovieRankPage());
        break;
      case LabelConstant.MOVIE_TOP_LIST_YEAR_TITLE: //豆瓣榜单
        _push(context, MovieRankYearsPage());
        break;
      case LabelConstant.MOVIE_ENTRANCE_SELECT_ICON:
        _push(context, MovieChoosePage());
        break;
      case LabelConstant.MOVIE_CATEGORY_TITLE: //分类找电影
        if (content != null) {
          _push(context, content);
        } else {
          _push(context, MovieCategorySearchPage());
        }
        break;
      case LabelConstant.MOVIE_YEAR_TOP_DETAILS_TITLE:
        _push(context, MovieRankListStaticPage(content));
        break;
      case LabelConstant.MOVIE_RANK_TOP20_LOVE:
      case LabelConstant.MOVIE_RANK_TOP20_COMEDY:
      case LabelConstant.MOVIE_RANK_TOP20_STORY:
      case LabelConstant.MOVIE_RANK_TOP20_CARTOON:
      case LabelConstant.MOVIE_RANK_TOP20_FICTION:
      case LabelConstant.MOVIE_RANK_TOP20_DOCUMENTARY:
      case LabelConstant.MOVIE_RANK_TOP20_LGBT:
      case LabelConstant.MOVIE_RANK_TOP20_MUSICAL:
      case LabelConstant.MOVIE_RANK_TOP20_DANCE:
        _push(context, MovieRankTop20StaticPage({'title': title, 'subjects': content}));
        break;
      case LabelConstant.MOVIE_CHOOSE_TOPIC_HOT:
      case LabelConstant.MOVIE_CHOOSE_TOPIC_NEW:
      case LabelConstant.MOVIE_CHOOSE_TOPIC_COOL:
      case LabelConstant.MOVIE_CHOOSE_TOPIC_HIGH:
      case LabelConstant.MOVIE_CHOOSE_TOPIC_CLASSIC:
        _push(
          context,
          MovieListPagedPage(title: title, api: ClientAPI.getInstance().searchSubjects, tag: content),
        );
        break;
      case LabelConstant.MOVIE_FULL_REVIEW:
        _push(context, SubjectSectionReviewFull(content));
        break;
      case LabelConstant.CELE_DETAILS_TITLE:
        _push(context, CeleDetailsPage(content));
        break;
      case LabelConstant.CELE_GALLERY_GRID_TITLE:
        _push(context, CeleSectionPhotosGridView(content));
        break;
      case LabelConstant.CELE_GALLERY_VIEW_TITLE:
        _push(context, CeleSectionPhotosGallery(content));
        break;
      case LabelConstant.TV_ENTRANCE_SELECT_ICON:
        _push(context, TVChoosePage());
        break;
      default:
    }
  }
}
