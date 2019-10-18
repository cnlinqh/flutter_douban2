import 'package:flutter/material.dart';
import 'package:flutter_douban2/util/label_constant.dart';
import 'package:flutter_douban2/util/screen_size.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/dom.dart' as dom;

class SubjectSectionReviewFull extends StatelessWidget {
  SubjectSectionReviewFull(this.html, {Key key}) : super(key: key);
  final html;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LabelConstant.MOVIE_PAGE_TITLE),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(
          ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ScreenUtil.getInstance().setHeight(ScreenSize.padding),
          ScreenUtil.getInstance().setWidth(ScreenSize.padding),
          ScreenUtil.getInstance().setHeight(ScreenSize.padding),
        ),
        child: SingleChildScrollView(
          child:  _buildHtml(),
        ),
      ),
    );
  }

  Widget _buildHtml() {
    return Html(
      data: this.html,
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
}
