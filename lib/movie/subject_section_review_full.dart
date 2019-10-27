import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/movie_util.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/dom.dart' as dom;
import 'package:flutter_douban2/widget/rate_star.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_douban2/util/client_api.dart';

class SubjectSectionReviewFull extends StatefulWidget {
  final content;

  SubjectSectionReviewFull(this.content, {Key key}) : super(key: key);

  _SubjectSectionReviewFullState createState() => _SubjectSectionReviewFullState();
}

class _SubjectSectionReviewFullState extends State<SubjectSectionReviewFull> {
  var html;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var full = await ClientAPI.getInstance().fetchFullReview(this.widget.content['rid']);
    if (mounted)
      setState(() {
        html = full['html'];
      });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        padding: EdgeInsets.all(
          ScreenUtil.getInstance().setWidth(ScreenSize.padding),
        ),
        child: Column(
          children: <Widget>[
            _buildTitle(),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(ScreenSize.padding),
            ),
            _buildAuthor(),
            Expanded(
              child: SingleChildScrollView(
                child: _buildHtml(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Row(
        children: <Widget>[
          Container(
            width: kToolbarHeight - 10,
            height: kToolbarHeight - 10,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  this.widget.content['subject']['images']['small'],
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(kToolbarHeight)),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(this.widget.content['subject']['title']),
              RateStar(
                double.parse(this.widget.content['subject']['rating']['average'].toString()),
                labled: false,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      width: ScreenUtil.getInstance().setWidth(ScreenSize.width - ScreenSize.padding * 2),
      child: Text(
        this.widget.content['title'],
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAuthor() {
    return Row(
      children: <Widget>[
        MovieUtil.buildAuthorCover(this.widget.content['avator']),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.widget.content['name'] + " 的影评"),
            Row(
              children: <Widget>[
                RateStar(
                  double.parse(this.widget.content['ratingValue']),
                  min: 0,
                  max: 5,
                  labled: false,
                ),
                SizedBox(
                  width: ScreenUtil.getInstance().setWidth(ScreenSize.padding),
                ),
                Text(this._formatDate(this.widget.content['createdAt'])),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _buildHtml() {
    return Html(
      data: this.html == null ? '' : this.html,
      //Optional parameters:
      padding: EdgeInsets.all(8.0),
      backgroundColor: Colors.white70,
      defaultTextStyle: TextStyle(fontFamily: 'serif'),
      linkStyle: const TextStyle(
        color: Colors.redAccent,
      ),
      onLinkTap: (url) {
        // open url in a webview
      },
      onImageTap: (src) {
        // Display the image in large form.
      },
      //Must have useRichText set to false for this to work.
      // customRender: (node, children) {
      //   if (node is dom.Element) {
      //     // switch(node.localName) {
      //     //   case "video": return Chewie(...);
      //     //   case "custom_tag": return CustomWidget(...);
      //     // }
      //   }
      // },
      customTextAlign: (dom.Node node) {
        if (node is dom.Element) {
          switch (node.localName) {
            case "p":
              return TextAlign.justify;
          }
        }
        return TextAlign.justify;
      },
      customTextStyle: (dom.Node node, TextStyle baseStyle) {
        if (node is dom.Element) {
          switch (node.localName) {
            case "p":
              return baseStyle.merge(TextStyle(height: 2, fontSize: 20));
          }
        }
        return baseStyle;
      },
    );
  }

  String _formatDate(date) {
    var time = DateTime.parse(date);
    return "${time.year}年${time.month}月${time.day}日";
  }
}
