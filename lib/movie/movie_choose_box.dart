import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban2/movie/movie_category_search_page.dart';

class MovieChooseBox extends StatefulWidget {
  final String title;
  final String label;
  MovieChooseBox(this.title, this.label);
  _MovieChooseBoxState createState() => _MovieChooseBoxState();
}

class _MovieChooseBoxState extends State<MovieChooseBox> {
  String _photoUrl;
  @override
  void initState() {
    super.initState();
    _getPhotoUrl();
  }

  @override
  Widget build(BuildContext context) {
    var size = ScreenSize.calculateSize(
      context: context,
      width1: ScreenSize.choose_image_width,
      height1: ScreenSize.choose_image_height,
      width2: ScreenSize.choose_image_width2,
      height2: ScreenSize.choose_image_height2,
    );
    if (this._photoUrl == null) {
      return _buildIndicator(size);
    } else {
      return GestureDetector(
        onTap: () {
          onTapGo(context);
        },
        child: Stack(
          children: <Widget>[
            _buildBackgroud(size),
            _buildOpacity(size),
            _buildLabel(size),
          ],
        ),
      );
    }
  }

  void onTapGo(context) {
    if (widget.title == LabelConstant.MOVIE_CHOOSE_TOPIC) {
      NavigatorHelper.pushToPage(context, widget.label, content: this._mapToTag(widget.label));
    } else if (widget.title == LabelConstant.MOVIE_CHOOSE_TYPE) {
      NavigatorHelper.pushToPage(
        context,
        LabelConstant.MOVIE_CATEGORY_TITLE,
        content: MovieCategorySearchPage(
          style: widget.label,
          tag: '电影',
        ),
      );
    } else if (widget.title == LabelConstant.MOVIE_CHOOSE_PLACE) {
      NavigatorHelper.pushToPage(
        context,
        LabelConstant.MOVIE_CATEGORY_TITLE,
        content: MovieCategorySearchPage(
          country: widget.label,
          tag: '电影',
        ),
      );
    } else if (widget.title == LabelConstant.MOVIE_CHOOSE_SPEICAL) {
      LabelConstant.resetSpecialList();
      LabelConstant.addOneSpecial(widget.label);
      NavigatorHelper.pushToPage(
        context,
        LabelConstant.MOVIE_CATEGORY_TITLE,
        content: MovieCategorySearchPage(
          special: widget.label,
          tag: '电影',
        ),
      );
    }
  }

  Widget _buildIndicator(size) {
    return Center(
      child: Container(
        width: ScreenUtil.getInstance().setWidth(size['width']),
        height: ScreenUtil.getInstance().setHeight(size['height']),
        child: Center(
            // child: CircularProgressIndicator(),
            ),
      ),
    );
  }

  Widget _buildBackgroud(size) {
    return Center(
      child: Container(
        width: ScreenUtil.getInstance().setWidth(size['width']),
        height: ScreenUtil.getInstance().setHeight(size['height']),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(this._photoUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
      ),
    );
  }

  Widget _buildOpacity(size) {
    return Opacity(
      opacity: 0.4,
      child: Center(
        child: Container(
          width: ScreenUtil.getInstance().setWidth(size['width']),
          height: ScreenUtil.getInstance().setHeight(size['height']),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(size) {
    return Center(
      child: Container(
        width: ScreenUtil.getInstance().setWidth(size['width']),
        height: ScreenUtil.getInstance().setHeight(size['height']),
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  String _mapToTag(label) {
    if (label == LabelConstant.MOVIE_CHOOSE_TOPIC_HOT) {
      return "热门";
    } else if (label == LabelConstant.MOVIE_CHOOSE_TOPIC_NEW) {
      return "最新";
    } else if (label == LabelConstant.MOVIE_CHOOSE_TOPIC_COOL) {
      return "冷门佳片";
    } else if (label == LabelConstant.MOVIE_CHOOSE_TOPIC_HIGH) {
      return "豆瓣高分";
    } else if (label == LabelConstant.MOVIE_CHOOSE_TOPIC_CLASSIC) {
      return "经典";
    } else {
      return label;
    }
  }

  void _getPhotoUrl() async {
    var url;
    var subjects = [];
    if (widget.title == LabelConstant.MOVIE_CHOOSE_TOPIC) {
      var tag = this._mapToTag(widget.label);
      subjects = await ClientAPI.getInstance().searchSubjects(
        tag: tag,
        count: 1,
      );
    } else if (widget.title == LabelConstant.MOVIE_CHOOSE_TYPE) {
      url = '?start=0&sort=U&range=0,10&genres=${widget.label}&tags=电影';
      subjects = await ClientAPI.getInstance().newSearchSubjects(url);
    } else if (widget.title == LabelConstant.MOVIE_CHOOSE_PLACE) {
      url = '?start=0&sort=U&range=0,10&countries=${widget.label}&tags=电影';
      subjects = await ClientAPI.getInstance().newSearchSubjects(url);
    } else if (widget.title == LabelConstant.MOVIE_CHOOSE_SPEICAL) {
      url = "?start=0&sort=U&range=0,10&tags=电影,${widget.label}";
      subjects = await ClientAPI.getInstance().newSearchSubjects(url);
    }
    if (subjects.length > 0) {
      if (mounted) {
        setState(() {
          this._photoUrl = subjects[0]['cover'];
        });
      }
    }
  }
}
