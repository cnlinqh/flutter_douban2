import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban2/movie/movie_category_search_page.dart';

class TVChooseBox extends StatefulWidget {
  final String title;
  final String label;
  TVChooseBox(this.title, this.label);
  _TVChooseBoxState createState() => _TVChooseBoxState();
}

class _TVChooseBoxState extends State<TVChooseBox> {
  String _photoUrl;
  @override
  void initState() {
    super.initState();
    _getPhotoUrl();
  }

  @override
  Widget build(BuildContext context) {
    if (this._photoUrl == null) {
      return _buildIndicator();
    } else {
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
  }

  void onTapGo(context) {
    if (widget.title == LabelConstant.TV_CHOOSE_PLACE) {
      NavigatorHelper.pushToPage(
        context,
        LabelConstant.MOVIE_CATEGORY_TITLE,
        content: MovieCategorySearchPage(
          country: widget.label,
          tag: '电视剧',
        ),
      );
    } else if (widget.title == LabelConstant.TV_CHOOSE_TYPE) {
      if (widget.label == '动漫' || widget.label == '纪录片') {
        NavigatorHelper.pushToPage(
          context,
          LabelConstant.MOVIE_CATEGORY_TITLE,
          content: MovieCategorySearchPage(
            tag: widget.label,
          ),
        );
      }
      if (widget.label == '喜剧' || widget.label == '科幻' || widget.label == '武侠' || widget.label == '历史') {
        NavigatorHelper.pushToPage(
          context,
          LabelConstant.MOVIE_CATEGORY_TITLE,
          content: MovieCategorySearchPage(
            style: widget.label,
            tag: '电视剧',
          ),
        );
      }
      if (widget.label == '青春' ||
          widget.label == '古装' ||
          widget.label == '探案' ||
          widget.label == '律政' ||
          widget.label == '医疗' ||
          widget.label == '政治') {
        LabelConstant.resetSpecialList();
        NavigatorHelper.pushToPage(
          context,
          LabelConstant.MOVIE_CATEGORY_TITLE,
          content: MovieCategorySearchPage(
            special: widget.label,
            tag: '电视剧',
          ),
        );
      }
    } else if (widget.title == LabelConstant.TV_CHOOSE_TOPIC_CHANNEL) {
      LabelConstant.resetSpecialList();
      LabelConstant.addOneSpecial(widget.label);
      NavigatorHelper.pushToPage(
        context,
        LabelConstant.MOVIE_CATEGORY_TITLE,
        content: MovieCategorySearchPage(
          special: widget.label,
          tag: '电视剧',
        ),
      );
    }
  }

  Widget _buildIndicator() {
    return Center(
      child: Container(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.choose_image_width),
        height: ScreenUtil.getInstance().setHeight(ScreenSize.choose_image_height),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildBackgroud() {
    return Center(
      child: Container(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.choose_image_width),
        height: ScreenUtil.getInstance().setHeight(ScreenSize.choose_image_height),
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

  Widget _buildOpacity() {
    return Opacity(
      opacity: 0.4,
      child: Center(
        child: Container(
          width: ScreenUtil.getInstance().setWidth(ScreenSize.choose_image_width),
          height: ScreenUtil.getInstance().setHeight(ScreenSize.choose_image_height),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel() {
    return Center(
      child: Container(
        width: ScreenUtil.getInstance().setWidth(ScreenSize.choose_image_width),
        height: ScreenUtil.getInstance().setHeight(ScreenSize.choose_image_height),
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  void _getPhotoUrl() async {
    var url;
    var subjects = [];
    if (widget.title == LabelConstant.TV_CHOOSE_PLACE) {
      url = '?start=0&sort=U&range=0,10&countries=${widget.label}&tags=电视剧';
      subjects = await ClientAPI.getInstance().newSearchSubjects(url);
    } else if (widget.title == LabelConstant.TV_CHOOSE_TYPE) {
      if (widget.label == '动漫' || widget.label == '纪录片') {
        url = '?start=0&sort=U&range=0,10&tags=${widget.label}';
      }
      if (widget.label == '喜剧' || widget.label == '科幻' || widget.label == '武侠' || widget.label == '历史') {
        url = '?start=0&sort=U&range=0,10&genres=${widget.label}&tags=电视剧';
      }
      if (widget.label == '青春' ||
          widget.label == '古装' ||
          widget.label == '探案' ||
          widget.label == '律政' ||
          widget.label == '医疗' ||
          widget.label == '政治') {
        url = '?start=0&sort=U&range=0,10&tags=电视剧,${widget.label}';
      }
      subjects = await ClientAPI.getInstance().newSearchSubjects(url);
    } else if (widget.title == LabelConstant.TV_CHOOSE_TOPIC_CHANNEL) {
      url = "?start=0&sort=U&range=0,10&tags=电视剧,${widget.label}";
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
