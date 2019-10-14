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
  MovieChooseBox(this.title, this.label, {Key key}) : super(key: key);

  _MovieChooseBoxState createState() => _MovieChooseBoxState();
}

class _MovieChooseBoxState extends State<MovieChooseBox> {
  String photo;
  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh() async {
    var url;
    var subjects = [];
    if (widget.title == LabelConstant.MOVIE_CHOOSE_TOPIC) {
      if (widget.label == "豆瓣热门") {
        subjects = await ClientAPI.getInstance().searchSubjects(
          tag: "热门",
          count: 1,
        );
      } else if (widget.label == "最新电影") {
        subjects = await ClientAPI.getInstance().searchSubjects(
          tag: "最新",
          count: 1,
        );
      } else if (widget.label == "冷门佳片") {
        subjects = await ClientAPI.getInstance().searchSubjects(
          tag: "冷门佳片",
          count: 1,
        );
      } else if (widget.label == "豆瓣高分") {
        subjects = await ClientAPI.getInstance().searchSubjects(
          tag: "豆瓣高分",
          count: 1,
        );
      } else if (widget.label == "经典电影") {
        subjects = await ClientAPI.getInstance().searchSubjects(
          tag: "经典",
          count: 1,
        );
      }
    } else if (widget.title == LabelConstant.MOVIE_CHOOSE_TYPE) {
      url = 'start=0&sort=U&range=0,10&genres=${widget.label}&tags=电影';
      subjects = await ClientAPI.getInstance().newSearchSubjects(url);
    } else if (widget.title == LabelConstant.MOVIE_CHOOSE_PLACE) {
      url = 'start=0&sort=U&range=0,10&countries=${widget.label}&tags=电影';
      subjects = await ClientAPI.getInstance().newSearchSubjects(url);
    } else if (widget.title == LabelConstant.MOVIE_CHOOSE_SPEICAL) {
      url = "start=0&sort=U&range=0,10&tags=电影,${widget.label}";
      subjects = await ClientAPI.getInstance().newSearchSubjects(url);
    }
    if (subjects.length > 0) {
      if (mounted) {
        setState(() {
          this.photo = subjects[0]['cover'];
          print(photo);
        });
      }
    } else {
      print(widget.label);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.photo == null) {
      return _buildIndicator();
    } else {}
    return GestureDetector(
      onTap: () {
        onTapGo(context);
      },
      child: Stack(
        children: <Widget>[
          _buildBackgroud(),
          _buildOpacity(),
          _buildLabel(),
        ],
      ),
    );
  }

  void onTapGo(context) {
    if (widget.title == LabelConstant.MOVIE_CHOOSE_TOPIC) {
      if (widget.label == "豆瓣热门") {
        NavigatorHelper.pushToPage(context, LabelConstant.MOVIE_CHOOSE_TOPIC,
            content: "热门");
      } else if (widget.label == "最新电影") {
        NavigatorHelper.pushToPage(context, LabelConstant.MOVIE_CHOOSE_TOPIC,
            content: "最新");
      } else if (widget.label == "冷门佳片") {
        NavigatorHelper.pushToPage(context, LabelConstant.MOVIE_CHOOSE_TOPIC,
            content: "冷门佳片");
      } else if (widget.label == "豆瓣高分") {
        NavigatorHelper.pushToPage(context, LabelConstant.MOVIE_CHOOSE_TOPIC,
            content: "豆瓣高分");
      } else if (widget.label == "经典电影") {
        NavigatorHelper.pushToPage(context, LabelConstant.MOVIE_CHOOSE_TOPIC,
            content: "经典");
      }
    } else if (widget.title == LabelConstant.MOVIE_CHOOSE_TYPE) {
      NavigatorHelper.pushToPage(
        context,
        LabelConstant.MOVIE_CATEGORY_TITLE,
        content: MovieCategorySearchPage(
          style: widget.label,
        ),
      );
    } else if (widget.title == LabelConstant.MOVIE_CHOOSE_PLACE) {
      NavigatorHelper.pushToPage(
        context,
        LabelConstant.MOVIE_CATEGORY_TITLE,
        content: MovieCategorySearchPage(
          country: widget.label,
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
        ),
      );
    }
  }

  Widget _buildIndicator() {
    return Center(
      child: Container(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.choose_image_width),
        height:
            ScreenUtil.getInstance().setHeight(ScreenSize.choose_image_height),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildLabel() {
    return Center(
      child: Container(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.choose_image_width),
        height:
            ScreenUtil.getInstance().setHeight(ScreenSize.choose_image_height),
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroud() {
    return Center(
      child: Container(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.choose_image_width),
        height:
            ScreenUtil.getInstance().setHeight(ScreenSize.choose_image_height),
        // color: Colors.green,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(this.photo),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
      ),
    );
  }

  Widget _buildOpacity() {
    return Opacity(
      opacity: 0.5,
      child: Center(
        child: Container(
          width:
              ScreenUtil.getInstance().setWidth(ScreenSize.choose_image_width),
          height: ScreenUtil.getInstance()
              .setHeight(ScreenSize.choose_image_height),
          // color: Colors.green,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
        ),
      ),
    );
  }
}
