import 'package:flutter/material.dart';
import 'package:flutter_douban2/blocs/blocs.dart';
// import 'package:flutter_douban2/util/client_api.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/navigator_helper.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban2/movie/movie_category_search_page.dart';

class TVChooseBox extends StatefulWidget {
  final String title;
  final String label;
  final String img;
  TVChooseBox(this.title, this.label, this.img);
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
      opacity: 0.1,
      child: Center(
        child: Container(
          width: ScreenUtil.getInstance().setWidth(size['width']),
          height: ScreenUtil.getInstance().setHeight(size['height']),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
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
            style: TextStyle(
              color: ThemeBloc.colors['white'],
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  void _getPhotoUrl() async {
    if (mounted) {
      setState(() {
        this._photoUrl = this.widget.img;
      });
    }
    // var url;
    // var subjects = [];
    // if (widget.title == LabelConstant.TV_CHOOSE_PLACE) {
    //   url = '?start=0&sort=U&range=0,10&countries=${widget.label}&tags=电视剧';
    //   subjects = await ClientAPI.getInstance().newSearchSubjects(url);
    // } else if (widget.title == LabelConstant.TV_CHOOSE_TYPE) {
    //   if (widget.label == '动漫' || widget.label == '纪录片') {
    //     url = '?start=0&sort=U&range=0,10&tags=${widget.label}';
    //   }
    //   if (widget.label == '喜剧' || widget.label == '科幻' || widget.label == '武侠' || widget.label == '历史') {
    //     url = '?start=0&sort=U&range=0,10&genres=${widget.label}&tags=电视剧';
    //   }
    //   if (widget.label == '青春' ||
    //       widget.label == '古装' ||
    //       widget.label == '探案' ||
    //       widget.label == '律政' ||
    //       widget.label == '医疗' ||
    //       widget.label == '政治') {
    //     url = '?start=0&sort=U&range=0,10&tags=电视剧,${widget.label}';
    //   }
    //   subjects = await ClientAPI.getInstance().newSearchSubjects(url);
    // } else if (widget.title == LabelConstant.TV_CHOOSE_TOPIC_CHANNEL) {
    //   url = "?start=0&sort=U&range=0,10&tags=电视剧,${widget.label}";
    //   subjects = await ClientAPI.getInstance().newSearchSubjects(url);
    // }
    // if (subjects.length > 0) {
    //   if (mounted) {
    //     setState(() {
    //       this._photoUrl = subjects[0]['cover'];
    //     });
    //   }
    // }
  }
}
